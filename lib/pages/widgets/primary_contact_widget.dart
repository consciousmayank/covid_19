import 'package:covid19graphs/models/contacts_helpline.dart';
import 'package:covid19graphs/widget/themes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PrimaryContactWidget extends StatelessWidget {
  final Primary primaryContactData;

  PrimaryContactWidget(this.primaryContactData);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: getCustomBeveledRectangleBorder(15.0),
      child: Column(
        children: [
          ListTile(
            leading: FaIcon(FontAwesomeIcons.phoneAlt),
            title: Text("Primary Number"),
            subtitle: Text(primaryContactData.number),
            onTap: () {
              onPhoneLinkClick(primaryContactData.number);
            },
          ),

          ListTile(
            leading: FaIcon(FontAwesomeIcons.phone),
            title: Text("Toll-Free Number"),
            subtitle: Text(primaryContactData.numberTollfree),
            onTap: () {
              onPhoneLinkClick(primaryContactData.numberTollfree);
            },
          ),

          ListTile(
            leading: FaIcon(FontAwesomeIcons.mailBulk),
            title: Text("email"),
            subtitle: Text(primaryContactData.email),
            onTap: () {
              onUrlLinkClick(primaryContactData.email);
            },
          ),


          ListTile(
            leading: FaIcon(FontAwesomeIcons.twitter),
            title: Text("Twitter"),
            subtitle: Text(primaryContactData.twitter),
            onTap: () {
              onUrlLinkClick(primaryContactData.twitter);
            },
          ),


          ListTile(
            title: Text("FaceBook"),
            leading: FaIcon(FontAwesomeIcons.facebook),
            subtitle: Text(primaryContactData.facebook),
            onTap: () {
              onUrlLinkClick(primaryContactData.facebook);
            },
          ),


        ],
      ),
    );
  }

  onPhoneLinkClick(String link) async {
    String phoneNumber = 'tel:$link';
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  onUrlLinkClick(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }
}
