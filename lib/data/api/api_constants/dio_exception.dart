import 'package:dio/dio.dart';

class DioException implements Exception {
  late String message;

  DioException.fromDioError(DioError dioError) {
    Map<DioErrorType, String> errors = {
      DioErrorType.cancel: "Request to API server was cancelled",
      DioErrorType.connectionTimeout: "Connection timeout with API server",
      DioErrorType.receiveTimeout:
          "Receive timeout in connection with API server",
      DioErrorType.sendTimeout: "Send timeout in connection with API server",
      DioErrorType.unknown: dioError.message!.contains("SocketException")
          ? "No Internet"
          : "Unexpected error occurred",
    };
    message = errors[dioError.type] ??
        _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
  }

  String _handleError(int? statusCode, dynamic error) {
    Map<int, String> responseErrors = {
      400: 'Bad request',
      401: 'Unauthorized',
      403: 'Forbidden',
      404: 'unfounde',
      500: 'Internal server error',
      502: 'Bad gateway',
    };
    return responseErrors[statusCode] ?? error;
  }

  @override
  String toString() => message;
}
