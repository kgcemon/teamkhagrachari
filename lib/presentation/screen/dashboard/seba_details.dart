import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:teamkhagrachari/presentation/controller/seba_details_screen_controller.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'package:teamkhagrachari/presentation/widget/global/myappbar.dart';
import 'package:teamkhagrachari/presentation/widget/seba_call_list_widget.dart';

class SebaDetails extends StatefulWidget {
  String sebaID;

  SebaDetails({super.key, required this.sebaID});

  @override
  State<SebaDetails> createState() => _SebaDetailsState();
}

class _SebaDetailsState extends State<SebaDetails> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Get.put(SebaDetailsScreenController()).fetchSebaDetails(widget.sebaID);
  }

  final SebaDetailsScreenController _sebaDetailsScreenController =
      Get.find<SebaDetailsScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white),
              onChanged: _sebaDetailsScreenController.search,
              controller: searchController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: "Search",
                  hintStyle: const TextStyle(color: Colors.white, fontSize: 13),
                  suffixIcon: Icon(
                    Icons.search,
                    color: MyColors.white,
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            buildSebaCallList(_sebaDetailsScreenController.searchList, context),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }
}
