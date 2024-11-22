import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart' as Getx;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:teamkhagrachari/data/model/network_response.dart';
import 'package:teamkhagrachari/presentation/screen/auth/login_screen.dart';
import '../../presentation/controller/user_auth_controller.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      log('GET Request URL: $url');
      String token = UserAuthController.accessToken;
      log('Authorization Token: $token');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": token,
          "accept": "application/json",
        },
      );

      log('Response Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: true,
          responseData: decodedData,
        );
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        _goToSignInScreen();
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      } else {
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
          errorMessage: response.body,
        );
      }
    } catch (e) {
      log('Error: $e');
      return NetworkResponse(
        responseCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      log('POST Request URL: $url');

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': UserAuthController.accessToken,
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      log('Response Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: true,
          responseData: decodedData,
        );
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
          errorMessage: response.body,
        );
      }
    } catch (e) {
      log('Error: $e');
      return NetworkResponse(
        responseCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
  static Future<NetworkResponse> patchRequest({
    required String url,
    required String? token, // Explicit token parameter
    Map<String, dynamic>? body,
    required bool isMultipart,
  }) async {
    try {
      log('PATCH Request URL: $url');
      http.Response response;

      if (isMultipart) {
        // Multipart request
        final request = http.MultipartRequest('PATCH', Uri.parse(url));
        request.headers.addAll({
          'Authorization': token ?? UserAuthController.accessToken, // Use provided token
          'accept': 'application/json',
        });

        // Add fields and files
        body?.forEach((key, value) {
          if (value is File) {
            String fileName = value.path.split('/').last.toLowerCase();
            String fileExtension = fileName.split('.').last;

            // Validate file type
            if (fileExtension != 'jpg' &&
                fileExtension != 'jpeg' &&
                fileExtension != 'png') {
              throw Exception("Only JPEG, JPG, and PNG files are allowed.");
            }

            request.files.add(http.MultipartFile(
              key,
              value.readAsBytes().asStream(),
              value.lengthSync(),
              filename: fileName,
              contentType: MediaType('image', fileExtension), // Add proper MIME type
            ));
          } else {
            request.fields[key] = value.toString();
          }
        });

        final streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        // Standard JSON PATCH request
        response = await http.patch(
          Uri.parse(url),
          headers: {
            'Authorization': token ?? UserAuthController.accessToken, // Use provided token
            'accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body),
        );
      }

      log('Response Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: true,
          responseData: decodedData,
        );
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
          errorMessage: response.body,
        );
      }
    } catch (e) {
      log('Error: $e');
      return NetworkResponse(
        responseCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> deleteRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      log('DELETE Request URL: $url');

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': UserAuthController.accessToken,
          'accept': 'application/json',
        },
        body: jsonEncode(body),
      );

      log('Response Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: true,
          responseData: decodedData,
        );
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
          errorMessage: response.body,
        );
      }
    } catch (e) {
      log('Error: $e');
      return NetworkResponse(
        responseCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  static void _goToSignInScreen() {
    log('Redirecting to Sign-In Screen...');
    Getx.Get.to(() => const LoginScreen());
  }
}
