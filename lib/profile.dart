import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'messaging.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => new ProfileState();
}

class ProfileState extends State<Profile> {
  String _id = '';
  String _name = '';
  String _email = '';
  String _photoURL = '';

  var messaging = Messaging();

  @override
  void initState() {
    super.initState();
    _readLocal();
  }

  void _readLocal() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _id = prefs.getString('id')!;
      _name = prefs.getString('name')!;
      _email = prefs.getString('email')!;
      _photoURL = prefs.getString('photoURL')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Center (
      child: TextButton(
        child: Text('push'),
        onPressed: () => messaging.sendDataToFirebase(),
      )
    );
  }
}
