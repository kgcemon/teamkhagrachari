import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/utils/assets_path.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import '../../controller/auth/splash_screen_controller.dart';
import 'package:in_app_update/in_app_update.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }


  Future<void> checkForUpdate() async {
    print('checking for Update');
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        if (info.updateAvailability == UpdateAvailability.updateAvailable) {
          print('update available');
          update();
        }
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  void update() async {
    print('Updating');
    await InAppUpdate.startFlexibleUpdate();
    InAppUpdate.completeFlexibleUpdate().then((_) {}).catchError((e) {
      print(e.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    final SplashScreenController splashScreenController = Get.put(SplashScreenController());

    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Image.asset(AssetPath.logoGif,width: 200,),
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
