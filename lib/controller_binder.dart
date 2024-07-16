import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/controller/add_user_service_controller.dart';
import 'package:teamkhagrachari/presentation/controller/auth/register_screen_controller.dart';
import 'package:teamkhagrachari/presentation/controller/blood_screen_controller.dart';
import 'package:teamkhagrachari/presentation/controller/home_screen_controller.dart';
import 'package:teamkhagrachari/presentation/controller/main_bottom_nav_bar_controller.dart';
import 'package:teamkhagrachari/presentation/controller/profile_screen_controller.dart';
import 'package:teamkhagrachari/presentation/controller/seba_details_screen_controller.dart';
import 'package:teamkhagrachari/presentation/controller/user_profile__seba_controller.dart';
import 'package:teamkhagrachari/presentation/controller/user_profile_update_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController());
    Get.put(BloodScreenController());
    Get.put(NavButtonControllerController());
    Get.put(SebaDetailsScreenController());
    Get.put(ProfileScreenController());
    Get.put(RegisterController());
    Get.put(AddUserServiceController());
    Get.put(UserProfileUpdateController());
    Get.put(UserProfileSebaController());
  }
}
