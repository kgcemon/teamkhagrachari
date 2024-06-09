import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:teamkhagrachari/data/model/network_response.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      log(url);
      final Response response =
          await get(Uri.parse(url), headers: {"Authorization": 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InVzZXI1QGdtYWlsLmNvbSIsInJvbGUiOiJ1c2VyIiwiX2lkIjoiNjY0MjQwODU3YjgzMGZmNjU4ZTcyNWY2IiwiaWF0IjoxNzE2MjI2NDcxLCJleHAiOjE3MTY4MzEyNzF9.zqkBfTmN2pjvW_nXkkRv1yZ_FivdiFpg9lbD_T-laX4'});
      log(response.statusCode.toString());
      log(response.body.toString());
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            responseCode: response.statusCode,
            isSuccess: true,
            responseData: decodedData);
      } else if (response.statusCode == 401) {
        //_goToSignInScreen();
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
          headers: {'Authorization': '', 'accept': 'application/json'},
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
        //_goToSignInScreen();
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

// static void _goToSignInScreen() {
//   // Navigator.push(
//   //   CraftyBay.navigationKey.currentState!.context,
//   //   MaterialPageRoute(
//   //     builder: (context) => const EmailVerificationScreen(),
//   //   ),
//   // );
//   getx.Get.to(() => const EmailVerificationScreen());
// }
}
