import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:leela_mobile/src/api/cookies.dart';
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
    final cookieJar = CookieJar();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      final cookies = await loadCookies(LOGIN_URL);
      if (cookies.isNotEmpty) {
        options.headers = {
          'Cookie': cookies
              .map((cookie) => '${cookie.name}=${cookie.value}')
              .join('; '),
        };
      }
      if (kDebugMode) {
        print("app request data ${options.data}");
      }
      return handler.next(options);
    }, onResponse: (response, handler) async {
      // Парсим куки из заголовка
      if (response.headers['set-cookie'] != null) {
        final cookies = await cookieJar.loadForRequest(Uri.parse(LOGIN_URL));
        await deleteCookies(LOGIN_URL);
        await saveCookies(LOGIN_URL, cookies);
      }

      if (kDebugMode) {
        print("app response data ${response.data}");
      }
      return handler.next(response);
    }, onError: (DioException e, handler) async {
      if (kDebugMode) {
        print("app error data $e");
      }
      ErrorEntity eInfo = createErrorEntity(e);
      if (kDebugMode) {
        onError(eInfo);
      }
      return handler.next(e);
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
  if (kDebugMode) {
    print('error.code -> ${eInfo.code}, error.message -> ${eInfo.message}');
  }
  switch (eInfo.code) {
    case 400:
      if (kDebugMode) {
        print("Server syntax error");
      }
      break;
    case 401:
      if (kDebugMode) {
        print("You are denied to continue");
      }
      break;
    case 500:
      if (kDebugMode) {
        print("Server internal error");
      }
      break;
    default:
      print("Unknown error");
      break;
  }
}
