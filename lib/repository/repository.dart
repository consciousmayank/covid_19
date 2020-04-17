import 'package:covid19graphs/models/contacts_helpline.dart';
import 'package:covid19graphs/models/history.dart';
import 'package:covid19graphs/models/latest_data.dart';
import 'package:covid19graphs/models/notification_advisory.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainRepository {
  final String _latestDataUrl = "https://api.rootnet.in/covid19-in/stats/latest";
  final String _contactHelplineDataUrl = "https://api.rootnet"
      ".in/covid19-in/contacts";
  final String _historyDataUrl = "https://api.rootnet"
      ".in/covid19-in/stats/history";
  final String _notificationAdvisoryUrl = "https://api.rootnet"
      ".in/covid19-in/notifications";


  Future<LatestStats> getLatestData() async {
    LatestStats _data;
    final http.Response response = await http.get(
      _latestDataUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    try{
      if(response.statusCode == 200) {
        _data = LatestStats.fromJson(json.decode(response.body));
      }else{
        _data = null;
      }
    }catch(e){
      throw Exception("$e.toString");
    }

    return _data;
  }

  Future<NotificationAdvisory> getNotificationAndAdvisoryData() async {
    NotificationAdvisory _data;

    final http.Response response = await http.get(
      _notificationAdvisoryUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    try{
      if(response.statusCode == 200) {
        _data = NotificationAdvisory.fromJson(json.decode(response.body));
      }else{
        _data = null;
      }
    }catch(e){
      throw Exception("$e.toString");
    }

    return _data;
  }

  Future<ContactHelpline> getContactsAndHelpLine() async {
    ContactHelpline _data;

    final http.Response response = await http.get(
      _contactHelplineDataUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    try{
      if(response.statusCode == 200) {
        _data = ContactHelpline.fromJson(json.decode(response.body));
      }else{
        _data = null;
      }
    }catch(e){
      throw Exception("$e.toString");
    }

    return _data;
  }

  Future<History> getHistoryData() async {
    History _data;

    final http.Response response = await http.get(
      _historyDataUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    try{
      if(response.statusCode == 200) {
        _data = History.fromJson(json.decode(response.body));
      }else{
        _data = null;
      }
    }catch(e){
      throw Exception("$e.toString");
    }

    return _data;
  }
}
