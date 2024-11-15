import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:teamkhagrachari/presentation/controller/user_auth_controller.dart';
import 'package:teamkhagrachari/presentation/screen/about_us_screen.dart';
import 'package:teamkhagrachari/presentation/screen/auth/login_screen.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'package:teamkhagrachari/presentation/utils/uri_luncher.dart';

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
                ),
              ),
            ),
            // ListTile(
            //   tileColor: MyColors.primaryColor,
            //   onTap: () => Get.to(() => ProfileUpdateScreen(
            //     profileData: Get.find<ProfileScreenController>().profileData,
            //   )),
            //   title: const Text(
            //     "Update Profile",
            //   ),
            //   leading: const Icon(Icons.person, color: Colors.white),
            // ),
            ListTile(
              tileColor: MyColors.primaryColor,
              onTap: () => Get.to(() => const AboutUsPage()),
              title: const Text(
                "About Us",
              ),
              leading: const Icon(Icons.info_outline, color: Colors.white),
            ),
            ListTile(
              onTap: () =>
                  uriLaunchUrl("https://facebook.com/groups/khagrachariplus/"),
              tileColor: MyColors.primaryColor,
              title: const Text("Our Social Media"),
              leading: const Icon(Icons.facebook, color: Colors.white),
            ),
            ListTile(
              tileColor: MyColors.primaryColor,
              onTap: () async {
                final result = await Share.share(
                    'খাগড়াছড়িতে একের ভেতর সকল সেবা পেতে এখনি ডাউনলোড করুন  https://play.google.com/store/apps/details?id=org.khagrachari.seba.teamkhagrachari');
                if (result.status == ShareResultStatus.success) {
                  Get.snackbar("Thanks", "Thanks for share our app");
                }
              },
              title: const Text("Share App"),
              leading: const Icon(Icons.share, color: Colors.white),
            ),
            ListTile(
              tileColor: MyColors.primaryColor,
              onTap: () => uriLaunchUrl(
                  "https://khagrachariplus.com/privacy-policy.html"),
              title: const Text("Privacy Policy"),
              leading: const Icon(Icons.privacy_tip, color: Colors.green),
            ),
            UserAuthController.accessToken.isNotEmpty
                ? ListTile(
              tileColor: MyColors.primaryColor,
              onTap: () {
                UserAuthController.clearUserData().then((value) {
                  // Reset selected index to home (0)
                  Get.to(()=>const LoginScreen());
                });
              },
              title: const Text("Log Out"),
              leading: const Icon(Icons.logout_outlined, color: Colors.green),
            )
                : const SizedBox(),

          ],
        ));
  }
}
