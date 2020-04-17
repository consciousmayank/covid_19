import 'package:covid19graphs/models/notification_advisory.dart';
import 'package:covid19graphs/repository/repository.dart';

class NotificationAdvisoryRepo{
  MainRepository _client;

  NotificationAdvisoryRepo(){
    _client = MainRepository();
  }

  Future<NotificationAdvisory> getNotificationAndAdvisoryData() async {
    return _client.getNotificationAndAdvisoryData();
  }
}