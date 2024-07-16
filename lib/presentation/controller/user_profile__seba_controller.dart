import 'package:get/get.dart';
import 'package:teamkhagrachari/data/model/network_response.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import 'package:teamkhagrachari/data/urls..dart';
import '../../data/model/UserProfileSebaModel.dart';

class UserProfileSebaController extends GetxController {
  var filteredDetails = UserProfileSebaModel().obs;

  getLoadUserSeba() async {
    NetworkResponse response =
        await NetworkCaller.getRequest(url: ApiUrl.userServicesUrl);
    filteredDetails.value = UserProfileSebaModel.fromJson(response.responseData);
  }
}
