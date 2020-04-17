// To parse this JSON data, do
//
//     final emergencyContacts = emergencyContactsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EmergencyContacts emergencyContactsFromJson(String str) => EmergencyContacts.fromJson(json.decode(str));

String emergencyContactsToJson(EmergencyContacts data) => json.encode(data.toJson());

class EmergencyContacts {
  final bool success;
  final Data data;
  final DateTime lastRefreshed;
  final DateTime lastOriginUpdate;

  EmergencyContacts({
    @required this.success,
    @required this.data,
    @required this.lastRefreshed,
    @required this.lastOriginUpdate,
  });

  factory EmergencyContacts.fromJson(Map<String, dynamic> json) => EmergencyContacts(
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
  final Contacts contacts;

  Data({
    @required this.contacts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    contacts: Contacts.fromJson(json["contacts"]),
  );

  Map<String, dynamic> toJson() => {
    "contacts": contacts.toJson(),
  };
}

class Contacts {
  final Primary primary;
  final List<Regional> regional;

  Contacts({
    @required this.primary,
    @required this.regional,
  });

  factory Contacts.fromJson(Map<String, dynamic> json) => Contacts(
    primary: Primary.fromJson(json["primary"]),
    regional: List<Regional>.from(json["regional"].map((x) => Regional.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "primary": primary.toJson(),
    "regional": List<dynamic>.from(regional.map((x) => x.toJson())),
  };
}

class Primary {
  final String number;
  final String numberTollfree;
  final String email;
  final String twitter;
  final String facebook;
  final List<String> media;

  Primary({
    @required this.number,
    @required this.numberTollfree,
    @required this.email,
    @required this.twitter,
    @required this.facebook,
    @required this.media,
  });

  factory Primary.fromJson(Map<String, dynamic> json) => Primary(
    number: json["number"],
    numberTollfree: json["number-tollfree"],
    email: json["email"],
    twitter: json["twitter"],
    facebook: json["facebook"],
    media: List<String>.from(json["media"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "number-tollfree": numberTollfree,
    "email": email,
    "twitter": twitter,
    "facebook": facebook,
    "media": List<dynamic>.from(media.map((x) => x)),
  };
}

class Regional {
  final String loc;
  final String number;

  Regional({
    @required this.loc,
    @required this.number,
  });

  factory Regional.fromJson(Map<String, dynamic> json) => Regional(
    loc: json["loc"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "loc": loc,
    "number": number,
  };
}
