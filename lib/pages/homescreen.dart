import 'package:covid19graphs/pages/contacts_page.dart';
import 'package:covid19graphs/widget/textfiledstyles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'notifications.dart';
import 'latest_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _curIndex = 0;
  Widget bodyContent;
  Widget tempBodyContent;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String usersCurrentState;

  @override
  void initState() {
    bodyContent = LatestData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          alignment: Alignment.center,
          child: bodyContent,
        ),
        bottomNavigationBar: _bottomNavigation());
  }

  Widget _bottomNavigation() => BottomNavigationBar(
        backgroundColor: Theme.of(context).accentColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.landmark,
              size: 20,
              color: Colors.white,
            ),
            title: Text(
              "Latest",
              style: textFieldStyle(
                  fontSize: 20,
                  textColor: _curIndex == 0 ? Colors.yellow : Colors.white),
            ),
            activeIcon: Icon(
              FontAwesomeIcons.landmark,
              size: 20,
              color: Colors.yellow,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.handsHelping,
              size: 20,
              color: Colors.white,
            ),
            title: Text(
              "Helpline",
              style: textFieldStyle(
                  fontSize: 20,
                  textColor: _curIndex == 1 ? Colors.yellow : Colors.white),
            ),
            activeIcon: Icon(
              FontAwesomeIcons.handsHelping,
              size: 20,
              color: Colors.yellow,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              size: 20,
              color: Colors.white,
            ),
            title: Text(
              "Notification",
              style: textFieldStyle(
                  fontSize: 20,
                  textColor: _curIndex == 2 ? Colors.yellow : Colors.white),
            ),
            activeIcon: Icon(
              Icons.notifications,
              size: 20,
              color: Colors.yellow,
            ),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _curIndex,
        onTap: (index) {
          setState(() {
            _curIndex = index;
            switch (_curIndex) {
              case 0:
                bodyContent = LatestData();
                break;
              case 1:
                bodyContent = ContactsPage();
                break;
              case 2:
                bodyContent = NotificationsScreen();
                break;
            }
          });
        },
      );
}
