import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => new LoginState();
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.lightBlue,
                  Colors.blueAccent,
                ],
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30.0),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('images/allergyai_logo.png'),
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 30.0),
                alignment: Alignment.center,
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.grey,
                  side: BorderSide(
                      color: Colors.grey
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget> [
                    Container (
                      child: Image.asset(
                        'images/google_logo.png',
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                    Container(
                      child: Text(
                        'Sign in with Google',
                        style: new TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF757575),
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/dashboard');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}