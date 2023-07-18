import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:teste_ava/app/modules/core/services/http/http_service.dart';

class HttpServiceImp implements HttpService {
  static const Duration timeLimit = Duration(seconds: 30);

  @override
  Future get<T>(
      {required String url,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    Uri uri;

    if (queryParameters != null) {
      uri = Uri.parse(url).replace(queryParameters: queryParameters);
    } else {
      uri = Uri.parse(url);
    }

    var response = await http.get(uri, headers: headers).timeout(timeLimit);

    return response;
  }

  @override
  Future post<T>({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    var uri = Uri.parse(url);

    var response = await http
        .post(uri, body: jsonEncode(body), headers: headers)
        .timeout(timeLimit);

    return response;
  }

  @override
  Future delete<T>({required String url, Map<String, String>? headers}) async {
    var uri = Uri.parse(url);

    var response = await http.delete(uri, headers: headers).timeout(timeLimit);

    return response;
  }

  @override
  Future postFile<T>(
      {required String url,
      Map<String, String>? headers,
      required List<File> files}) async {
    var uri = Uri.parse(url);

    http.MultipartRequest request = http.MultipartRequest("POST", uri);

    if (headers != null) {
      request.headers.addAll(headers);
    }

    for (var file in files) {
      request.files.add(
          await http.MultipartFile.fromPath(p.basename(file.path), file.path));
    }

    final responses = await request.send().timeout(timeLimit);

    return responses.stream
        .bytesToString()
        .catchError((e) => throw Exception(e));
  }
}
