import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:openViewF1/data/models/driver.dart';
import 'package:openViewF1/data/models/position.dart';
import 'package:openViewF1/helpers/constants.dart';

class Session {
  int? circuitKey;
  String? circuitShortName;
  String? countryCode;
  int? countryKey;
  String? countryName;
  DateTime? dateEnd;
  DateTime? dateStart;
  String? gmtOffset;
  String? location;
  int? meetingKey;
  int? sessionKey;
  String? sessionName;
  String? sessionType;
  int? year;

  Session({
    this.circuitKey,
    this.circuitShortName,
    this.countryCode,
    this.countryKey,
    this.countryName,
    this.dateEnd,
    this.dateStart,
    this.gmtOffset,
    this.location,
    this.meetingKey,
    this.sessionKey,
    this.sessionName,
    this.sessionType,
    this.year,
  });

  factory Session.fromRawJson(String str) => Session.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        circuitKey: json["circuit_key"],
        circuitShortName: json["circuit_short_name"],
        countryCode: json["country_code"],
        countryKey: json["country_key"],
        countryName: json["country_name"],
        dateEnd:
            json["date_end"] == null ? null : DateTime.parse(json["date_end"]),
        dateStart: json["date_start"] == null
            ? null
            : DateTime.parse(json["date_start"]),
        gmtOffset: json["gmt_offset"],
        location: json["location"],
        meetingKey: json["meeting_key"],
        sessionKey: json["session_key"],
        sessionName: json["session_name"],
        sessionType: json["session_type"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "circuit_key": circuitKey,
        "circuit_short_name": circuitShortName,
        "country_code": countryCode,
        "country_key": countryKey,
        "country_name": countryName,
        "date_end": dateEnd?.toIso8601String(),
        "date_start": dateStart?.toIso8601String(),
        "gmt_offset": gmtOffset,
        "location": location,
        "meeting_key": meetingKey,
        "session_key": sessionKey,
        "session_name": sessionName,
        "session_type": sessionType,
        "year": year,
      };

  @override
  String toString() {
    return 'Session(circuitKey: $circuitKey, circuitShortName: $circuitShortName, countryCode: $countryCode, countryKey: $countryKey, countryName: $countryName, dateEnd: $dateEnd, dateStart: $dateStart, gmtOffset: $gmtOffset, location: $location, meetingKey: $meetingKey, sessionKey: $sessionKey, sessionName: $sessionName, sessionType: $sessionType, year: $year)';
  }
}

class SessionListItem extends StatelessWidget {
  final Session data;
  final List<Driver>? drivers;

  const SessionListItem({
    super.key,
    required this.data,
    this.drivers,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: pad8),
      child: Card.outlined(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(pad8),
              child: Column(
                children: [
                  Text(
                    '${data.sessionName}',
                    style: const TextStyle(
                        fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  Text(DateFormat.MMMEd().format(data.dateStart!)),
                  Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(pad8),
                      child: Text(
                          '${DateFormat.Hm().format(data.dateStart!)} - ${DateFormat.Hm().format(data.dateEnd!)}'),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 0),
            const ResultHeader(),
            const ResultPositionPlaceholder(),
            const ResultPositionPlaceholder(),
            const ResultPositionPlaceholder(),
            const Divider(height: 0),
            InkWell(
              onTap: () {
                context.goNamed('result');
              },
              child: Ink(
                color: Theme.of(context).secondaryHeaderColor,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: pad8),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View results',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _UiTop3() {
    return ListView();
  }
}
