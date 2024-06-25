import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:teamkhagrachari/controller_binder.dart';
import 'package:teamkhagrachari/presentation/screen/auth/splash_screen.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';


class TeamKhagrachari extends StatelessWidget {
  const TeamKhagrachari({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinder(),
      theme: ThemeData(
        iconTheme: const IconThemeData(color: Colors.white),
        listTileTheme:  const ListTileThemeData(
          leadingAndTrailingTextStyle: TextStyle(color: Colors.white),
          subtitleTextStyle: TextStyle(color: Colors.white70),
          titleTextStyle: TextStyle(color: Colors.white),
          ),
        colorSchemeSeed: MyColors.white,
        scaffoldBackgroundColor: MyColors.primaryColor,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          unselectedItemColor: Colors.white70,
            selectedItemColor: Colors.red,
            backgroundColor: Colors.black),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(fontSize: 14),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.secenderyColor),
          ),
          enabledBorder: inputStyle(),
          focusedBorder: inputStyle(),
          contentPadding: const EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyColors.white),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            backgroundColor: MyColors.primaryColor,
            minimumSize: const Size(double.infinity, 45),
          ),
        ),
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: MyColors.secenderyColor,
          centerTitle: true,
        ),
      ),
      home: const SplashScreen(),
    );
  }

  inputStyle()=> OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: MyColors.white.withOpacity(0.35)),);
}
