import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart';

class NetworkCaller {
  Future<NetworkResponse> postRrequest(String url,
      {Map<String, dynamic>? body}) async {
    try {
      final Response response = await post(Uri.parse(url),
          body: jsonEncode(body),
          headers: {'Content-type': 'application/json'});

      if (response.statusCode == 200) {
        return NetworkResponse(
            isSuccess: true,
            jsonResponse: jsonDecode(response.body),
            statusCode: 200);
      } else {
        return NetworkResponse(
            isSuccess: false,
            jsonResponse: jsonDecode(response.body),
            statusCode: response.statusCode);
      }
    } catch (err) {
      return NetworkResponse(isSuccess: false, errorMessage: err.toString());
    }
  }
}

class NetworkResponse {
  final int? statusCode;
  final bool isSuccess;
  final Map<String, dynamic>? jsonResponse;
  final String? errorMessage;

  NetworkResponse(
      {this.statusCode = -1,
      required this.isSuccess,
      this.errorMessage = 'Something went wrong!',
      this.jsonResponse});
}
