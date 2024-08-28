import 'dart:convert';

import 'package:openViewF1/data/models/position.dart';
import 'package:openViewF1/data/repositories/.repository.dart';
import 'package:openViewF1/helpers/services/api_client.dart';

class PositionRepo extends Repository {
  @override
  Future<List<Position>> getAll() async {
    List<Position> list = [];

    dynamic defaultQueryParams = {
      'session_key': 'latest',
    };

    await ApiClient.instance
        .get('/position', queryParams: defaultQueryParams)
        .then((json) {
      json != null
          ? list = (jsonDecode(json) as List)
              .map((e) => Position.fromJson(e))
              .toList()
          : list;
    });

    return list;
  }

  @override
  Future<List<Position>> getWithFilter({queryParams}) async {
    List<Position> list = [];
    List<Position> result = [];

    dynamic defaultQueryParams = {
      'session_key': 'latest',
    };

    await ApiClient.instance
        .get('/position', queryParams: queryParams ?? defaultQueryParams)
        .then((json) {
      json != null
          ? list = (jsonDecode(json) as List)
              .map((e) => Position.fromJson(e))
              .toList()
          : list;
    });

    if (list != []) {
      for (var i = 1; i <= 20; i++) {
        result.add(list[list.lastIndexWhere(
          (element) => element.position == i,
        )]);
      }
      return result;
    }

    return list;
  }
}
