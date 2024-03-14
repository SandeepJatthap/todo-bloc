import 'package:dio/dio.dart';
import 'AppInterceptors.dart';

Dio getDio() {
  Dio dio = Dio();
  dio.interceptors.add(AppInterceptors());

  return dio;
}
