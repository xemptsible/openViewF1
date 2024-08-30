import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:openViewF1/data/models/session.dart';

import 'package:openViewF1/data/repositories/.repository_interface.dart';
import 'package:openViewF1/helpers/services/dio_exception_handler.dart';
import 'package:openViewF1/view_models/.view_model_interface.dart';

class SessionViewModel extends ChangeNotifier implements IViewModel {
  final IRepository sessionRepo;

  SessionViewModel({required this.sessionRepo});

  bool isLoading = false;
  List<Session> sessions = [];
  String errorMsg = "";

  @override
  Future<void> fetchData() async {
    isLoading = true;
    try {
      if (sessions.isEmpty) {
        sessions = await sessionRepo.getAll() as List<Session>;
        sessions = sessions.reversed.toList();
      }
    } on DioException catch (e) {
      errorMsg = DioExceptionHandler.throwError(e).toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  Future<void> fetchDataWithQuery(queryParams) async {
    isLoading = true;
    try {
      sessions.clear();
      sessions = await sessionRepo.getWithFilter(queryParams: queryParams)
          as List<Session>;
      sessions = sessions.reversed.toList();
    } on DioException catch (e) {
      errorMsg = DioExceptionHandler.throwError(e).toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
