import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/position.dart';
import 'package:openViewF1/data/repositories/.repository_interface.dart';
import 'package:openViewF1/helpers/services/dio_exception_handler.dart';
import 'package:openViewF1/view_models/.view_model_interface.dart';

class PositionViewModel extends ChangeNotifier implements IViewModel {
  final IRepository positionRepo;

  PositionViewModel({required this.positionRepo});

  bool isLoading = false;
  List<Position> positions = [];
  String errorMsg = "";

  @override
  Future<void> fetchData() async {
    isLoading = true;
    try {
      if (positions.isEmpty) {
        positions = await positionRepo.getAll() as List<Position>;
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
      positions.clear();
      positions = await positionRepo.getWithFilter(queryParams: queryParams)
          as List<Position>;
    } on DioException catch (e) {
      errorMsg = DioExceptionHandler.throwError(e).toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
