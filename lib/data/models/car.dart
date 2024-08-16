import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:openViewF1/helpers/constants.dart';

/* 
  https://github.com/theOehrly/Fast-F1/blob/317bacf8c61038d7e8d0f48165330167702b349f/fastf1/_api.py#L855
  - Date (pandas.Timestamp): timestamp for this sample as Date + Time; more or less exact
  - Speed (int): Km/h
  - RPM (int)
  - Gear (int): [called 'nGear' in the data!]
  - Throttle (int): 0-100%
  - Brake (bool) or (int): 0 and 100 in this API
  - DRS (int): 0-14 (Odd DRS is Disabled, Even DRS is Enabled?)
  - 0 =  Off
  - 1 =  Off
  - 2 =  (?)
  - 3 =  (?)
  - 8 =  Detected, Eligible once in Activation Zone (Noted Sometimes)
  - 10 = On (Unknown Distinction)
  - 12 = On (Unknown Distinction)
  - 14 = On (Unknown Distinction) 
*/

class Car {
  int? driverNumber;
  int? rpm;
  int? speed;
  int? nGear;
  int? throttle;
  int? brake;
  int? drs;
  DateTime? date;
  int? sessionKey;
  int? meetingKey;

  Car({
    this.driverNumber,
    this.rpm,
    this.speed,
    this.nGear,
    this.throttle,
    this.brake,
    this.drs,
    this.date,
    this.sessionKey,
    this.meetingKey,
  });

  factory Car.fromRawJson(String str) => Car.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        driverNumber: json["driver_number"],
        rpm: json["rpm"],
        speed: json["speed"],
        nGear: json["n_gear"],
        throttle: json["throttle"],
        brake: json["brake"],
        drs: json["drs"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        sessionKey: json["session_key"],
        meetingKey: json["meeting_key"],
      );

  Map<String, dynamic> toJson() => {
        "driver_number": driverNumber,
        "rpm": rpm,
        "speed": speed,
        "n_gear": nGear,
        "throttle": throttle,
        "brake": brake,
        "drs": drs,
        "date": date?.toIso8601String(),
        "session_key": sessionKey,
        "meeting_key": meetingKey,
      };

  @override
  String toString() {
    return 'Car(driverNumber: $driverNumber, rpm: $rpm, speed: $speed, nGear: $nGear, throttle: $throttle, brake: $brake, drs: $drs, date: $date, sessionKey: $sessionKey, meetingKey: $meetingKey)';
  }
}

class APICarData {
  List<Car> data = [];
  Future getCarData({dynamic queryParams}) async {
    final dynamic defaultQueryParams = {
      'session_key': 'latest',
      'speed>': '340',
      'driver_number': '44',
    };

    Uri uri = Uri.https(
      openF1Url,
      '$version/car_data',
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

class WidgetCarData extends StatelessWidget {
  const WidgetCarData({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
