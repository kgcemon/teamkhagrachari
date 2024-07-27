import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
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
      child: name.isEmpty ? Image.asset(AssetPath.titleImage) : Text(name,style: const TextStyle(color: Colors.white),),
    ),
    actions: [
      IconButton(
          onPressed: () =>
              Get.find<NavButtonControllerController>().changeIndex(2),
          icon: const Icon(Icons.person)),
      const SizedBox(
        width: 10,
      )
    ],
  );
}
