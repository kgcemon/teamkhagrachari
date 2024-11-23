import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/controller/user_auth_controller.dart';
import 'package:teamkhagrachari/presentation/screen/auth/forgot_pass_change_screen.dart';
import '../../../data/urls..dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var isProgress = false.obs;
  RxBool obscurePassword = true.obs;

  Future<bool> userLogin({required String email, required String password}) async {
    isProgress.value = true;
    update();
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };

    var response = await http.post(Uri.parse(ApiUrl.loginUrls),body: body);
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
     await UserAuthController.saveUserToken(responseBody["data"]["accessToken"]);
     print(UserAuthController.accessToken);
     print(responseBody["data"]["accessToken"]);
      isProgress.value = false;
      return true;
    } else {
      Get.snackbar(
        backgroundColor: Colors.red,
          colorText: Colors.white,
          "Error", responseBody["message"]);
    }
    isProgress.value = false;
    return false;
  }

   obscurePasswordChanger(){
     obscurePassword.value = !obscurePassword.value;
  }


  forgetPassApiCall({required String email}) async {
    isProgress.value = true;
    Uri url = Uri.parse(
        "https://api.khagrachariplus.com/api/v1/auth/forgot-password");
   var response = await http.post(url, body:
     {"email": email}
    );
   print(response.body);

   var data = jsonDecode(response.body);

   if(response.statusCode == 200 && data['success'] == true){
     Get.snackbar("Result", 'আপনার ইমেইলে একটি কোড সেন্ড করা হয়েছে');
     Get.to(()=> const ForgotPassChangeScreen());
     isProgress.value = false;
   }else{
     Get.snackbar("Result", data['message']);
   }
    isProgress.value = false;
  }

}
