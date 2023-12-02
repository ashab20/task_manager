import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/controllers/auth_controller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/ui/screens/login_screen.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url,
      {dynamic body,bool isLogin = false}) async {
    try {
      final Response response = await post(Uri.parse(url),
          body: jsonEncode(body),
          headers: {'Content-type': 'application/json','token':AuthController.token.toString()});

      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        log(response.body.toString());
        return NetworkResponse(
            isSuccess: true,
            jsonResponse: jsonDecode(response.body),
            statusCode: 200);
      }else if(response.statusCode == 401){
        if(!isLogin){
          backToLogin();
        }
        return NetworkResponse(
            isSuccess: false,
            jsonResponse: jsonDecode(response.body),
            statusCode: response.statusCode);
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

  Future<NetworkResponse> getRequest(String url) async {
    try {
      final Response response = await get(Uri.parse(url),
          headers: {'Content-type': 'application/json','token':AuthController.token.toString()});

      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        return NetworkResponse(
            isSuccess: true,
            jsonResponse: jsonDecode(response.body),
            statusCode: 200);
      }else if(response.statusCode == 401){
        backToLogin();
        return NetworkResponse(
            isSuccess: false,
            jsonResponse: jsonDecode(response.body),
            statusCode: response.statusCode);
      }else {
        return NetworkResponse(
            isSuccess: false,
            jsonResponse: jsonDecode(response.body),
            statusCode: response.statusCode);
      }
    } catch (err) {
      return NetworkResponse(isSuccess: false, errorMessage: err.toString());
    }
  }
  Future<void> backToLogin() async {
    await AuthController.clearAuthUser();
    Navigator.pushAndRemoveUntil(
    TaskManagerApp.navigationKey.currentContext!,
    MaterialPageRoute(builder: (context)=> const LoginScreen()), (route) => false);
  }
}
