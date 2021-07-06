import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  _register(var values) async {
    print(values);

    var url = Uri.parse('https://api.codingthailand.com/api/register');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: convert.jsonEncode({
        'name': values['name'],
        'email': values['email'],
        'password': values['password'],
        'dob': values['dob'].toString().substring(0, 10)
      })

    );

    var bodw = convert.jsonDecode(response.body);

    if (response.statusCode == 201){
      print(response.body);
      print(bodw['message']);
      final snackBar = SnackBar(content: Text(bodw['message']));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Future.delayed(Duration(seconds: 3),(){
        Navigator.pop(context);
      });

    }else {
      print(bodw['errors']);
      print(values['dob'].toString().substring(0, 10));
      final snackBar2 = SnackBar(content: Text('error'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register'),),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black,
              Colors.red,
            ]
          )
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
            children: [
              // Text('Login1', style: TextStyle(fontSize: 20,color: Colors.white)),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: FormBuilder(
                    key: _formKey,
                    initialValue: {
                      'name': '',
                      'email': '',
                      'password': '',
                      'dob': '',
                    },
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'name',
                          decoration: InputDecoration(
                              labelText: 'Name',
                              fillColor: Colors.white,
                              filled: true ,
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                          ),
                          // onChanged: _onChanged,
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context, errorText: 'please insert Name'),
                            // FormBuilderValidators.numeric(context),
                            // FormBuilderValidators.email(context),
                            // FormBuilderValidators.max(context, 70),
                          ]),
                           keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 20,),
                        FormBuilderTextField(
                          name: 'email',
                          decoration: InputDecoration(
                            labelText: 'Email',
                            fillColor: Colors.white,
                            filled: true ,
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                          ),
                          // onChanged: _onChanged,
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context, errorText: 'please insert email'),
                            // FormBuilderValidators.numeric(context),
                            FormBuilderValidators.email(context),
                            // FormBuilderValidators.max(context, 70),
                          ]),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20,),
                        FormBuilderTextField(
                          name: 'password',
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            fillColor: Colors.white,
                            filled: true,
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                          ),
                          // onChanged: _onChanged,
                          // valueTransformer: (text) => num.tryParse(text),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context, errorText: 'please insert password'),
                            // FormBuilderValidators.numeric(context),
                            // FormBuilderValidators.email(context),
                            FormBuilderValidators.minLength(context, 8, errorText: 'min length 8 character'),
                          ]),
                          // keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20,),

                        FormBuilderDateTimePicker(
                          name: 'dob',
                          // onChanged: _onChanged,
                          inputType: InputType.date,
                          format: DateFormat('yyyy-MM-dd'),
                          decoration: InputDecoration(
                            labelText: 'Birth Date',
                              fillColor: Colors.white,
                              filled: true ,
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                          ),
                          // initialTime: TimeOfDay(hour: 8, minute: 0),
                          initialValue: DateTime.now(),
                          // enabled: true,
                        ),
                        SizedBox(height: 15),

                        SizedBox(
                          width: 200,
                          child: MaterialButton(
                            color: Theme.of(context).accentColor,
                            child: Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                // print(_formKey.currentState!.value);
                                _register(_formKey.currentState!.value);
                              } else {
                                print("validation failed");
                              }
                            },
                          ),
                        ),



                      ],
                    ),
                  ),

              ),
            ],)
          ),
        ),
      ),
    );
  }
}
