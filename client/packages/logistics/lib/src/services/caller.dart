import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:logistics/logistics.dart';

class CallMyApis {
  String _proxy = '';
  String _baseUrl = '';
  final bool debug, mobile;

  static final List<String> validStats = ['successful'];

  CallMyApis({
    this.debug = false,
    this.mobile = false,
    required String url,
    String? proxy,
  }) {
    _proxy = mobile
        ? ""
        : proxy ?? '';
    _baseUrl = url;
  }

  String get proxy => _proxy;
  String get baseUrl => _baseUrl;

  Dio dio({Map<String, dynamic>? headers, Duration? receiveTimeout}) {
    return Dio(
      BaseOptions(
        baseUrl: "$_proxy$_baseUrl",
        connectTimeout: const Duration(minutes: 5),
        receiveTimeout: receiveTimeout ?? const Duration(minutes: 12),
        headers: headers ?? {"Access-Control-Allow-Origin": "*"},
      ),
    );
  }

  Future dioPost(
      {required String endpoint,
      Map<String, String>? header,
      Map<String, dynamic>? body}) async {
    var headers = {"Access-Control-Allow-Origin": "*"};

    if (header != null) {
      headers.addEntries(header.entries);
    }

    try {
      Logging.log.i("About to call $_proxy$_baseUrl$endpoint");
      final response = await dio(
        headers: headers,
      ).post(endpoint, data: body);

      var data = response.data;
      if (response.statusCode != 200 || response.statusCode != 201) {
        return data;
      } else {
        var message = data.runtimeType.toString() == '_JsonMap'
            ? data['reason'] ?? '$data'
            : data;
        throw CustomException(message, code: response.statusCode);
      }
    } on FormatException catch (e) {
      Logging.log.i(e.toString());
      throw CustomException(
          "Message: Your Session has expired. | Error: ${e.message}");
    } on DioException catch (e) {
      Logging.log.i(e.toString());
      Logging.log.d(
          "Response data: ${e.response?.data} Run-type = ${(e.response?.data.runtimeType)}");
      var message =
          e.response?.data['reason'] ?? 'Bad Request | Error: ${e.message}';
      throw CustomException(
        message,
      );
    } catch (e) {
      Logging.log.e(e.toString());
      if (e.toString().contains('Connection timed out')) {
        throw CustomException("Connection timed out");
      } else if (e.toString().contains('Connection closed')) {
        throw CustomException("Connection closed!!!");
      } else if (e.toString().contains('Connection reset by peer')) {
        throw CustomException("Connection reset by peer");
      } else {
        throw CustomException("Something went wrong");
      }
    }
  }

  Future dioGet({
    required String endpoint,
    Map<String, String>? header,
    Map<String, dynamic>? query,
  }) async {
    var headers = {"Access-Control-Allow-Origin": "*"};

    if (header != null) {
      headers.addEntries(header.entries);
    }

    try {
      Logging.log.i("About to call $_proxy$_baseUrl$endpoint");
      final response = await dio(
        headers: headers,
      ).get(endpoint, queryParameters: query);

      var data = response.data;
      if (response.statusCode != 200 || response.statusCode != 201) {
        return data;
      } else {
        var message = data.runtimeType.toString() == '_JsonMap'
            ? data['reason'] ?? '$data'
            : data;
        throw CustomException(message, code: response.statusCode);
      }
    } on FormatException catch (e) {
      Logging.log.i(e.toString());
      throw CustomException(
          "Message: Your Session has expired. | Error: ${e.message}");
    } on DioException catch (e) {
      Logging.log.i(e.toString());
      Logging.log.d(
          "Response data: ${e.response?.data} Run-type = ${(e.response?.data.runtimeType)}");
      var message =
          e.response?.data['reason'] ?? 'Bad Request | Error: ${e.message}';
      throw CustomException(
        message,
      );
    } catch (e) {
      Logging.log.e(e.toString());
      if (e.toString().contains('Connection timed out')) {
        throw CustomException("Connection timed out");
      } else if (e.toString().contains('Connection closed')) {
        throw CustomException("Connection closed!!!");
      } else if (e.toString().contains('Connection reset by peer')) {
        throw CustomException("Connection reset by peer");
      } else {
        throw CustomException("Something went wrong");
      }
    }
  }

  Future post(
      {required String endpoint,
      Map<String, String>? header,
      Map<String, String>? body}) async {
    var url = Uri.decodeFull('$_proxy$_baseUrl/$endpoint');

    var headers = {"Access-Control-Allow-Origin": "*"};

    if (header != null) {
      headers.addEntries(header.entries);
    }

    try {
      final response =
          await http.post(Uri.parse(url), headers: header, body: body);

      if (response.statusCode != 200 || response.statusCode != 201) {
        try {
          var data = json.decode(response.body);
          return data;
        } catch (_) {
          return response.body;
        }
      } else {
        var message = '';
        try {
          var data = json.decode(response.body);
          message = data['reason'] ?? '$data';
        } catch (_) {
          message = response.body;
        }
        throw CustomException(message, code: response.statusCode);
      }
    } on FormatException catch (e) {
      Logging.log.i(e.toString());
      throw CustomException(
          "Message: Your Session has expired. | Error: ${e.message}");
    } catch (e) {
      Logging.log.e(e.toString());
      if (e.toString().contains('Connection timed out')) {
        throw CustomException("Connection timed out");
      } else if (e.toString().contains('Connection closed')) {
        throw CustomException("Connection closed!!!");
      } else if (e.toString().contains('Connection reset by peer')) {
        throw CustomException("Connection reset by peer");
      } else {
        throw CustomException("Something went wrong");
      }
    }
  }

  Future get(
      {required String endpoint,
      String? requestEnd,
      String? query,
      Map<String, String>? header}) async {
    var url = Uri.decodeFull('$_proxy$endpoint/$requestEnd?$query');
    Logging.log.i("About to call $url");

    var headers = {"Access-Control-Allow-Origin": "*"};

    if (header != null) {
      headers.addEntries(header.entries);
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: header,
      );

      if (response.statusCode != 200 || response.statusCode != 201) {
        try {
          var data = json.decode(response.body);
          return data;
        } catch (e) {
          return response.body;
        }
      } else {
        var message = '';
        try {
          var data = json.decode(response.body);
          message = data['reason'] ?? '$data';
        } catch (_) {
          message = response.body;
        }
        throw CustomException(message, code: response.statusCode);
      }
    } on FormatException catch (e) {
      Logging.log.i(e.toString());
      throw CustomException(
          "Message: Your Session has expired. | Error: ${e.message}");
    } catch (e) {
      Logging.log.e(e.toString());
      if (e.toString().contains('Connection timed out')) {
        throw CustomException("Connection timed out");
      } else if (e.toString().contains('Connection closed')) {
        throw CustomException("Connection closed!!!");
      } else if (e.toString().contains('Connection reset by peer')) {
        throw CustomException("Connection reset by peer");
      } else {
        throw CustomException("Something went wrong");
      }
    }
  }

  static Future commit(ActionCallback<dynamic> val) async {
    try {
      var response = await val();
      if ((response['status'] == null ||
          validStats.contains(response['status']))) {
        return response;
      } else if (response['status'] != null &&
          !validStats.contains(response['status'])) {
        throw CustomException(
          response['reason'],
        );
      } else {
        throw CustomException("Link not created properly.");
      }
    } on CustomException {
      rethrow;
    } catch (e) {
      Logging.log.e(e.toString());
      throw CustomException("Unknown error. Sorry for the inconvenience");
    }
  }
}
