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

  void filterPositions() async {
    final list = await LocalJson().getPositions();
    List<Position> sortedList = [];

    // print(list.lastIndexWhere(
    //   (element) => element.position == 3,
    // ));
    // print(list[list.lastIndexWhere(
    //   (element) => element.position == 3,
    // )]);
    // print(list.lastIndexWhere(
    //   (element) => element.position == 2,
    // ));
    // print(list.lastIndexWhere(
    //   (element) => element.position == 1,
    // ));

    // final top3 = sortedList.followedBy([
    //   list[list.lastIndexWhere(
    //     (element) => element.position == 3,
    //   )],
    //   list[list.lastIndexWhere(
    //     (element) => element.position == 2,
    //   )],
    //   list[list.lastIndexWhere(
    //     (element) => element.position == 1,
    //   )]
    // ]);

    for (int i = 1; i <= 3; i++) {
      sortedList.add(
        list[list.lastIndexWhere(
          (element) => element.position! == i,
        )],
      );
    }

    print(sortedList);
  }
}
