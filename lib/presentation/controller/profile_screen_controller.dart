import 'package:get/get.dart';
import 'package:teamkhagrachari/data/model/network_response.dart';
import 'package:teamkhagrachari/data/model/profile_model.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import '../../data/urls..dart';

class ProfileScreenController extends GetxController {
  ProfileModel profileData = ProfileModel();
  bool isLoading = false;
  String? errorMessage;

  getProfile() async {
    if(profileData.data == null){
      isLoading = true;
    }
    update();

    NetworkResponse response = await NetworkCaller.getRequest(url: ApiUrl.profileUrl);

    if (response.isSuccess) {
      profileData = ProfileModel.fromJson(response.responseData);
    } else {
      errorMessage = response.errorMessage;
    }
    isLoading = false;
    update();
  }
}
