import 'package:flutter/foundation.dart';
import 'DioWithInterceptors.dart';

class DioApiBaseHelper {
  static String baseUrl = "https://api-medyseva-saas.tejpage.com/api/v1/";
  static String todo = 'todo';
  static String verifyOtp = 'auth/verifyLoginOtp';

  static get(String url) async {
    try {
      final response = await getDio().get(baseUrl + url);
      return response.data;
    } catch (e, s) {
      if (kDebugMode) {
        print(s);
        print(e);
      }
    }
    return null;
  }

  static postDio(String url, dynamic data) async {
    try {
      final response = await getDio().post(
        baseUrl + url,
        data: data,
      );
      return response.data;
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
    }
    return null;
  }

  static putDio(String url, dynamic data) async {
    try {
      final response = await getDio().put(
        baseUrl + url,
        data: data,
      );
      return response.data;
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
    }
    return null;
  }

  static deleteDio(String url, dynamic id) async {
    try {
      final response = await getDio().delete(
        "$baseUrl$url/$id",
      );
      return response.data;
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
    }
    return null;
  }
}
