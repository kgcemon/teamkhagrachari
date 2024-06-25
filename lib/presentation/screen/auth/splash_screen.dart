import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'package:teamkhagrachari/presentation/utils/strings.dart';
import '../../controller/auth/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashScreenController splashScreenController = Get.put(SplashScreenController());

    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AllStrings.appNameBangla,
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 20),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    backgroundColor: MyColors.primaryColor,
                    minHeight: 15,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    value: splashScreenController.progress.value / 100,
                    color: Colors.white,
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            Obx(() {
              return Text(
                '${splashScreenController.progress.value.toStringAsFixed(0)}%',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              );
            }),
          ],
        ),
      ),
    );
  }
}
