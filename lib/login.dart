import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'authentication.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => new LoginState();
}

class LoginState extends State<Login> {
  var auth = new Authentication();
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 90.0),
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
                  Image(
                    image: AssetImage('images/allergyai_logo.png'),
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    'ALLERGY AI',
                    style: new TextStyle(
                        fontSize: 32.0,
                        fontFamily: 'Lato',
                        color: Color(0xff1E96FF),
                    ),
                  ),
                ],
              )
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!value.contains('@')) {
                              return 'Please include an \'@\' in the email address';
                            }
                            _email = value;
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(23.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 0.0,
                              ),
                            ),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 23.0
                            ),
                            hintText: 'Email',
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(23.0),
                        ),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blueAccent,
                            Colors.lightBlue,
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            _password = value;
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(23.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 0.0,
                              ),
                            ),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 23.0
                            ),
                            hintText: 'Password',
                          ),
                          obscureText: true,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(23.0),
                        ),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blueAccent,
                            Colors.lightBlue,
                          ],
                        ),
                        border: Border.all(
                            color: Colors.white
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blueAccent,
                              Colors.lightBlue,
                            ],
                            begin: FractionalOffset.centerLeft,
                            end: FractionalOffset.centerRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(23.0)),
                        ),
                        child: TextButton(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print('Email: ' + _email);
                              print('Password: ' + _password);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data')),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(),
                  ),
                  Text(
                    'or',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Divider(),
                  ),
                ],
              ),
            ),
            TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Image.asset(
                    'images/google_logo.png',
                    height: 20.0,
                    width: 20.0,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    'Sign in with Google',
                    style: new TextStyle(
                      fontSize: 14.0,
                      color: Color(0xff3A3B3C),
                    ),
                  ),
                ],
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
              ),
              onPressed: () => auth.signInGoogle(context),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: <Widget>[
                    Text(
                        'New to Allergy AI?'
                    ),
                    TextButton(
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.lightBlue,
                        ),
                      ),
                      onPressed: () {print('register');},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}