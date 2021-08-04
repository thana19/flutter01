import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  late SharedPreferences prefs;

  _initPref() async {
    prefs = await SharedPreferences.getInstance();
    // int counter = (prefs.getInt('counter') ?? 0) + 1;
    // print('Pressed $counter times.');
    // await prefs.setInt('counter', counter);
  }

  @override
  void initState() {
    super.initState();
    _initPref();
  }

  _login(var values) async {
    // print(values);
    setState(() {
      isLoading = true;
    });

    var url = Uri.parse('https://api.codingthailand.com/api/login');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: convert.jsonEncode(
            {'email': values['email'], 'password': values['password']}));

    var body = convert.jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      // print(response.body);
      // print(body['access_token']);
      final snackBar = SnackBar(content: Text(body['access_token']));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      //save token to pref
      await prefs.setString('token', response.body);
      print(prefs.getString('token'));
      //get profile
      _getProfile();

      //open home
      Navigator.pushNamedAndRemoveUntil(
          context, '/homestack', (Route<dynamic> route) => false);

      // Future.delayed(Duration(seconds: 3),(){
      //   Navigator.pop(context);
      // });

    } else {
      setState(() {
        isLoading = false;
      });
      print(body['message']);

      final snackBar2 = SnackBar(content: Text(body['message']));
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
    }
  }

  Future<void> _getProfile() async {
    //get token from pref
    var tokenString = prefs.getString('token');
    var token = convert.jsonDecode(tokenString!);
    print(token['access_token']);

    //http get profile
    var url = Uri.parse('https://api.codingthailand.com/api/profile');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token['access_token']}',
      },
    );
    var body = convert.jsonDecode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      await prefs.setString(
          'profile', convert.jsonEncode(body['data']['user']));
      print('pref profile');
      print(prefs.getString('profile'));
    } else {
      print(response.body);
      print(body['message']);
    }

    //save profile to pref
    // await prefs.setString('user', body['data']['user']);
  }

  @override
  Widget build(BuildContext context) {
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
              Text('Login',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              Padding(
                padding: EdgeInsets.all(10),
                child: FormBuilder(
                  key: _formKey,
                  initialValue: {'email': '', 'password': ''},
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'email',
                        decoration: InputDecoration(
                            labelText: 'Email',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        // onChanged: _onChanged,
                        // valueTransformer: (text) => num.tryParse(text),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: 'please insert email'),
                          // FormBuilderValidators.numeric(context),
                          FormBuilderValidators.email(context),
                          // FormBuilderValidators.max(context, 70),
                        ]),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FormBuilderTextField(
                        name: 'password',
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                        // onChanged: _onChanged,
                        // valueTransformer: (text) => num.tryParse(text),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(context,
                              errorText: 'please insert password'),
                          // FormBuilderValidators.numeric(context),
                          // FormBuilderValidators.email(context),
                          FormBuilderValidators.minLength(context, 8,
                              errorText: 'min length 8 character'),
                        ]),
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
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              print(_formKey.currentState!.value);
                              _login(_formKey.currentState!.value);
                            } else {
                              print("validation failed");
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: MaterialButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                },
                                child: Text('Register',
                                    style: TextStyle(color: Colors.white))),
                          ),
                          Expanded(
                            child: MaterialButton(
                                onPressed: () {},
                                child: Text('forgot password',
                                    style: TextStyle(color: Colors.white))),
                          )
                        ],
                      )
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
