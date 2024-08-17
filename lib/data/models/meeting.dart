import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:openViewF1/helpers/constants.dart';

class Meeting {
  int? circuitKey;
  String? circuitShortName;
  String? countryCode;
  int? countryKey;
  String? countryName;
  DateTime? dateStart;
  String? gmtOffset;
  String? location;
  int? meetingKey;
  String? meetingName;
  String? meetingOfficialName;
  int? year;

  Meeting({
    this.circuitKey,
    this.circuitShortName,
    this.countryCode,
    this.countryKey,
    this.countryName,
    this.dateStart,
    this.gmtOffset,
    this.location,
    this.meetingKey,
    this.meetingName,
    this.meetingOfficialName,
    this.year,
  });

  factory Meeting.fromRawJson(String str) => Meeting.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
        circuitKey: json["circuit_key"],
        circuitShortName: json["circuit_short_name"],
        countryCode: json["country_code"],
        countryKey: json["country_key"],
        countryName: json["country_name"],
        dateStart: json["date_start"] == null
            ? null
            : DateTime.parse(json["date_start"]),
        gmtOffset: json["gmt_offset"],
        location: json["location"],
        meetingKey: json["meeting_key"],
        meetingName: json["meeting_name"],
        meetingOfficialName: json["meeting_official_name"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "circuit_key": circuitKey,
        "circuit_short_name": circuitShortName,
        "country_code": countryCode,
        "country_key": countryKey,
        "country_name": countryName,
        "date_start": dateStart?.toIso8601String(),
        "gmt_offset": gmtOffset,
        "location": location,
        "meeting_key": meetingKey,
        "meeting_name": meetingName,
        "meeting_official_name": meetingOfficialName,
        "year": year,
      };
}

class MeetingListItem extends StatelessWidget {
  final Meeting data;

  const MeetingListItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        dynamic queryParams = {
          'country_name': data.countryName,
          'year': data.year.toString(),
        };
        context.go('/session/${data.year}/${data.countryName!.toLowerCase()}',
            extra: queryParams);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: pad16, horizontal: pad8),
        child: Row(
          children: [
            Card(
              elevation: 5,
              child: Image.asset(
                '$imageAssetPath/${data.countryCode}.png',
                fit: BoxFit.cover,
                height: 70,
                width: 100,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: pad16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.clip,
                      '${data.countryName}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text('${data.meetingName}'),
                    Text(DateFormat.MMMd().format(data.dateStart!)),
                  ],
                ),
              ),
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
