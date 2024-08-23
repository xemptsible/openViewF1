import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/driver.dart';
import 'package:openViewF1/helpers/constants.dart';

class Position {
  DateTime? date;
  int? driverNumber;
  int? meetingKey;
  int? position;
  int? sessionKey;

  Position({
    this.date,
    this.driverNumber,
    this.meetingKey,
    this.position,
    this.sessionKey,
  });

  factory Position.fromRawJson(String str) =>
      Position.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        driverNumber: json["driver_number"],
        meetingKey: json["meeting_key"],
        position: json["position"],
        sessionKey: json["session_key"],
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "driver_number": driverNumber,
        "meeting_key": meetingKey,
        "position": position,
        "session_key": sessionKey,
      };

  @override
  String toString() {
    return 'Position(date: $date, driverNumber: $driverNumber, meetingKey: $meetingKey, position: $position, sessionKey: $sessionKey)';
  }
}

class ResultPositionPlaceholder extends StatelessWidget {
  const ResultPositionPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: pad16, vertical: pad8),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Text(
              '1',
              // textAlign: TextAlign.center,
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(
              '44',
              // textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: pad8),
            height: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(pad4),
              border: Border(
                left: Divider.createBorderSide(
                  context,
                  color: Colors.blueAccent,
                  width: pad8,
                ),
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(
              'HAM',
              // textAlign: TextAlign.center,
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(
              'GBR',
              // textAlign: TextAlign.center,
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(
              'Mercedes',
              // textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class ResultHeader extends StatelessWidget {
  const ResultHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Text(
              'POS',
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(
              'NO',
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(
              'DRIVER',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: pad8),
            height: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(pad4),
              border: Border(
                left: Divider.createBorderSide(
                  context,
                  color: Colors.transparent,
                  width: pad8,
                ),
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(
              'NATION',
            ),
          ),
          const Expanded(
            flex: 1,
            child: Text(
              'TEAM',
            ),
          ),
        ],
      ),
    );
  }
}

class SessionPositionItem extends StatelessWidget {
  const SessionPositionItem({
    super.key,
    required this.data,
    required this.driver,
  });

  final Position data;
  final Driver driver;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: pad16, vertical: pad8),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '${data.position}',
              // textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${data.driverNumber}',
              // textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: pad8),
            height: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(pad4),
              border: Border(
                left: Divider.createBorderSide(
                  context,
                  color: Color(
                    int.parse('${driver.teamColour}'),
                  ),
                  width: pad8,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${driver.nameAcronym}',
              // textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${driver.countryCode}',
              // textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${driver.teamName}',
              // textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
