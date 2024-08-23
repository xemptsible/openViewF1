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
          'year': data.year.toString(),
          'country_name': data.countryName,
        };
        context.goNamed('session', queryParameters: queryParams);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: pad16, horizontal: pad8),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  '$imageAssetPath/${data.countryCode}.png',
                  fit: BoxFit.cover,
                  height: 80,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Card.outlined(
                          child: Padding(
                            padding: const EdgeInsets.all(pad4),
                            child: Text(
                              DateFormat.MMMd().format(data.dateStart!),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card.outlined(
                          child: Padding(
                            padding: const EdgeInsets.all(pad4),
                            child: Text(
                              DateFormat(DateFormat.HOUR24_MINUTE)
                                  .format(data.dateStart!),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: pad8),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data.countryName}',
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${data.circuitShortName}',
                            ),
                          ],
                        ),
                        const Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_forward),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MeetingGridItem extends StatelessWidget {
  final Meeting data;

  const MeetingGridItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          dynamic queryParams = {
            'year': data.year.toString(),
            'country_name': data.countryName,
          };
          context.goNamed('session', queryParameters: queryParams);
        },
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                '$imageAssetPath/${data.countryCode}.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: pad4),
              child: Row(
                children: [
                  Expanded(
                    child: Card.outlined(
                      child: Padding(
                        padding: const EdgeInsets.all(pad4),
                        child: Text(
                          DateFormat.MMMd().format(data.dateStart!),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card.outlined(
                      child: Padding(
                        padding: const EdgeInsets.all(pad4),
                        child: Text(
                          DateFormat(DateFormat.HOUR24_MINUTE)
                              .format(data.dateStart!),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(pad8, 0, pad8, pad8),
              child: Row(
                children: [
                  // Card.outlined(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(pad8),
                  //     child: Column(
                  //       children: [
                  // Text(DateFormat.MMM().format(data.dateStart!)),
                  //         Text(DateFormat.d().format(data.dateStart!))
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        overflow: TextOverflow.ellipsis,
                        '${data.countryName}',
                        style: const TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${data.circuitShortName}',
                      ),
                    ],
                  ),
                  const Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(Icons.arrow_forward),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
