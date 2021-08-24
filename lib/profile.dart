import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

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
  List<String> allergies = [];

  var messaging = Messaging();

  @override
  void initState() {
    _readLocal();
    super.initState();
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
  Future<void> _getAllergens() async {
    await messaging.getDataFromFirebase(_id).then((map) {
      allergies = map.value['allergies'].split(String.fromCharCode(0x1B));
    });
  }

  Future<void> _showSearchDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Enter your allergen'
          ),
          content: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
            ),
            onSubmitted: (value) {
              setState(() {
                allergies.add(value[0].toUpperCase() + value.substring(1));
                messaging.sendDataToFirebase(_id, _name, _email, _photoURL, allergies);
                Navigator.of(context).pop(true);
              });
            },
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: Color(0xffF0F0F0),
      ),
      child: ListView(
        children: <Widget>[
          Stack(
            children: <Widget> [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent,
                      Colors.lightBlue,
                    ],
                  ),
                ),
              ),
              _photoURL != '' ? Container(
                padding: const EdgeInsets.fromLTRB(20.0, 35.0, 0.0, 0.0),
                child: CachedNetworkImage(
                  imageUrl: _photoURL,
                  imageBuilder: (context, url) => Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: url, fit: BoxFit.cover
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ) : Container(),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Center(
                    child: Text(
                      _name,
                      textAlign: TextAlign.right,
                      style: new TextStyle(
                        fontSize: 36.0,
                        fontFamily: 'Lato',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: new BoxDecoration(
                color: Colors.white,
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: <Widget>[
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Allergens',
                          style: new TextStyle(
                            fontSize: 28.0,
                            fontFamily: 'Lato',
                            color: Color(0xff666666),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: Color(0xff666666),
                          ),
                          onPressed: () => _showSearchDialog(),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  FutureBuilder(
                    future: _getAllergens(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: allergies.length,
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                          itemBuilder: (context, index) {
                            final item = allergies[index];
                            return Dismissible(
                              key: Key(item),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                setState(() {
                                  allergies.removeAt(index);
                                  messaging.sendDataToFirebase(_id, _name, _email, _photoURL, allergies);
                                });
                              },
                              background: Container(
                                padding: EdgeInsets.only(right: 20.0),
                                alignment: Alignment.centerRight,
                                color: Colors.red,
                                child: Text(
                                  'Delete',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              child: ListTile(
                                title: Text(
                                  item,
                                  style: TextStyle(
                                    color: Color(0xff666666),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  allergies.length != 0 ? Divider() : Container(),
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}
