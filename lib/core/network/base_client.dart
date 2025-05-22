import 'package:dio/dio.dart';
import '../utils/storage.dart';

class BaseClient {
  static Future<BaseOptions> getBaseOptions({Map<String, dynamic>? additionalHeaders}) async {
    final token = await storage.read('token');

    BaseOptions options = BaseOptions(
      followRedirects: false,
      validateStatus: (status) => status! < 500,
      headers: {
        "Accept": "application/json",
        'Content-type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        'Authorization': 'Bearer $token',
        ...?additionalHeaders, // Spread additional headers if provided
      },
    );

    return options;
  }

  static Future<dynamic> get({
    required String url,
    dynamic payload,
    Map<String, dynamic>? headers,
  }) async {
    final dio = Dio(await getBaseOptions(additionalHeaders: headers));
    final response = await dio.get(url, queryParameters: payload);
    _logRequest(url: url, response: response);
    return response;
  }

  static Future<dynamic> post({
    required String url,
    dynamic payload,
    Map<String, dynamic>? headers,
  }) async {
    final dio = Dio(await getBaseOptions(additionalHeaders: headers));
    final response = await dio.post(url, data: payload);
    _logRequest(url: url, response: response);
    return response;
  }

  static Future<dynamic> postWithQP({
    required String url,
    dynamic queryPayload,
    Map<String, dynamic>? headers,
  }) async {
    final dio = Dio(await getBaseOptions(additionalHeaders: headers));
    final response = await dio.post(url, queryParameters: queryPayload);
    _logRequest(url: url, response: response);
    return response;
  }

  static Future<dynamic> put({
    required String url,
    dynamic payload,
    Map<String, dynamic>? headers,
  }) async {
    final dio = Dio(await getBaseOptions(additionalHeaders: headers));
    final response = await dio.put(url, data: payload);
    _logRequest(url: url, response: response);
    return response;
  }

  static Future<dynamic> delete({
    required String url,
    Map<String, dynamic>? headers,
  }) async {
    final dio = Dio(await getBaseOptions(additionalHeaders: headers));
    final response = await dio.delete(url);
    _logRequest(url: url, response: response);
    return response;
  }

  static void _logRequest({required String url, required Response response}) {
    print('\nURL: $url');
    print('Status Code: ${response.statusCode}');
    print('Response: ${response.data}');
  }
}
