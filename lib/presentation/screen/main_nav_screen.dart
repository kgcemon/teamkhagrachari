import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:teamkhagrachari/presentation/controller/blood_screen_controller.dart';
import 'package:teamkhagrachari/presentation/controller/main_bottom_nav_bar_controller.dart';
import 'package:teamkhagrachari/presentation/screen/dashboard/blood_screen.dart';
import 'package:teamkhagrachari/presentation/screen/dashboard/home_screen.dart';
import 'package:teamkhagrachari/presentation/screen/dashboard/profile_screen.dart';
import 'package:teamkhagrachari/presentation/widget/app_drawer.dart';
import 'package:teamkhagrachari/presentation/widget/global/myappbar.dart';

import '../controller/home_screen_controller.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const BloodScreen(),
     ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    Get.find<HomeScreenController>().loadAll();
    Get.find<BloodScreenController>().fetchBloodDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(),
      drawer: const CustomDrawer(),
      bottomNavigationBar: GetBuilder<NavButtonControllerController>(
        builder: (navBtnController) => BottomNavigationBar(
          currentIndex: navBtnController.selectedIndex,
          selectedItemColor: Colors.red,
          onTap: (value) => navBtnController.changeIndex(value),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bloodtype_outlined), label: "Blood"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
      body: GetBuilder<NavButtonControllerController>(
        builder: (controller) => _screens.elementAt(controller.selectedIndex),
      ),
    );
  }
}
