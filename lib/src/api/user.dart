import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:leela_mobile/src/api/cookies.dart';
import 'package:leela_mobile/src/config.dart';

Future<bool> getUser() async {
  final dio = Dio();
  final cookieJar = PersistCookieJar(
    ignoreExpires: true,
    storage: FileStorage("/.cookies/"),
  );
  dio.interceptors.add(CookieManager(cookieJar));

  try {
    // final cookies = await loadCookies(LOGIN_URL);

    final response = await dio.get('http://192.168.1.2:3000/api/user'
        // options: Options(
        //   headers: {
        //     'Cookie': cookies
        //         .map((cookie) => '${cookie.name}=${cookie.value}')
        //         .join('; '),
        //   },
        // )
        );
    print(response);
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
  final dio = Dio();
  final cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  try {
    final cookies = await loadCookies(LOGIN_URL);
    final response = await dio.post('http://192.168.1.2:3000/api/logout',
        options: Options(
          headers: {
            'Cookie': cookies
                .map((cookie) => '${cookie.name}=${cookie.value}')
                .join('; '),
          },
        ));
    print(response);
    if (response.statusCode == 201) {
      await CookieManager(CookieJar());
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
