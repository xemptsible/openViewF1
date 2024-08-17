import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:openViewF1/data/models/position.dart';

class LocalJson {
  Future<List<Position>> getPositions() async {
    var response = await rootBundle.loadString("assets/test.json");

    final list = (jsonDecode(response) as List)
        .map(
          (e) => Position.fromJson(e),
        )
        .toList();

    return list;
  }
}
