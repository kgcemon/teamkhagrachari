import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/controller/home_screen_controller.dart';
import 'package:teamkhagrachari/presentation/controller/user_auth_controller.dart';
import '../../screen/main_nav_screen.dart';

class SplashScreenController extends GetxController {
  var progress = 0.0.obs;
  final HomeScreenController _homeScreenController = Get.find<HomeScreenController>();

  @override
  void onInit()async{
    super.onInit();
  await UserAuthController.getUserToken();
    loadAllData();
  }

  void loadAllData() async {
    await _homeScreenController.loadAll(onProgress: (p) {
      progress.value = p;
    });
    Get.offAll(() => const MainNavScreen(title: 'Khagrachari Plus'));
  }
}
