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
            Container(
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
