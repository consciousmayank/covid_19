import 'package:covid19graphs/models/notification_advisory.dart'
    as modelNotifications;
import 'package:covid19graphs/models/notification_advisory.dart';
import 'package:covid19graphs/pages/pdf_view_page.dart';
import 'package:covid19graphs/repository/notification_advisory_repo.dart';
import 'package:covid19graphs/widget/header.dart';
import 'package:covid19graphs/widget/progress.dart';
import 'package:covid19graphs/widget/textfiledstyles.dart';
import 'package:covid19graphs/widget/themes.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  NotificationAdvisoryRepo _repo;
  bool isLoading = true;
  NotificationAdvisory _data;

  @override
  void initState() {
    _repo = NotificationAdvisoryRepo();
    _repo.getNotificationAndAdvisoryData().then((value) {
      if (value != null) {
        setState(() {
          _data = value;
          isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: header(
            context: context,
            title: "Notifications & advisories",
            textStyle: null,
            showBackArrow: false,
            actions: <Widget>[
              IconButton(
                color: Colors.white,
                tooltip: "Developer Info",
                icon: FaIcon(FontAwesomeIcons.info),
                iconSize: 15,
                onPressed: isLoading ? null : showDeveloperInfoDialog,
              )
            ]),
        body: isLoading
            ? circularProgressWithTextBelow("Loading. Please Wait...")
            : bodyWidget());
  }

  Widget bodyWidget() {
    var list = _data.data.notifications;
    modelNotifications.Notification lastUpdated =
        modelNotifications.Notification(
            title:
                "Data Last Refresed on : ${getCurrentDate(_data.lastRefreshed)}",
            link: null);
    list.add(lastUpdated);

    return ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            shape: getCustomBeveledRectangleBorder(8),
              child: ListTile(
            title: Text(
              list[index].title,
              style: list[index].link == null
                  ? TextStyle(fontWeight: FontWeight.bold)
                  : TextStyle(fontWeight: FontWeight.normal),
              textAlign:
                  list[index].link == null ? TextAlign.center : TextAlign.start,
            ),
            onTap: () {
              onNotificationsClicked(list[index]);
            },
          ));
        },
        itemCount: list.length);
  }

  Future<void> showDeveloperInfoDialog() {
    return showDialog<void>(
      context: _scaffoldKey.currentContext,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: getCustomBeveledRectangleBorder(35.0),
          title: Text('Credits'),
          content: Wrap(
            children: [
              ListTile(
                title: Text("Developed By : Mayank Joshi"),
//                subtitle: Text("From Embitel Technologies Pvt Ltd"),
//                onTap: () async {
//                  if (await canLaunch("https://www.embitel.com/")) {
//                    await launch("https://www.embitel.com/");
//                  }
//                },
              ),
              ListTile(
                title: Text(
                  "Data Taken from \"COVID Rest API for India "
                  "data, using Cloudflare Workers\"",
                  style:
                      textFieldStyle(fontSize: 14.0, textColor: Colors.black87),
                ),
                onTap: () async {
                  if (await canLaunch(
                      "https://github.com/amodm/api-covid19-in")) {
                    await launch("https://github.com/amodm/api-covid19-in");
                  }
                },
              ),
              ListTile(
                title: Text(
                  "App Icon Design by Saptrishi Das",
                  style:
                  textFieldStyle(fontSize: 14.0, textColor: Colors.black87),
                ),
              ),
              ListTile(
                title: Text(
                  "Application's name credit goes to Susheel Mishra",
                  style:
                  textFieldStyle(fontSize: 14.0, textColor: Colors.black87),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  String getCurrentDate(DateTime date) {
    return formatDate(date,
        [d, '' '-', MM, '' '-', yyyy, ' at ', hh, ':', nn, ':', ss, ':', am]);
  }

  void onNotificationsClicked(
      modelNotifications.Notification singleNotificationData) async {
    if (singleNotificationData.link == null) {
      return null;
    } else if (singleNotificationData.link.contains(".pdf")) {
      PDFDocument.fromURL(singleNotificationData.link).then((value) =>
          Navigator.push(_scaffoldKey.currentContext,
              MaterialPageRoute(builder: (context) {
            return PdfViewPage(value);
          })));
    } else {
      if (await canLaunch(singleNotificationData.link)) {
        await launch(singleNotificationData.link);
      }
    }
  }
}
