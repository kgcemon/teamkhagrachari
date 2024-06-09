import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:teamkhagrachari/presentation/controller/home_screen_controller.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';

class UpdateNewsMarquee extends StatelessWidget {
  const UpdateNewsMarquee({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: MyColors.secenderyColor),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: MyColors.secenderyColor),
              child: const Text(
                "Update:",
                style:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
            buildExpanded(),
          ],
        ),
      ),
    );
  }

  Expanded buildExpanded() {
    return Expanded(
      child: GetBuilder<HomeScreenController>(
        builder: (value) => value.loadingProgress == true
            ? LinearProgressIndicator(
                color: MyColors.primaryColor,
              )
            : Marquee(
                style: const TextStyle(color: Colors.white70),
                text: ' ${'1. ${value.newsList[0].title ?? ''}'
                    ' 2. ${value.newsList[1].title ?? ''} '
                    ' 3. ${value.newsList[2].title ?? ''}'} '),
      ),
    );
  }
}
