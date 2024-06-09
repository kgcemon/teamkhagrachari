import 'package:flutter/material.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';

class MyInput extends StatelessWidget {
  String hitText;
  IconData iconData;
  TextEditingController controller;
   MyInput({super.key,required this.hitText,required this.iconData,required this.controller});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintStyle: const TextStyle(fontSize: 13),
        disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: MyColors.primaryColor),),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: MyColors.primaryColor)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: MyColors.primaryColor)),
        prefixIcon:  Icon(iconData),
        hintText: hitText,
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        fillColor: const Color(0xfff8f8f8e0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );
  }
}
