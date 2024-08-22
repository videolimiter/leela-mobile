import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:leela_mobile/src/api/dio/dio_client.dart';
import 'package:leela_mobile/src/config.dart';

class IsAuth extends ChangeNotifier {
  final _authController = StreamController<bool>.broadcast();

  Stream<bool> get authStream => _authController.stream;

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  void setIsAuthenticated(bool value) {
    _isAuthenticated = value;
    _authController.add(value);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final loginData = {
      "email": email,
      "password": password,
    };
    final cookieJar = CookieJar();
    DioClient.instance.dio.interceptors.add(CookieManager(cookieJar));
    try {
      final response =
          await DioClient.instance.post(LOGIN_URL, data: loginData);

      if (response.statusCode == 201) {
        setIsAuthenticated(true);
      }
    } on DioException catch (e) {
      setIsAuthenticated(false);
    }
  }

  Future<bool?> logout() async {
    try {
      final response = await DioClient.instance.dio.post(
        LOGOUT_URL,
      );
      setIsAuthenticated(false);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool?> checkCurrentUser() async {
    try {
      final response = await DioClient.instance.get(
        USER_URL,
      );
      if (response.statusCode == 200) {
        setIsAuthenticated(true);
      } else {
        setIsAuthenticated(false);
      }
    } catch (e) {
      setIsAuthenticated(false);
    }
  }
}
