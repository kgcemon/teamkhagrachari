import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teamkhagrachari/bangla_convertor.dart';
import 'package:teamkhagrachari/presentation/add_user_service_screen.dart';
import 'package:teamkhagrachari/presentation/controller/profile_screen_controller.dart';
import 'package:teamkhagrachari/presentation/screen/profile/profile_update_screen.dart';
import 'package:teamkhagrachari/presentation/screen/profile/user_profile_service.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import '../../controller/user_auth_controller.dart';
import '../../widget/url_luncher.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProfileScreenController>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileScreenController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.profileData.data == null) {
            return const Center(child: Text('Failed to load profile'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 230,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.13),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(90)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(90),
                                  child: Image.network(
                                    "https://pbs.twimg.com/media/FjU2lkcWYAgNG6d.jpg",
                                    height: 60,
                                  ),
                                )),
                            const AppbarPopUpMenuWidget()
                          ],
                        ),
                        Text(
                          controller.profileData.data?.name ?? "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 11,
                              color: Colors.white,
                            ),
                            Text(
                              controller.profileData.data?.upazila ?? "",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 11),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 11,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              controller.profileData.data?.phone ?? "",
                              style: const TextStyle(
                                  fontSize: 11, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange),
                                  onPressed: () => Get.to(
                                      () => const AddUserServiceScreen()),
                                  child: const Text(
                                    "সেবা যুক্ত করুন",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  onPressed: () {
                                    Get.snackbar("Coming..", "coming soon");
                                  },
                                  child: const Text(
                                    "পণ্য বিক্রি করুন",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => Get.to(()=> const UserProfileServiceScreen()),
                    child: const ProfileItem(
                        label: 'আপনার সেবা সমুহ',
                        value: "আপনার সকল সেবা সেখতে ক্লিক করুন",
                        iconData: Icons.local_activity),
                  ),
                  ProfileItem(
                    label: 'সর্বশেষ রক্তদানের তারিখ:',
                    value: BanglaConvertor.convertPrice(
                      DateFormat('dd/MM/yyyy').format(
                        DateTime.parse(
                          controller.profileData.data!.lastDonateDate
                              .toString(),
                        ),
                      ),
                    ),
                    iconData: Icons.date_range,
                  ),
                  ProfileItem(
                    label: 'পরবর্তী রক্তদানের তারিখ:',
                    value: "${BanglaConvertor.convertPrice(
                      DateFormat('dd/MM/yyyy').format(
                        DateTime.parse(controller
                                .profileData.data!.lastDonateDate
                                .toString())
                            .toLocal()
                            .add(const Duration(days: 120)),
                      ),
                    )} (${BanglaConvertor.convertPrice((DateTime.parse(controller.profileData.data!.lastDonateDate.toString()).add(const Duration(days: 120)).difference(DateTime.now()).inDays).toString()).contains("-") ? "আপনি এখন রক্ত দিতে পারবেন" : "${BanglaConvertor.convertPrice((DateTime.parse(controller.profileData.data!.lastDonateDate.toString()).add(const Duration(days: 120)).difference(DateTime.now()).inDays).toString())}দিন বাকি"})",
                    iconData: Icons.date_range,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData iconData;

  const ProfileItem(
      {super.key,
      required this.label,
      required this.value,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        tileColor: Colors.white.withOpacity(0.15),
        leading: Icon(
          iconData,
          color: Colors.white,
        ),
        title: Text(label),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 11),
        ),
      ),
    );
  }
}

class AppbarPopUpMenuWidget extends StatelessWidget {
  const AppbarPopUpMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: MyColors.primaryColor,
      shadowColor: Colors.transparent,
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () => Get.to(() => ProfileUpdateScreen(
                  profileData: Get.find<ProfileScreenController>().profileData,
                )),
            value: "Profile Edit",
            child: const Row(
              children: [
                Icon(Icons.edit, color: Colors.white),
                Text(
                  " Profile Edit",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          const PopupMenuItem(
            value: "Log Out",
            child: Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                Text(
                  " Log Out",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ];
      },
      onSelected: (value) {
         if (value.contains("Log Out")) {
          UserAuthController.clearUserData();
          Get.offAll(() => const LoginScreen());
        } else if (value.contains("Remove Account")) {
        }
      },
    );
  }
}
