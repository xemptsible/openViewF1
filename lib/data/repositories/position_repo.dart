import 'dart:convert';

import 'package:jiffy/jiffy.dart';
import 'package:openViewF1/data/models/position.dart';
import 'package:openViewF1/data/repositories/.repository.dart';
import 'package:openViewF1/helpers/services/api_client.dart';

class PositionRepo extends Repository {
  @override
  Future<List<Position>> getAll() async {
    List<Position> list = [];

    dynamic defaultQueryParams = {'year': DateTime.now().year.toString()};

    await ApiClient.instance
        .get('/meetings', queryParams: defaultQueryParams)
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

    dynamic defaultQueryParams = {
      'session': 'latest',
    };

    await ApiClient.instance
        .get('/meetings', queryParams: queryParams ?? defaultQueryParams)
        .then((json) {
      json != null
          ? list = (jsonDecode(json) as List)
              .map((e) => Position.fromJson(e))
              .toList()
          : list;
    });

    return list;
  }

  Future<List<Position>> getTop3(queryParams) async {
    List<Position> list = [];

    dynamic defaultQueryParams = {
      'session': 'latest',
      'position<': 3,
    };

    await ApiClient.instance
        .get('/meetings', queryParams: queryParams ?? defaultQueryParams)
        .then((json) {
      json != null
          ? list = (jsonDecode(json) as List)
              .map((e) => Position.fromJson(e))
              .toList()
          : list;
    });

    return list;
  }
}
