import 'package:dio/dio.dart';

class DioExceptionHandler implements Exception {
  late String errorMsg;

  DioExceptionHandler.throwError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
        errorMsg = 'Connection error';
        break;
      case DioExceptionType.connectionTimeout:
        errorMsg = 'Connection timed out';
        break;
      case DioExceptionType.receiveTimeout:
        errorMsg = "Timeout trying to receive data";
        break;
      case DioExceptionType.cancel:
        errorMsg = 'Request was cancelled';
        break;
      case DioExceptionType.badCertificate:
        errorMsg = 'Server had bad certificate';
        break;
      case DioExceptionType.badResponse:
        errorMsg = _handleStatusCode(e.response?.statusCode);
        break;
      default:
        if (e.type == DioExceptionType.unknown) {
          errorMsg = 'Something went wrong';
          break;
        }
    }
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'User already exist ';
      case 401:
        return 'Authentication failed.';
      case 403:
        return 'The authenticated user is not allowed to access the specified API endpoint.';
      case 404:
        return 'The requested resource does not exist.';
      case 500:
        return 'Internal server error.';
      default:
        return 'Oops something went wrong!';
    }
  }

  @override
  String toString() => errorMsg;
}
