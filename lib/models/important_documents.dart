// To parse this JSON data, do
//
//     final importantDocuments = importantDocumentsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ImportantDocuments importantDocumentsFromJson(String str) => ImportantDocuments.fromJson(json.decode(str));

String importantDocumentsToJson(ImportantDocuments data) => json.encode(data.toJson());

class ImportantDocuments {
  final bool success;
  final Data data;
  final DateTime lastRefreshed;
  final DateTime lastOriginUpdate;

  ImportantDocuments({
    @required this.success,
    @required this.data,
    @required this.lastRefreshed,
    @required this.lastOriginUpdate,
  });

  factory ImportantDocuments.fromJson(Map<String, dynamic> json) => ImportantDocuments(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    lastRefreshed: DateTime.parse(json["lastRefreshed"]),
    lastOriginUpdate: DateTime.parse(json["lastOriginUpdate"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "lastRefreshed": lastRefreshed.toIso8601String(),
    "lastOriginUpdate": lastOriginUpdate.toIso8601String(),
  };
}

class Data {
  final List<Notification> notifications;

  Data({
    @required this.notifications,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notifications: List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notifications": List<dynamic>.from(notifications.map((x) => x.toJson())),
  };
}

class Notification {
  final String title;
  final String link;

  Notification({
    @required this.title,
    @required this.link,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    title: json["title"],
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "link": link,
  };
}
