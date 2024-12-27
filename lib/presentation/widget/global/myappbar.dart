import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/controller/profile_screen_controller.dart';
import 'package:teamkhagrachari/presentation/utils/assets_path.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import '../../controller/main_bottom_nav_bar_controller.dart';

myAppbar({required String name}) {
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.white70),
    elevation: 10,
    backgroundColor: MyColors.secenderyColor,
    title: Padding(
      padding: const EdgeInsets.all(15.0),
      child: name.isEmpty
          ? Image.asset(AssetPath.titleImage)
          : Text(
              name,
              style: const TextStyle(color: Colors.white),
            ),
    ),
    actions: [
      IconButton(
          onPressed: () =>
              Get.find<NavButtonControllerController>().changeIndex(2),
          icon: Row(
            children: [
              const Icon(
                CupertinoIcons.star_circle_fill,
                color: Colors.orange,
                size: 16,
              ),
              GetBuilder<ProfileScreenController>(
                builder: (controller) =>  Text(
                  " ${controller.profileData.data?.balance ?? "0"}",
                  style: const TextStyle(color: Colors.orange, fontSize: 16),
                ),
              )
            ],
          )),
      const SizedBox(
        width: 10,
      )
    ],
  );
}
