import 'package:covid19graphs/pages/contacts_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'latest_data.dart';
import 'notifications.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _curIndex = 0;
  Widget bodyContent;
  Widget tempBodyContent;

  String usersCurrentState;
  @override
  void initState() {
    bodyContent = LatestData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              style: TextStyle(
                  fontSize: 20,
                  color: _curIndex == 0 ? Colors.yellow : Colors.white),
            ),
            activeIcon: Icon(
              FontAwesomeIcons.landmark,
              size: 20,
              color: Colors.yellow,
            ),
          ),
          //          BottomNavigationBarItem(
          //            icon: Icon(
          //              FontAwesomeIcons.history,
          //              size: 20,
          //              color: Colors.white,
          //            ),
          //            title: Text(
          //              "History",
          //              style: TextStyle(
          //                  fontSize: 20,
          //                  color: _curIndex == 1 ? Colors.yellow : Colors.white),
          //            ),
          //            activeIcon: Icon(
          //              FontAwesomeIcons.history,
          //              size: 20,
          //              color: Colors.yellow,
          //            ),
          //          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.handsHelping,
              size: 20,
              color: Colors.white,
            ),
            title: Text(
              "Helpline",
              style: TextStyle(
                  fontSize: 20,
                  color: _curIndex == 1 ? Colors.yellow : Colors.white),
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
              style: TextStyle(
                  fontSize: 20,
                  color: _curIndex == 2 ? Colors.yellow : Colors.white),
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
              //              case 1:
              //                bodyContent = HistoryPage();
              //                break;
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
