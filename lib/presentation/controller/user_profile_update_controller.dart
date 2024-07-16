import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import '../../../data/urls..dart';

class UserProfileUpdateController extends GetxController {
  var isProgress = false.obs;
  bool isDonor = true;

  Future<bool> getUserProfileUpdate({
    required String userid,
    required String email,
    required String phone,
    required String bloodGroup,
    required String upazila,
    required String name,
    required String lastDonateDate,
  }) async {
    isProgress.value = true;
    update();

    try {
      final response = await NetworkCaller.patchRequest(
          url: ApiUrl.userProfileUpdateUrl+userid,
          body: {
            "email": email,
            "phone": phone,
            "upazila": upazila,
            "name": name,
            "bloodGroup": bloodGroup,
            "lastDonateDate": lastDonateDate,
            "isDonor": isDonor.toString(),
          });
      isProgress.value = false;
      update();
      if (response.isSuccess) {
        update();
        return true;
      } else {
        _showErrorSnackbar(response.responseData["message"]);
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
