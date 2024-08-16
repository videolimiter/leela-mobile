import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _secureStorage = FlutterSecureStorage();
final _cookieJar = CookieJar();

// Сохранение куки
Future<void> saveCookies(String url, List<Cookie> cookies) async {
  // Сохраняем куки в FlutterSecureStorage
  for (final cookie in cookies) {
    await _secureStorage.write(
        key: 'cookie_${cookie.name}', value: cookie.value);
  }

  // Сохраняем куки в CookieJar
  _cookieJar.saveFromResponse(Uri.parse(url), cookies);
}

Future<void> deleteCookies(String url) async {
  // Удаляем куки из FlutterSecureStorage
  final keys = await _secureStorage.readAll();
  for (final entry in keys.entries) {
    if (entry.key.startsWith('cookie_')) {
      await _secureStorage.delete(key: entry.key);
    }
  }
  // Удаляем куки из CookieJar
  _cookieJar.delete(Uri.parse(url));
}

// Загрузка куки
Future<List<Cookie>> loadCookies(String url) async {
  final cookies = <Cookie>[];

  // Загружаем куки из FlutterSecureStorage
  final keys = await _secureStorage.readAll();
  for (final entry in keys.entries) {
    if (entry.key.startsWith('cookie_')) {
      final cookieName = entry.key.substring('cookie_'.length);
      final cookieValue = entry.value;
      cookies.add(Cookie(cookieName, cookieValue));
    }
  }

  // Загружаем куки из CookieJar
  cookies.addAll(await _cookieJar.loadForRequest(Uri.parse(url)));

  return cookies;
}
