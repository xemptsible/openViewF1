import 'dart:convert';

import 'package:openViewF1/data/models/driver.dart';
import 'package:openViewF1/data/repositories/.repository.dart';
import 'package:openViewF1/helpers/services/api_client.dart';

class DriverRepo implements Repository {
  @override
  Future<List<Driver>> getAll() async {
    List<Driver> list = [];

    dynamic defaultQueryParams = {
      'session_key': 'latest',
    };

    await ApiClient.instance
        .get('/drivers', queryParams: defaultQueryParams)
        .then((json) {
      json != null
          ? list =
              (jsonDecode(json) as List).map((e) => Driver.fromJson(e)).toList()
          : list;
    });

    return list;
  }

  @override
  Future<List<Driver>> getWithFilter({queryParams}) async {
    List<Driver> list = [];

    dynamic defaultQueryParams = {
      'session_key': 'latest',
    };

    await ApiClient.instance
        .get('/drivers', queryParams: queryParams ?? defaultQueryParams)
        .then((json) {
      json != null
          ? list =
              (jsonDecode(json) as List).map((e) => Driver.fromJson(e)).toList()
          : list;
    });

    return list;
  }
}
