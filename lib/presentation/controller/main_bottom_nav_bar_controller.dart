import 'package:get/get.dart';

class NavButtonControllerController extends GetxController {

  int selectedIndex = 0;

  void changeIndex(int index) {
    selectedIndex = index;
    update();
  }

  void backToHome() {
    changeIndex(0);
  }

}