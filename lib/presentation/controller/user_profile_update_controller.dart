import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/urls..dart';
import '../controller/user_auth_controller.dart'; // Updated import for UserAuthController
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';

class UserProfileUpdateController extends GetxController {
  var isProgress = false.obs;
  bool isDonor = true;

  /// Update user profile with optional image upload
  Future<bool> getUserProfileUpdate({
    required String userid,
    required String email,
    required String phone,
    required String bloodGroup,
    required String upazila,
    required String name,
    required String lastDonateDate,
    File? profileImage, // Optional image file
  }) async {
    isProgress.value = true;
    update();

    try {
      // Prepare the request body for non-multipart fields
      final Map<String, dynamic> body = {
        "email": email,
        "phone": phone,
        "upazila": upazila,
        "name": name,
        "bloodGroup": bloodGroup,
        "lastDonateDate": lastDonateDate,
        "isDonor": isDonor.toString(),
      };

      // If an image is provided, include it in the body
      Map<String, dynamic> finalBody = body;
      if (profileImage != null) {
        finalBody = {
          ...body,
          "image": profileImage, // Field name must match API expectations
        };
      }

      // Fetch the token from UserAuthController
      String token = UserAuthController.accessToken;

      // Call NetworkCaller to handle the request
      final response = await NetworkCaller.patchRequest(
        url: ApiUrl.userProfileUpdateUrl + userid,
        body: finalBody,
        isMultipart: profileImage != null,
        token: token,
      );

      isProgress.value = false;
      update();

      if (response.isSuccess) {
        return true;
      } else {
        _showErrorSnackbar(
          response.responseData?["message"] ?? "Update failed",
        );
        return false;
      }
    } catch (e) {
      isProgress.value = false;
      update();
      _showErrorSnackbar("An error occurred. Please try again.");
      return false;
    }
  }

  /// Sets the donor status
  bool setDonorStatus(bool value) {
    isDonor = value;
    update();
    return isDonor;
  }

  /// Displays an error snackbar
  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}