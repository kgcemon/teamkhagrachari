import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            const ListTile(
              title: Text("About Us",),
              leading: Icon(Icons.info_outline),
            ),
            const ListTile(
              selectedColor: Colors.red,
              title: Text("Contact Us",),
              leading: Icon(Icons.sms),
            ),
            const ListTile(
              title: Text("Our Social Media"),
              leading: Icon(Icons.facebook),
            ),
            ListTile(
              onTap: () => Get.back(),
              title: const Text("Share App"),
              leading: const Icon(Icons.share),
            ),
            ListTile(
              onTap: (){

              },
              title: const Text("Logout"),
              leading: const Icon(Icons.logout),
            ),
          ],
        )
    );
  }
}