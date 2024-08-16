import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:leela_mobile/src/config.dart';

class DioClient {
  static final DioClient instance = DioClient._internal();
  factory DioClient() => instance;
  late Dio dio;

  DioClient._internal() {
    BaseOptions options = BaseOptions(
      // baseUrl: BASE_URL,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {},
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );
    dio = Dio(options);
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // print("app request data ${options.data}");
      return handler.next(options);
    }, onResponse: (response, handler) {
      if (kDebugMode) {
        print("app response data ${response.data}");
      }
      return handler.next(response);
    }, onError: (DioException e, handler) {
      if (kDebugMode) {
        print("app error data $e");
      }
      ErrorEntity eInfo = createErrorEntity(e);
      onError(eInfo);
    }));
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response;
  }

  Future<Response> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};

    var response = await dio.post(path,
        data: data, queryParameters: queryParameters, options: requestOptions);

    return response;
  }
}

class ErrorEntity implements Exception {
  int code = -1;
  String message = "";

  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") return "Exception";

    return "Exception code $code, $message";
  }
}

ErrorEntity createErrorEntity(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return ErrorEntity(code: -1, message: "Connection timed out");

    case DioExceptionType.sendTimeout:
      return ErrorEntity(code: -1, message: "Send timed out");

    case DioExceptionType.receiveTimeout:
      return ErrorEntity(code: -1, message: "Receive timed out");

    case DioExceptionType.badCertificate:
      return ErrorEntity(code: -1, message: "Bad SSL certificates");

    case DioExceptionType.badResponse:
      switch (error.response!.statusCode) {
        case 400:
          return ErrorEntity(code: 400, message: "Bad request");
        case 401:
          return ErrorEntity(code: 401, message: "Permission denied");
        case 500:
          return ErrorEntity(code: 500, message: "Server internal error");
      }
      return ErrorEntity(
          code: error.response!.statusCode!, message: "Server bad response");

    case DioExceptionType.cancel:
      return ErrorEntity(code: -1, message: "Server canceled it");

    case DioExceptionType.connectionError:
      return ErrorEntity(code: -1, message: "Connection error");

    case DioExceptionType.unknown:
      return ErrorEntity(code: -1, message: "Unknown error");
  }
}

void onError(ErrorEntity eInfo) {
  print('error.code -> ${eInfo.code}, error.message -> ${eInfo.message}');
  switch (eInfo.code) {
    case 400:
      print("Server syntax error");
      break;
    case 401:
      print("You are denied to continue");
      break;
    case 500:
      print("Server internal error");
      break;
    default:
      print("Unknown error");
      break;
  }
}
