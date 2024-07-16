import 'package:get/get.dart';
import 'package:teamkhagrachari/data/model/network_response.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import '../../data/urls..dart';

class AddUserServiceController extends GetxController {
  bool isProgress = false;
  Future<Map<String, dynamic>> addUserServices({
    required String addressDegree,
    required String description,
    required String categoryID,
  }) async {
    isProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.postRequest(
      body: {
        "description": description,
        "servicesCatagory": categoryID,
        "addressDegree": addressDegree,
      },
      url: ApiUrl.addUserServicesUrl,
    );
    isProgress = false;
    update();
    if (response.isSuccess) {
      if (response.responseData['success'] == true) {
        return {
          'success': true,
          'message': response.responseData['message'],
          'data': response.responseData['data'],
        };
      } else {
        return {
          'success': false,
          'message': response.responseData['message'],
          'errorMessages': response.responseData['errorMessages'],
        };
      }
    } else {
      return {
        'success': false,
        'message': 'Network error or request failed',
      };
    }
  }
}
