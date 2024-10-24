import 'package:get/get.dart';
import 'package:teamkhagrachari/data/model/network_response.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import 'package:teamkhagrachari/presentation/utils/local_storage.dart';
import 'package:teamkhagrachari/push_notification.dart';
import '../../data/urls..dart';

class AddUserServiceController extends GetxController {
  bool isProgress = false;

  Future<Map<String, dynamic>> addUserServices({
    required String addressDegree,
    required String description,
    required String categoryID,
    required String name,
    required String phone,
  }) async {
    isProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.postRequest(
      body: {
        "serviceProviderName": name,
        "description": description,
        "servicesCatagory": categoryID,
        "addressDegree": addressDegree,
        "phone": phone,
        "token": notificationToken
      },
      url: ApiUrl.addUserServicesUrl,
    );

    isProgress = false;
    update();

    if (response.isSuccess) {
      if (response.responseData != null && response.responseData['success'] == true) {
        return {
          'success': true,
          'message': response.responseData['message'],
          'data': response.responseData['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.responseData?['message'] ?? 'Unknown error',
          'errorMessages': response.responseData?['errorMessages'] ?? [],
        };
      }
    } else if (response.responseCode == 400) {
      // Capture and return the validation error message
      String errorMessage = response.responseData?['errorMessages'] != null
          ? response.responseData!['errorMessages'][0]['message']
          : 'Validation error';

      return {
        'success': false,
        'message': errorMessage,
        'errorMessages': response.responseData?['errorMessages'] ?? [],
      };
    } else {
      return {
        'success': false,
        'message': 'Network error or request failed',
      };
    }
  }
}
