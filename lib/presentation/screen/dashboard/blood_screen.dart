import 'package:flutter/material.dart';
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
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            GetBuilder<BloodScreenController>(
              builder: (controller) => TextField(
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                onChanged: controller.search,
                controller: searchController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    hintText: "Search",
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 13),
                    suffixIcon: Icon(
                      Icons.search,
                      color: MyColors.white,
                    )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GetBuilder<BloodScreenController>(
              builder: (value) => Expanded(
                child: Visibility(
                  visible: value.searchList.isNotEmpty,
                  replacement: Lottie.asset(AssetPath.loadingJson),
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => ListTile(
                            onTap: () => Get.defaultDialog(
                                title: "Donors Details",
                                content: Column(
                                  children: [
                                    const CircleAvatar(
                                      child: Icon(Icons.person),
                                    ),
                                    Text(value.searchList[index].name ?? '',style: const TextStyle(fontWeight: FontWeight.w500),),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    _buildPopUp(value.searchList[index].lastDonateDate ?? '',"Last Donate Date:"),
                                    _buildPopUp(value.searchList[index].upazila ?? '',"Upazila:"),
                                    _buildPopUp(value.searchList[index].phone ?? '',"Phone:"),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.call),
                                    label: const Text("Call"),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ]),
                            leading: CircleAvatar(
                              child: Text(
                                  value.searchList[index].bloodGroup ?? ''),
                            ),
                            title: Text(value.searchList[index].name ?? ''),
                            subtitle:
                                Text(value.searchList[index].upazila ?? ''),
                            trailing: InkWell(
                                onTap: () => uriLaunchUrl(
                                    'tel:${value.searchList[index].phone}'),
                                child: const Icon(
                                  Icons.call,
                                  size: 35,
                                  color: Colors.green,
                                )),
                          ),
                      separatorBuilder: (context, index) => Divider(
                            color: MyColors.primaryColor,
                          ),
                      itemCount: value.searchList.length),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopUp(String data,String name) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Text(name,style: const TextStyle(fontWeight: FontWeight.w500),),
            const SizedBox(width: 5,),
            Text(data),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}
