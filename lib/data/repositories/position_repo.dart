import 'dart:convert';

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
  Future<List> getWithFilter({queryParams}) {
    // TODO: implement getWithFilter
    throw UnimplementedError();
  }
}
