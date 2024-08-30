import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:openViewF1/data/models/session.dart';

import 'package:openViewF1/data/repositories/.repository_interface.dart';
import 'package:openViewF1/helpers/services/dio_exception_handler.dart';
import 'package:openViewF1/view_models/.view_model.dart';

class SessionViewModelImpl extends ChangeNotifier implements ViewModel<Session> {
  final IRepository sessionRepo;

  SessionViewModelImpl({required this.sessionRepo});

  @override
  bool isLoading = false;
  @override
  List<Session> list = [];
  @override
  String errorMsg = "";

  @override
  Future<void> fetchData() async {
    isLoading = true;
    try {
      if (list.isEmpty) {
        list = await sessionRepo.getAll() as List<Session>;
        list = list.reversed.toList();
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
      if (list.isEmpty) {
        list = await sessionRepo.getWithFilter(queryParams: queryParams)
            as List<Session>;
        list = list.reversed.toList();
      }
    } on DioException catch (e) {
      errorMsg = DioExceptionHandler.throwError(e).toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
