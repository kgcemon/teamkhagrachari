import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teamkhagrachari/bangla_convertor.dart';
import 'package:teamkhagrachari/presentation/add_user_service_screen.dart';
import 'package:teamkhagrachari/presentation/controller/profile_screen_controller.dart';
import 'package:teamkhagrachari/presentation/screen/add_product_screen.dart';
import 'package:teamkhagrachari/presentation/screen/profile/profile_update_screen.dart';
import 'package:teamkhagrachari/presentation/screen/profile/user_profile_service.dart';

import '../../utils/color.dart';
import '../profile/user_uploaded_product.dart';

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
                            GestureDetector(
                              onTap: () => Get.to(() => ProfileUpdateScreen(
                                profileData:
                                Get.find<ProfileScreenController>()
                                    .profileData,
                              )),
                              child: Hero(
                                tag: "emon",
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: MyColors.secenderyColor,
                                      backgroundImage: NetworkImage( Get.find<ProfileScreenController>()
                                          .profileData
                                          .data!
                                          .image
                                          .toString(),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: MyColors.primaryColor, width: 2),
                                        ),
                                        child:  const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: () => Get.to(() => ProfileUpdateScreen(
                                    profileData:
                                        Get.find<ProfileScreenController>()
                                            .profileData,
                                  )),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    color: MyColors.secenderyColor),
                                child: const Text(
                                  "Edit Profile",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
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
                        ElevatedButton.icon(onPressed: () {
                          Clipboard.setData(ClipboardData(text: "খাগড়াছড়িতে আপনার সকল প্রয়োজনীয় সেবার পূর্ণাঙ্গ সমাধান।Khagrachari Plus Apps download link:  https://play.google.com/store/apps/details?id=org.khagrachari.seba.teamkhagrachari রেজিস্ট্রেশন পেইজে আমার রেফারাল কোড ${controller.profileData.data?.sponsor} ব্যবহার করুন:"));
                          Get.snackbar("Copy", "Copy Successful");
                        }, label: Row(
                          children: [
                            const Text("Your Referral Code ",style: TextStyle(color: Colors.orange),),
                            Text(controller.profileData.data?.sponsor ?? "",style: const TextStyle(color: Colors.white),),
                            const SizedBox(width: 5,),
                            const Icon(Icons.copy,size: 16,color: Colors.orange,)
                          ],
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  _buildActionButtons(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Expanded(
                  //       child: ElevatedButton.icon(
                  //           icon: const Icon(Icons.computer,color: Colors.white,),
                  //           style: ElevatedButton.styleFrom(
                  //               padding: const EdgeInsets.all(3),
                  //               backgroundColor: Colors.orange),
                  //           onPressed: () => Get.to(
                  //                   () => const AddUserServiceScreen()),
                  //           label: const Text(
                  //             textAlign: TextAlign.center,
                  //             "সেবা যুক্ত করুন",
                  //             style: TextStyle(color: Colors.white,fontSize: 12),
                  //           )),
                  //
                  //     ),
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     Expanded(
                  //       child: ElevatedButton.icon(
                  //           icon: const Icon(Icons.shopping_cart,color: Colors.white,),
                  //           style: ElevatedButton.styleFrom(
                  //               padding: const EdgeInsets.all(3),
                  //               backgroundColor: Colors.orange),
                  //           onPressed: () {
                  //             Get.to(() => const AddProductScreen());
                  //           },
                  //           label: const Text(
                  //             textAlign: TextAlign.center,
                  //             "পণ্য বিক্রি করুন",
                  //             style: TextStyle(color: Colors.white,fontSize: 12),
                  //           )),
                  //     ),
                  //
                  //   ],
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => Get.to(() => const UserProfileServiceScreen()),
                    child: const ProfileItem(
                        label: 'আপনার সেবা সমুহ',
                        value: "আপনার সকল সেবা সেখতে ক্লিক করুন",
                        iconData: Icons.local_activity),
                  ),
                  InkWell(
                    onTap: () => Get.to(() => const UserUploadedProduct()),
                    child: const ProfileItem(
                        label: 'আপনার পণ্য সমুহ',
                        value: "আপনার সকল পণ্য সেখতে ক্লিক করুন",
                        iconData: Icons.production_quantity_limits),
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

Widget _buildActionButtons() {
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: _buildActionButton(
              icon: Icons.design_services,
              label: 'সেবা যুক্ত করুন',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildActionButton(
              icon: Icons.shopping_bag,
              label: 'পণ্য বিক্রি করুন',
            ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildActionButton({
  required IconData icon,
  required String label,
}) {
  return Material(
    borderRadius: BorderRadius.circular(12),
    color: Colors.white.withOpacity(0.15),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => label.contains('সেবা যুক্ত করুন')
          ? Get.to(() => const AddUserServiceScreen())
          : Get.to(() => const AddProductScreen()),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MyColors.primaryColor),
        ),
        child: Column(
          children: [
            Icon(icon, size: 32, color: MyColors.white),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: MyColors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
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
