import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'info.dart';
import 'profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
    required this.camera,
  }) : super(key: key);
  final CameraDescription camera;
  @override
  DashboardState createState() => new DashboardState();
}

class DashboardState extends State<Dashboard> {
  late PageController _pageController;

  int _page = 1;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController(
      initialPage: 1,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 250), curve: Curves.easeInOut
    );
  }
  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          bottomAppBarColor: Colors.white,
          canvasColor: Theme.of(context).primaryColor,
        ),
        child: new BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: navigationTapped,
          currentIndex: _page,
          items: [
            new BottomNavigationBarItem(
              icon: new Icon(
                Icons.local_hospital_outlined,
                color: Theme.of(context).accentColor,
              ),
              label: 'Info',
            ),
            new BottomNavigationBarItem(
              icon: new Icon(
                Icons.home_outlined,
                color: Theme.of(context).accentColor,
              ),
              label: 'Camera',
            ),
            new BottomNavigationBarItem(
              icon: new Icon(
                Icons.person_outline_sharp,
                color: Theme.of(context).accentColor,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: new PageView(
        children: [
          new Info(),
          new Home(camera: widget.camera),
          new Profile(),
        ],
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
      ),
    );
  }
}