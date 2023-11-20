import 'dart:convert';
import 'package:http/http.dart';
import 'package:task_manager/data/network_caller/network_response.dart';

class NetworkCaller {
  Future<NetworkResponse> postRrequest(String url,
      {dynamic body}) async {
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
