import 'package:dio/dio.dart';

class AppInterceptors extends Interceptor {
  /// For adding additional header parameters to authorise request
  @override
  Future<dynamic> onRequest(RequestOptions options, handler) async {
    Map<String, String> headers = {
      'Access-Control-Allow-Origin': '*',
      'Accept': 'application/json',
    };
    options.headers.addAll(headers);
    return super.onRequest(options, handler);
  }

  /// Fot handling error
  @override
  onError(DioException err, handler) {
    var response = err.response;
    if (response != null) {

    }
  }
}
