import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/screen/about_us_screen.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyColors.primaryColor,
        child: ListView(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    onTap: () => Get.back(),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Icon(Icons.close),
                    ))),
              ListTile(
                tileColor: MyColors.primaryColor,
               onTap: () => Get.to(()=> const AboutUsPage()),
              title: const Text("About Us",),
              leading: const Icon(Icons.info_outline,color: Colors.white),
            ),
             ListTile(
              tileColor: MyColors.primaryColor,
              selectedColor: Colors.red,
              title: const Text("Contact Us",),
              leading: const Icon(Icons.sms,color: Colors.white),
            ),
             ListTile(
              tileColor: MyColors.primaryColor,
              title: const Text("Our Social Media"),
              leading: const Icon(Icons.facebook,color: Colors.white),
            ),
            ListTile(
              tileColor: MyColors.primaryColor,
              onTap: () => Get.back(),
              title: const Text("Share App"),
              leading: const Icon(Icons.share,color: Colors.white),
            ),
            ListTile(
              tileColor: MyColors.primaryColor,
              onTap: (){

              },
              title: const Text("Logout"),
              leading: const Icon(Icons.logout,color: Colors.red),
            ),
          ],
        )
    );
  }
}