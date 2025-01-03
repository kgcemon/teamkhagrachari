import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/urls..dart';


class RegisterController extends GetxController {
  var isProgress = false.obs;
  bool isDonor = false;

  Future<bool> registerUser({
    required String email,
    required String password,
    required String phone,
    required String bloodGroup,
    required String upazila,
    required String name,
    required String sponsor,
  }) async {
    isProgress.value = true;
    update();

    try {
      final response = await http.post(
        Uri.parse(ApiUrl.registerUrls),
        body: {
          "email": email,
          "password": password,
          "phone": phone,
          "upazila": upazila,
          "sponsor": sponsor,
          "name": name,
          "bloodGroup": bloodGroup,
          "lastDonateDate": "2024-01-24T15:34:37.150Z",
          "isDonor": isDonor.toString(),
        },
      );

      final responseBody = jsonDecode(response.body);
      isProgress.value = false;
      update();

      if (response.statusCode == 200) {
        return true;
      } else {
        _showErrorSnackbar(responseBody["errorMessages"][0]['message']);
        print(responseBody);
        return false;
      }
    } catch (e) {
      isProgress.value = false;
      update();
      _showErrorSnackbar("An error occurred. Please try again.");
      return false;
    }
  }

  void setDonorStatus(bool value) {
    isDonor = value;
    update();
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
