import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'log.dart';
import 'profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
    required this.cameras,
  }) : super(key: key);
  final List<CameraDescription> cameras;

  @override
  DashboardState createState() => new DashboardState();
}

class DashboardState extends State<Dashboard> {
  late PageController _pageController;
  int _page = 1;
  var _navigationBarColors = [Color(0xff3A3B3C), Color(0xff3A3B3C), Color(0xff3A3B3C)];

  @override
  void initState() {
    super.initState();
    _pageController = new PageController(
      initialPage: 1,
    );
    _navigationBarColors[_page] = Color(0xffAA4465);
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
      _navigationBarColors[_page] = Color(0xff3A3B3C);
      this._page = page;
      _navigationBarColors[_page] = Theme.of(context).accentColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          bottomAppBarColor: Theme.of(context).backgroundColor,
          canvasColor: Theme.of(context).backgroundColor,
        ),
        child: new BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: navigationTapped,
          currentIndex: _page,
          items: [
            new BottomNavigationBarItem(
              icon: new Icon(
                Icons.view_headline,
                color: _navigationBarColors[0],
              ),
              label: 'Info',
            ),
            new BottomNavigationBarItem(
              icon: new Icon(
                Icons.home_outlined,
                color: _navigationBarColors[1],
              ),
              label: 'Camera',
            ),
            new BottomNavigationBarItem(
              icon: new Icon(
                Icons.person_outline_sharp,
                color: _navigationBarColors[2],
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: new PageView(
        children: [
          new Log(),
          new Home(cameras: widget.cameras),
          new SafeArea(child: Profile()),
        ],
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
      ),
    );
  }
}