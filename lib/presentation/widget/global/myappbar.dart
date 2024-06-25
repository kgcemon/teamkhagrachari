import 'package:flutter/material.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';


myAppbar({required String name}){
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.white70),
    elevation: 10,
    backgroundColor: MyColors.secenderyColor,
    title:  Text(name,style: const TextStyle(color: Colors.white70),),
    actions: const [
      Icon(Icons.notifications),
      SizedBox(
        width: 10,
      )
    ],
  );
}