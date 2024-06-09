import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:teamkhagrachari/presentation/screen/main_nav_screen.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'package:teamkhagrachari/presentation/utils/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadScreen();
  }

  loadScreen() {
    Future.delayed(
      const Duration(seconds: 1),
      () => Get.offAll(const MainNavScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: const Center(
        child: Text(
          AllStrings.appNameBangla,
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
