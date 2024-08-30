import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/driver.dart';

import 'package:openViewF1/data/repositories/.repository_interface.dart';
import 'package:openViewF1/helpers/services/dio_exception_handler.dart';
import 'package:openViewF1/view_models/.view_model.dart';

class DriverViewModelImpl extends ChangeNotifier implements ViewModel<Driver> {
  final IRepository driverRepo;

  DriverViewModelImpl({required this.driverRepo});

  @override
  List<Driver> list = [];
  @override
  bool isLoading = false;
  @override
  String errorMsg = "";

  @override
  Future<void> fetchData() async {
    isLoading = true;
    try {
      if (list.isEmpty) {
        list = await driverRepo.getAll() as List<Driver>;
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
        list = await driverRepo.getWithFilter(queryParams: queryParams)
            as List<Driver>;
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
