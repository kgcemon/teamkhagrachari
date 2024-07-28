import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:teamkhagrachari/data/model/seba_details_model.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import '../../data/urls..dart';
import '../utils/uri_luncher.dart';

Widget buildSebaCallList(
    List<SebaDetailsDataListModel> sebaDetailsList, BuildContext context) {
  if (sebaDetailsList.isEmpty) {
    return const Center(child: CircularProgressIndicator());
  }

  return AnimationLimiter(
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: sebaDetailsList.length,
      itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
        position: index,
        duration: const Duration(milliseconds: 900),
        child: InkWell(
            onTap: () async {
              var res = await NetworkCaller.patchRequest(
                  url:
                  "${ApiUrl.viewCountUrl}/${sebaDetailsList[index].sId}");
              print(res.responseData);
            },
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpansionTile(
                  backgroundColor: Colors.white.withOpacity(0.13),
                  title: RichText(
                    text: TextSpan(
                      // children: [
                      //   TextSpan(
                      //     text: " ${sebaDetailsList[index].location}",
                      //     style:
                      //         const TextStyle(fontSize: 10, color: Colors.green),
                      //   )
                      // ],
                      text:
                          sebaDetailsList[index].serviceProviderName ?? 'No name',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Wrap(
                    children: [
                      Text(
                        sebaDetailsList[index].addressDegree ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.remove_red_eye,
                            color: Colors.green,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            " ${sebaDetailsList[index].view}",
                            style: const TextStyle(
                                color: Colors.green, fontSize: 11),
                          ),
                          Text(
                            "   ${sebaDetailsList[index].location}",
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: InkWell(
                    onTap: () {
                      Get.defaultDialog(
                        backgroundColor: Colors.grey[850],
                        titleStyle: const TextStyle(color: Colors.white),
                        title: "নোটিশ",
                        content: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "সেবাদাতাকে সালাম দিয়ে শুরুতেই বলুন, আমি Khagrachari Plus থেকে আপনার ফোন নাম্বার পেয়েছি। আমার সেবা প্রয়োজন।",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        confirm: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                          onPressed: () {
                            uriLaunchUrl('tel:${sebaDetailsList[index].phone}');
                          },
                          child: const Text(
                            "কল করুন",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.call,
                      size: 35,
                      color: Colors.green,
                    ),
                  ),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        sebaDetailsList[index].description ?? 'No description',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
