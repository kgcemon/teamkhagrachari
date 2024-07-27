import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/controller/seba_details_screen_controller.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'package:teamkhagrachari/presentation/widget/global/myappbar.dart';
import 'package:teamkhagrachari/presentation/widget/seba_call_list_widget.dart';

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
                      padding: const EdgeInsets.all(5.0),
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
                          hintStyle:
                              const TextStyle(color: Colors.white, fontSize: 13),
                          suffixIcon: Icon(
                            Icons.search,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10,),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.13),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      icon: const Icon(Icons.location_on,color: Colors.white,),
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
                  return const Center(
                      child: Text('No data available',
                          style: TextStyle(color: Colors.white)));
                } else {
                  return buildSebaCallList(
                      sebaDetailsController.filteredDetails, context);
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
