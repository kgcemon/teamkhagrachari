import 'package:flutter/material.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'package:teamkhagrachari/presentation/utils/strings.dart';

myAppbar(){
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.white70),
    elevation: 10,
    backgroundColor: MyColors.secenderyColor,
    title: const Text(AllStrings.appNameBangla,style: TextStyle(color: Colors.white70),),
    actions: const [
      Icon(Icons.notifications),
      SizedBox(
        width: 10,
      )
    ],
  );
}