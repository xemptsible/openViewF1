import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/position.dart';
import 'package:openViewF1/data/repositories/.repository_interface.dart';
import 'package:openViewF1/helpers/services/dio_exception_handler.dart';
import 'package:openViewF1/view_models/.view_model.dart';

class PositionViewModelImpl extends ChangeNotifier implements ViewModel<Position> {
  final IRepository positionRepo;

  PositionViewModelImpl({required this.positionRepo});

  @override
  bool isLoading = false;
  @override
  List<Position> list = [];
  @override
  String errorMsg = "";

  @override
  Future<void> fetchData() async {
    isLoading = true;
    try {
      if (list.isEmpty) {
        list = await positionRepo.getAll() as List<Position>;
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
      list.clear();
      list = await positionRepo.getWithFilter(queryParams: queryParams)
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
