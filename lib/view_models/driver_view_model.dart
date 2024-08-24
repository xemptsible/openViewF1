import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/driver.dart';
import 'package:openViewF1/data/repositories/driver_repo.dart';
import 'package:openViewF1/helpers/services/dio_exception_handler.dart';
import 'package:openViewF1/view_models/.view_model.dart';

class DriverViewModel extends ChangeNotifier implements ViewModel {
  final DriverRepo driverRepo;

  DriverViewModel({required this.driverRepo});

  bool isLoading = false;
  List<Driver> drivers = [];
  String errorMsg = "";

  @override
  Future<void> fetchData() async {
    isLoading = true;
    try {
      drivers = await driverRepo.getAll();
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
      drivers = await driverRepo.getWithFilter(queryParams: queryParams);
    } on DioException catch (e) {
      errorMsg = DioExceptionHandler.throwError(e).toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
