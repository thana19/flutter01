import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter01/data/ScreenArguments.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  late SharedPreferences prefs;

  _initPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    _initPref();
  }

  _updateProfile(var values) async {
    // print(values);
    setState(() {
      isLoading = true;
    });

    var tokenString = prefs.getString('token');
    var token = convert.jsonDecode(tokenString!);
    print(token['access_token']);

    var url = Uri.parse('https://api.codingthailand.com/api/editprofile');
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token['access_token']}',
        },
        body: convert.jsonEncode({'name': values['name']}));

    var body = convert.jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

      //save profile to pref
      await prefs.setString(
          'profile', convert.jsonEncode(body['data']['user']));

      //open home
      Navigator.pushNamedAndRemoveUntil(
          context, 'homestack/home', (Route<dynamic> route) => false);
    } else {
      setState(() {
        isLoading = false;
      });
      print(body['message']);

      final snackBar2 = SnackBar(content: Text(body['message']));
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final contact =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Colors.black,
              Colors.red,
            ])),
        child: Center(
          child: SingleChildScrollView(
              child: Column(
            children: [
              Image(
                image: AssetImage('images/akira2.png'),
                height: 100,
              ),
              Text('Edit Profile',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              Padding(
                padding: EdgeInsets.all(10),
                child: FormBuilder(
                  key: _formKey,
                  initialValue: {'name': contact.email},
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'name',
                        decoration: InputDecoration(
                            labelText: 'Name',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        // onChanged: _onChanged,
                        // valueTransformer: (text) => num.tryParse(text),
                        // validator: FormBuilderValidators.compose([
                        //   FormBuilderValidators.required(context,
                        //       errorText: 'please insert email'),
                        //   // FormBuilderValidators.numeric(context),
                        //   FormBuilderValidators.email(context),
                        //   // FormBuilderValidators.max(context, 70),
                        // ]),
                        // keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200,
                        child: MaterialButton(
                          color: Theme.of(context).accentColor,
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              print(_formKey.currentState!.value);
                              _updateProfile(_formKey.currentState!.value);
                            } else {
                              print("validation failed");
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
