import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:teamkhagrachari/presentation/controller/blood_screen_controller.dart';
import 'package:teamkhagrachari/presentation/utils/assets_path.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'package:teamkhagrachari/presentation/utils/uri_luncher.dart';

class BloodScreen extends StatefulWidget {
  const BloodScreen({super.key});

  @override
  State<BloodScreen> createState() => _BloodScreenState();
}

class _BloodScreenState extends State<BloodScreen> {
  String selectedBloodGroup = 'রক্তের গ্রুপ';
  String selectedUpazila = 'উপজেলা';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
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
                          'মাইসছড়ি',
                          'গুইমারা',
                          'রামগড়'
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
                builder: (value) => Expanded(
                  child: Visibility(
                    visible: value.filteredList.isNotEmpty,
                    replacement: Lottie.asset(AssetPath.loadingJson),
                    child: AnimationLimiter(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final donor = value.filteredList[index];
                          final lastDonateDate =
                              DateTime.parse(donor.lastDonateDate ?? '');
                          final difference =
                              DateTime.now().difference(lastDonateDate).inDays;
                          final textColor =
                              difference >= 120 ? Colors.green : Colors.red;

                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 900),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: textColor),
                                      color: Colors.white.withOpacity(0.13),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      tileColor: Colors.transparent,
                                      onTap: () => _popup(donor,textColor),
                                      leading: CircleAvatar(
                                        backgroundColor: textColor,
                                        child: Text(
                                          donor.bloodGroup ?? '',
                                          style: TextStyle(color: MyColors.white),
                                        ),
                                      ),
                                      title: Text(
                                        donor.name ?? '',
                                        style: TextStyle(color: MyColors.white),
                                      ),
                                      subtitle: Text(
                                        donor.upazila ?? '',
                                        style: TextStyle(color: MyColors.white),
                                      ),
                                      trailing: InkWell(
                                        onTap: () =>
                                            uriLaunchUrl('tel:${donor.phone}'),
                                        child: const Icon(
                                          Icons.call,
                                          size: 35,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: value.filteredList.length,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  _popup(var donor, var textColor){
    Get.defaultDialog(
      title: "Donors Details",
      backgroundColor: MyColors.primaryColor,
      titleStyle:
      TextStyle(color: MyColors.white),
      content: Column(
        children: [
          const CircleAvatar(
            child: Icon(Icons.person),
          ),
          Text(
            donor.name ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          _buildPopUp(
            donor.lastDonateDate
                ?.split(" ")[0] ??
                '',
            "Last Donate Date:",
            textColor,
          ),
          _buildPopUp(
            donor.upazila ?? '',
            "Upazila:",
          ),
          _buildPopUp(
            donor.phone ?? '',
            "Phone:",
          ),
        ],
      ),
      actions: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          onPressed: () {},
          icon: const Icon(Icons.call),
          label: const Text("Call"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor:
            MyColors.primaryColor,
          ),
          onPressed: () {
            Get.back();
          },
          child: const Text(
            "Cancel",
            style:
            TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildPopUp(String data, String name, [Color? textColor]) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: MyColors.white),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              data,
              style: TextStyle(color: textColor ?? MyColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
