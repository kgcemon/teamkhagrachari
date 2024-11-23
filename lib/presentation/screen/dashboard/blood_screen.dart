import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:teamkhagrachari/presentation/controller/blood_screen_controller.dart';
import 'package:teamkhagrachari/presentation/screen/dashboard/profile_screen.dart';
import 'package:teamkhagrachari/presentation/utils/assets_path.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'package:teamkhagrachari/presentation/utils/uri_luncher.dart';
import 'dart:math';

class BloodScreen extends StatefulWidget {
  const BloodScreen({super.key});

  @override
  State<BloodScreen> createState() => _BloodScreenState();
}

class _BloodScreenState extends State<BloodScreen> {
  String selectedBloodGroup = 'রক্তের গ্রুপ';
  String selectedUpazila = 'উপজেলা';

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () => loadDialoge(),
    );
  }

  loadDialoge() async {
    Get.defaultDialog(
      backgroundColor: const Color(0xff77040d),
      titleStyle: const TextStyle(color: Colors.white),
      title: "রক্তদাতা খুঁজছেন?",
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "ঠিক আছে",
              style: TextStyle(color: Colors.white),
            ))
      ],
      content: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          "★ যে রক্তের গ্রুপগুলো সবুজ রঙের বৃত্তের ভেতর, তাঁরা রক্ত দেওয়ার জন্যে এভেইলেবল আছেন। \n \n ★ যে রক্তের গ্রুপগুলো লাল রঙের বৃত্তের ভেতর, তাঁদের রক্ত দেওয়ার সময় এখনো হয়নি। \n \n ★ রক্তদাতাকে সালাম দিয়ে শুরুতেই বলুন, Khagrachari Plus থেকে আপনার নাম্বার সংগ্রহ করেছি। আপনি কি আজ রক্ত দিতে পারবেন?\n \n ★ রক্তদাতার সাথে সর্বোচ্চ ভদ্রতার সহিত সম্মান দিয়ে কথা বলবেন। সামর্থ্য থাকলে ব্লাড দেওয়া শেষে চেষ্টা করবেন রক্তদাতাকে একটি ডাব খাওয়ানোর।\n \n ★রক্তদান পরবর্তী ন্যুনতম ১ সপ্তাহ পর রক্তদাতার শারিরীক অবস্থার খোঁজ নেওয়ার চেষ্টা করবেন। সুসম্পর্ক বজায় রাখার চেষ্টা করবেন।",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const ProfileScreen());
        },
        label: const Text(
          "রক্তদাতা হিসাবে যুক্ত হোন",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        icon: const Icon(Icons.add, color: Colors.white, size: 20),
        backgroundColor: Colors.green,
        // You can change this to any color you like
        splashColor: Colors.tealAccent, // The splash effect color when tapped
      ),
      backgroundColor: MyColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Image.network(
                "https://khagrachariplus.com/wp-content/uploads/2024/11/blood.gif"),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.13),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      value: selectedBloodGroup,
                      onChanged: (value) {
                        setState(() {
                          selectedBloodGroup = value!;
                        });
                        Get.find<BloodScreenController>().filterDonors(
                          bloodGroup: selectedBloodGroup,
                          upazila: selectedUpazila,
                        );
                      },
                      items: <String>[
                        'রক্তের গ্রুপ',
                        'A+',
                        'A-',
                        'B+',
                        'B-',
                        'AB+',
                        'AB-',
                        'O+',
                        'O-'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: MyColors.white),
                          ),
                        );
                      }).toList(),
                      hint: const Text('Select Blood Group'),
                      isExpanded: true,
                      dropdownColor: MyColors.secenderyColor,
                      style: TextStyle(color: MyColors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.13),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      value: selectedUpazila,
                      onChanged: (value) {
                        setState(() {
                          selectedUpazila = value!;
                        });
                        Get.find<BloodScreenController>().filterDonors(
                          bloodGroup: selectedBloodGroup,
                          upazila: selectedUpazila,
                        );
                      },
                      items: <String>[
                        'উপজেলা',
                        'খাগড়াছড়ি সদর',
                        'পানছড়ি',
                        'মাটিরাঙ্গা',
                        'দীঘিনালা',
                        'মানিকছড়ি',
                        'লক্ষীছড়ি',
                        'মহালছড়ি',
                        'গুইমারা',
                        'রামগড়',
                        'ঢাকা',
                        'চট্টগ্রাম'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: MyColors.white),
                          ),
                        );
                      }).toList(),
                      hint: const Text('Select Upazila'),
                      isExpanded: true,
                      dropdownColor: MyColors.secenderyColor,
                      style: TextStyle(color: MyColors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            GetBuilder<BloodScreenController>(
              builder: (value) {
                // Shuffle the list to make it random
                final random = Random();
                final shuffledList = value.filteredList.toList()
                  ..shuffle(random);

                return Expanded(
                  child: Visibility(
                    visible: shuffledList.isNotEmpty,
                    replacement: Lottie.asset(AssetPath.loadingJson),
                    child: AnimationLimiter(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final donor = shuffledList[index];
                          final lastDonateDate =
                              DateTime.parse(donor.lastDonateDate ?? '');
                          final difference = DateTime.now()
                              .difference(lastDonateDate)
                              .inDays;
                          final textColor =
                              difference >= 120 ? Colors.green : Colors.red;

                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 900),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: textColor),
                                      color: Colors.white.withOpacity(0.13),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      tileColor: Colors.transparent,
                                      onTap: () => _popup(donor, textColor),
                                      leading: Container(
                                        width: 60,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: NetworkImage(donor.image ?? ""),fit: BoxFit.cover),
                                          borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: difference >= 120 ? Colors.green : Colors.red)),
                                        ),
                                      title: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            donor.bloodGroup ?? '',
                                            style: TextStyle(
                                                color: difference >= 120
                                                    ? Colors.green
                                                    : Colors.red),
                                          ),
                                          Text(
                                            donor.name ?? '',
                                            style: TextStyle(
                                                color: MyColors.white),
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        donor.upazila ?? '',
                                        style: const TextStyle(
                                            color: Colors.yellow,
                                            fontSize: 10),
                                      ),
                                      trailing:  SizedBox(
                                              width: 80,
                                              height: 25,
                                              child: ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(backgroundColor: difference >= 120
                                                    ? Colors.green : Colors.red),
                                                onPressed: () => difference >= 120
                                                    ? uriLaunchUrl('tel:${donor.phone}') : null,
                                                icon: const Icon(Icons.call,color: Colors.white,size: 12,),
                                                label: const Text(
                                                  "Call",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: shuffledList.length,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _popup(var donor, var textColor) {
    Get.defaultDialog(
      title: "রক্তদাতার বিবরণ",
      backgroundColor: MyColors.primaryColor,
      titleStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar with donor image
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(donor.image),
            ),
          ),
          const SizedBox(height: 15),

          // Donor name
          Text(
            donor.name ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),

          // Last donation date
          FittedBox(
            child: _buildPopUp(
              donor.lastDonateDate?.split("T")[0] ?? '',
              "সর্বশেষ রক্তদানের তারিখ:",
              textColor,
            ),
          ),

          // Upazila
          _buildPopUp(
            donor.upazila ?? '',
            "উপজেলা:",
            textColor,
          ),

          // Phone number
          _buildPopUp(
            donor.phone ?? '',
            "ফোন:",
            textColor,
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Call Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(90, 40),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadowColor: Colors.black26,
                elevation: 4,
              ),
              onPressed: () => textColor == Colors.green
                  ? uriLaunchUrl('tel:${donor.phone ?? ''}') : null,
              icon: const Icon(
                Icons.call,
                color: Colors.white,
              ),
              label: const Text(
                "Call",
                style: TextStyle(color: Colors.white),
              ),
            ),

            // Cancel Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(90, 40),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadowColor: Colors.black26,
                elevation: 4,
              ),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

// Reusable widget for displaying donor details
  Widget _buildPopUp(String data, String label, [Color? textColor]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: MyColors.secenderyColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColors.white, width: 0.8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              data,
              style: TextStyle(
                color: textColor ?? MyColors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
