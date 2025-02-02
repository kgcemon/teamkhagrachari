import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teamkhagrachari/presentation/controller/blood_screen_controller.dart';
import 'package:teamkhagrachari/presentation/controller/buy_sell_screen_controller.dart';
import 'package:teamkhagrachari/presentation/controller/main_bottom_nav_bar_controller.dart';
import 'package:teamkhagrachari/presentation/screen/dashboard/blood_screen.dart';
import 'package:teamkhagrachari/presentation/screen/dashboard/home_screen.dart';
import 'package:teamkhagrachari/presentation/screen/dashboard/profile_screen.dart';
import 'package:teamkhagrachari/presentation/widget/app_drawer.dart';
import 'package:teamkhagrachari/presentation/widget/global/myappbar.dart';
import '../controller/home_screen_controller.dart';
import '../controller/profile_screen_controller.dart';
import '../controller/user_auth_controller.dart';

class MainNavScreen extends StatefulWidget {
 final String title;
  const MainNavScreen({super.key,required this.title});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const BloodScreen(),
      const ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    Get.find<HomeScreenController>().loadNews();
    Get.find<BloodScreenController>().fetchBloodDetails();
    loadBalance();
  }


  loadBalance()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var data = await sharedPreferences.get("token");
   if(data !=null){
     Get.find<ProfileScreenController>().getProfile();
   }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(name: ''),
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
