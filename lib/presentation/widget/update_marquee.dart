import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import '../controller/scroll_text_controller.dart';

class UpdateNewsMarquee extends StatefulWidget {
  const UpdateNewsMarquee({super.key});

  @override
  State<UpdateNewsMarquee> createState() => _UpdateNewsMarqueeState();
}

class _UpdateNewsMarqueeState extends State<UpdateNewsMarquee> {
  HomePageScrollTextController controller = HomePageScrollTextController();

  @override
  void initState() {
    super.initState();
    controller.getLoadScrollText();
  }

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
      child: Obx(
        () => controller.filteredDetails.value.data == null
            ? const CupertinoActivityIndicator()
            : Marquee(
                style: const TextStyle(
                    color: Colors.white70, fontFamily: 'banglafont'),
                text: '${controller.filteredDetails.value.data?[0].text}'),
      ),
    );
  }
}
