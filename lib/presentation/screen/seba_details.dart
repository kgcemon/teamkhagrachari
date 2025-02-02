import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:teamkhagrachari/presentation/controller/seba_details_screen_controller.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'package:teamkhagrachari/presentation/widget/global/myappbar.dart';
import 'package:teamkhagrachari/presentation/widget/seba_call_list_widget.dart';

import '../add_user_service_screen.dart';

class SebaDetails extends StatefulWidget {
  final String sebaID;
  final String sebaname;

  const SebaDetails({Key? key, required this.sebaID, required this.sebaname})
      : super(key: key);

  @override
  State<SebaDetails> createState() => _SebaDetailsState();
}

class _SebaDetailsState extends State<SebaDetails> {
  final TextEditingController searchController = TextEditingController();
  final SebaDetailsScreenController sebaDetailsController =
      Get.put(SebaDetailsScreenController());
  String selectedUpazila = 'উপজেলা';

  @override
  void initState() {
    super.initState();
    sebaDetailsController.fetchSebaDetails(widget.sebaID);
    searchController.addListener(() {
      sebaDetailsController.filterDetails(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double padding = MediaQuery.of(context).size.width * 0.04;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const AddUserServiceScreen());
        },
        label: const Text(
          "সেবা যোগ করুন",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        icon: const Icon(Icons.add, size: 20),
        backgroundColor: Colors.teal,
        // You can change this to any color you like
        splashColor: Colors.tealAccent, // The splash effect color when tapped
      ),
      appBar: myAppbar(name: widget.sebaname),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.13)),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: TextField(
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        controller: searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText: "Search",
                          hintStyle: const TextStyle(
                              color: Colors.white54, fontSize: 13),
                          suffixIcon: Icon(
                            Icons.search,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.13),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      icon: const Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      value: selectedUpazila,
                      onChanged: (value) {
                        selectedUpazila = value!;
                        print(selectedUpazila);
                        sebaDetailsController.filterDetails(selectedUpazila);
                        setState(() {});
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
                )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (sebaDetailsController.progress.value == true) {
                  return const Center(child: CircularProgressIndicator());
                } else if (sebaDetailsController.filteredDetails.isEmpty) {
                  return  Center(
                    child: Column(
                      children: [
                        Lottie.asset("Assets/images/loading.json"),
                        const Text(
                          'No data available',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SebaCallList(sebaDetailsList:sebaDetailsController.filteredDetails,);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
