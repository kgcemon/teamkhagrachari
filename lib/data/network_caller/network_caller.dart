import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart' as Getx;
import 'package:http/http.dart';
import 'package:teamkhagrachari/data/model/network_response.dart';
import 'package:teamkhagrachari/presentation/screen/auth/login_screen.dart';

import '../../presentation/controller/user_auth_controller.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      log(url);
      String token = UserAuthController.accessToken;
      print(token);
      final Response response = await get(Uri.parse(url),
          headers: {"Authorization": token});
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            responseCode: response.statusCode,
            isSuccess: true,
            responseData: decodedData);
      } else if (response.statusCode == 401) {
        _goToSignInScreen();
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      } else if (response.statusCode == 403) {
        _goToSignInScreen();
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      log(e.toString());
      return NetworkResponse(
          responseCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      log(url);
      final Response response = await post(Uri.parse(url),
          headers: {
            'Authorization': UserAuthController.accessToken,
            'accept': 'application/json'
          },
          body: body);
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            responseCode: response.statusCode,
            isSuccess: true,
            responseData: decodedData);
      } else if (response.statusCode == 401) {
        _goToSignInScreen();
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      log(e.toString());
      return NetworkResponse(
          responseCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }


  static Future<NetworkResponse> patchRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      log(url);
      final Response response = await patch(Uri.parse(url),
          headers: {
            'Authorization': UserAuthController.accessToken,
            'accept': 'application/json'
          },
          body: body);
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            responseCode: response.statusCode,
            isSuccess: true,
            responseData: decodedData);
      } else if (response.statusCode == 401) {
        _goToSignInScreen();
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      log(e.toString());
      return NetworkResponse(
          responseCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> deleteRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      log(url);
      final Response response = await delete(Uri.parse(url),
          headers: {
            'Authorization': UserAuthController.accessToken,
            'accept': 'application/json'
          },
          body: body);
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            responseCode: response.statusCode,
            isSuccess: true,
            responseData: decodedData);
      } else if (response.statusCode == 401) {
        _goToSignInScreen();
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      log(e.toString());
      return NetworkResponse(
          responseCode: -1, isSuccess: false, errorMessage: e.toString());
    }
  }

  static void _goToSignInScreen() {
    Getx.Get.to(() => const LoginScreen());
  }
}
