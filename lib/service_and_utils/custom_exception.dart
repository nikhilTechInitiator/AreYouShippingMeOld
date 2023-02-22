import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api_errors.dart';

class CustomException implements Exception {
  late String errorMessage;

  CustomException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorMessage = 'Request to the server was cancelled.';
        break;
      case DioErrorType.connectTimeout:
        errorMessage = 'Connection timed out.';
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = 'Receiving timeout occurred.';
        break;
      case DioErrorType.sendTimeout:
        errorMessage = 'Request send timeout.';
        break;
      case DioErrorType.response:
        errorMessage = ApiErrors.fromStatusCode(dioError);
        break;
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          errorMessage = 'No Internet.';
          break;
        }
        debugPrint(dioError.error);
        debugPrint(dioError.message);
        debugPrint(dioError.response?.data);
        debugPrint(dioError.response?.statusMessage);
        debugPrint(dioError.response?.statusCode.toString());
        errorMessage = 'Unexpected error occurred.';
        break;
      default:
        errorMessage = 'Something went wrong';
        break;
    }
  }

  @override
  String toString() => errorMessage;
}
