import 'package:covid19graphs/models/contacts_helpline.dart';
import 'package:covid19graphs/pages/widgets/regional_contacts_widget.dart';
import 'package:covid19graphs/repository/contacts_repo.dart';
import 'package:covid19graphs/widget/header.dart';
import 'package:covid19graphs/widget/progress.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ContactsRepo _repo;
  bool isLoading = true;
  ContactHelpline _helplineData;

  @override
  void initState() {
    _repo = ContactsRepo();
    _repo.getContactsAndHelpLine().then((value) {
      setState(() {
        _helplineData = value;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: header(
          context: context,
          title: "Contact & helpline",
          textStyle: null,
          showBackArrow: false,
          actions: null,
        ),
        body: isLoading
            ? circularProgressWithTextBelow("Loading. Please Wait...")
            : bodyWidget());
  }

  Widget bodyWidget() {
    return Column(
      children: [
        ContactsListWidget(_helplineData)
      ],
    );
  }
}
