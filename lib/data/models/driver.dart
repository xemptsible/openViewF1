import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:openViewF1/helpers/constants.dart';

class Driver {
  String? broadcastName;
  String? countryCode;
  int? driverNumber;
  String? firstName;
  String? fullName;
  String? headshotUrl;
  String? lastName;
  int? meetingKey;
  String? nameAcronym;
  int? sessionKey;
  String? teamColour;
  String? teamName;

  Driver({
    this.broadcastName,
    this.countryCode,
    this.driverNumber,
    this.firstName,
    this.fullName,
    this.headshotUrl,
    this.lastName,
    this.meetingKey,
    this.nameAcronym,
    this.sessionKey,
    this.teamColour,
    this.teamName,
  });

  factory Driver.fromRawJson(String str) => Driver.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        broadcastName: json["broadcast_name"],
        countryCode: json["country_code"],
        driverNumber: json["driver_number"],
        firstName: json["first_name"],
        fullName: json["full_name"],
        headshotUrl: json["headshot_url"],
        lastName: json["last_name"],
        meetingKey: json["meeting_key"],
        nameAcronym: json["name_acronym"],
        sessionKey: json["session_key"],
        teamColour: json["team_colour"],
        teamName: json["team_name"],
      );

  Map<String, dynamic> toJson() => {
        "broadcast_name": broadcastName,
        "country_code": countryCode,
        "driver_number": driverNumber,
        "first_name": firstName,
        "full_name": fullName,
        "headshot_url": headshotUrl,
        "last_name": lastName,
        "meeting_key": meetingKey,
        "name_acronym": nameAcronym,
        "session_key": sessionKey,
        "team_colour": teamColour,
        "team_name": teamName,
      };
}

class APIDriverInfo {
  Future getDriverInfo({dynamic queryParams}) async {
    List<Driver> data = [];
    final dynamic defaultQueryParams = {
      'session_key': 'latest',
    };

    Uri uri = Uri.https(
      openF1Url,
      '$version/drivers',
      queryParams ?? defaultQueryParams,
    );

    try {
      final response = await http.get(uri, headers: {
        HttpHeaders.contentTypeHeader: ContentType.json.toString()
      });
      data = List.from(jsonDecode(response.body));
    } on Exception {
      rethrow;
    }

    return data;
  }
}

class DriverWidget extends StatelessWidget {
  const DriverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
