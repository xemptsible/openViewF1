import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/position.dart';
import 'package:openViewF1/data/repositories/position_repo.dart';
import 'package:openViewF1/helpers/services/dio_exception_handler.dart';
import 'package:openViewF1/view_models/.view_model.dart';

class PositionViewModel extends ChangeNotifier implements ViewModel {
  final PositionRepo positionRepo;

  PositionViewModel({required this.positionRepo});

  bool isLoading = false;
  List<Position> positions = [];
  String errorMsg = "";

  @override
  Future<void> fetchData() async {
    isLoading = true;
    try {
      positions.clear();
      positions = await positionRepo.getAll();
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
      positions = await positionRepo.getWithFilter(queryParams: queryParams);
    } on DioException catch (e) {
      errorMsg = DioExceptionHandler.throwError(e).toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
