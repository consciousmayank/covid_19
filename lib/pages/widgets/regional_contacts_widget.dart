import 'package:covid19graphs/models/contacts_helpline.dart';
import 'package:covid19graphs/pages/widgets/primary_contact_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsListWidget extends StatefulWidget {
  final ContactHelpline _helplineData;

  ContactsListWidget(this._helplineData);

  @override
  _ContactsListWidgetState createState() => _ContactsListWidgetState();
}

class _ContactsListWidgetState extends State<ContactsListWidget> {
  List<Regional> regional;

  @override
  void initState() {
    regional = widget._helplineData.data.contacts.regional;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView.builder(
          itemBuilder: (context, index) {
            if (index == 0) {
              // return the header
              return PrimaryContactWidget(
                  widget._helplineData.data.contacts.primary);
            }
            index -= 1;

            return Card(
                child: ListTile(
              title: Text(regional[index].loc),
              subtitle: Text(regional[index].number),
              onTap: () async {
                String phoneNumber = 'tel:${regional[index].number}';
                if (await canLaunch(phoneNumber)) {
                  await launch(phoneNumber);
                } else {
                  throw 'Could not launch $phoneNumber';
                }
              },
            ));
          },
          itemCount: regional == null ? 1 : regional.length + 1),
    );
  }
}
