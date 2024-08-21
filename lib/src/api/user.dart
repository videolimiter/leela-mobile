import 'package:leela_mobile/src/api/dio/dio_client.dart';

Future<bool> getUser() async {
  try {
    final response = await DioClient.instance.get(
      'http://192.168.1.2:3000/api/user',
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<bool> logoutUser() async {
  try {
    final response = await DioClient.instance.dio.post(
      'http://192.168.1.2:3000/api/logout',
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
