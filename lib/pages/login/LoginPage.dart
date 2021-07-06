import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

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
            ]
          )
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
            children: [
              Image (
                image: AssetImage('images/akira2.png'),
                height: 100,
              ),
              Text('Login', style: TextStyle(fontSize: 20,color: Colors.white)),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: FormBuilder(
                    key: _formKey,
                    initialValue: {
                      'email': '',
                      'password': ''
                    },
                    child: Column(
                      children: [
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
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
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
                                  child: Text('Register', style: TextStyle(color: Colors.white))),
                                ),
                            Expanded(
                              child: MaterialButton(
                                  onPressed: () {

                                  },
                                  child: Text('forgot password', style: TextStyle(color: Colors.white))),
                            )
                          ],
                        )

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
