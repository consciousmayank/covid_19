import 'package:covid19graphs/models/contacts_helpline.dart';
import 'package:covid19graphs/repository/repository.dart';

class ContactsRepo{
  MainRepository _client;

  ContactsRepo(){
    _client = MainRepository();
  }

  Future<ContactHelpline> getContactsAndHelpLine() async {
    return _client.getContactsAndHelpLine();
  }
}