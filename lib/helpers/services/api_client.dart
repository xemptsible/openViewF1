import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:openViewF1/helpers/constants.dart';

class ApiClient {
  ApiClient._();

  static final instance = ApiClient._();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: openF1,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      contentType: ContentType.json.toString(),
    ),
  );

  Future<String?> get(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final Response response =
          await _dio.get(path, queryParameters: queryParams);
      return jsonEncode(response.data);
    } on DioException {
      rethrow;
    }
  }
}
