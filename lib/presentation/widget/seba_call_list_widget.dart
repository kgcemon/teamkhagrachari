import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:teamkhagrachari/data/model/seba_details_model.dart';
import '../../data/urls..dart';
import '../utils/uri_luncher.dart';
import 'package:http/http.dart' as http;

class SebaCallList extends StatefulWidget {
  final List<SebaDetailsDataListModel> sebaDetailsList;

  const SebaCallList({super.key, required this.sebaDetailsList});

  @override
  SebaCallListState createState() => SebaCallListState();
}

class SebaCallListState extends State<SebaCallList> {
  Set<String> expandedIds = {};

  @override
  Widget build(BuildContext context) {
    if (widget.sebaDetailsList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    
    List<SebaDetailsDataListModel> sortedList = widget.sebaDetailsList
        .toList()
      ..sort((a, b) {
        int viewA = int.tryParse(a.view ?? '0') ?? 0;
        int viewB = int.tryParse(b.view ?? '0') ?? 0;
        return viewB.compareTo(viewA);
      });

    return AnimationLimiter(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: sortedList.length,
        itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
          position: index,
          duration: const Duration(milliseconds: 900),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                decoration: BoxDecoration(
                  border: Border.all(width: 3 ,color: index == 0 ? Colors.blue : Colors.transparent),
                  color: index == 0 ? Colors.yellow.shade200 :  Colors.white.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpansionTile(
                  //leading: Image.network(sortedList[index].sId.toString()),
                  onExpansionChanged: (value) {
                    if (value && !expandedIds.contains(sortedList[index].sId.toString())) {
                      expandedIds.add(sortedList[index].sId.toString());
                      _countAdd(sortedList[index].sId.toString());
                    }
                  },
                  backgroundColor: Colors.white.withOpacity(0.13),
                  title: RichText(
                    text: TextSpan(
                      text: sortedList[index].serviceProviderName ?? 'No name',
                      style:  TextStyle(
                        color: index == 0 ? Colors.black : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  subtitle: Wrap(
                    children: [
                      Text(
                        sortedList[index].addressDegree ?? '',
                        style: TextStyle(
                          color: index == 0 ? Colors.black :  Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: index == 0 ? Colors.green :  Colors.white.withOpacity(0.5),
                            size: 16,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${sortedList[index].view}",
                            style: TextStyle(
                                color: index == 0 ? Colors.green : Colors.white.withOpacity(0.5), fontSize: 11),
                          ),
                          Text(
                            "   ${sortedList[index].location}",
                            style: const TextStyle(color: Colors.green, fontSize: 12),
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
                            uriLaunchUrl('tel:${sortedList[index].phone}');
                          },
                          child: const Text(
                            "কল করুন",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                    child: Lottie.asset("Assets/images/call.json"),
                  ),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.topLeft,
                      child: HtmlWidget(
                        textStyle: TextStyle(color:  index == 0 ? Colors.black : Colors.white),
                        sortedList[index].description ?? 'No description',
                        // style:  TextStyle(color: index == 0 ? Colors.black : Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _countAdd(String id) async {
    await http.patch(Uri.parse("${ApiUrl.viewCountUrl}/$id"));
  }
}
