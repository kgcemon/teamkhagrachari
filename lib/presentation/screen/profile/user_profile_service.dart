import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import 'package:teamkhagrachari/presentation/widget/global/myappbar.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../controller/user_profile__seba_controller.dart';
import 'package:http/http.dart' as http;

class UserProfileServiceScreen extends StatefulWidget {
  const UserProfileServiceScreen({super.key});

  @override
  State<UserProfileServiceScreen> createState() =>
      _UserProfileServiceScreenState();
}

class _UserProfileServiceScreenState extends State<UserProfileServiceScreen> {
  UserProfileSebaController userProfileSebaController =
  Get.find<UserProfileSebaController>();

  @override
  void initState() {
    super.initState();
    userProfileSebaController.getLoadUserSeba();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(name: ""),
      body: Obx(() {
        if (userProfileSebaController.filteredDetails.value.data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = userProfileSebaController.filteredDetails.value.data!;

        if (data.isEmpty) {
          return const Center(child: Text('No data available.',style: TextStyle(color: Colors.white),));
        }

        final totalViews = data.map((item) => int.tryParse(item.view ?? '0') ?? 0).reduce((a, b) => a + b);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimationLimiter(
            child: Column(
              children: [
                Container(
                  decoration:
                  BoxDecoration(color: Colors.white.withOpacity(0.13)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text("Total Service",
                              style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 10),
                          Text(
                            data.length.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Total View",
                              style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 10),
                          Text(
                            totalViews.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.13),
                  ),
                  height: data.length >= 2 ? 180 : 0,
                  child: data.isNotEmpty
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: data.length >= 2
                        ? LineChart(
                      LineChartData(
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: data.asMap().entries.map((entry) {
                              int index = entry.key;
                              var item = entry.value;
                              return FlSpot(
                                index.toDouble(),
                                double.tryParse(item.view ?? '0') ??
                                    0,
                              );
                            }).toList(),
                            isCurved: true,
                            colors: [Colors.white],
                            barWidth: 4,
                            belowBarData: BarAreaData(show: false),
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, bar, index) {
                                return FlDotCirclePainter(
                                  radius: 3,
                                  color: Colors.white,
                                  strokeWidth: 0,
                                );
                              },
                            ),
                          ),
                        ],
                        titlesData: FlTitlesData(
                          topTitles: SideTitles(
                            showTitles: false,
                            getTextStyles: (context, value) {
                              return const TextStyle(
                                  color: Colors.white);
                            },
                          ),
                          rightTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) {
                              return const TextStyle(
                                  color: Colors.white);
                            },
                          ),
                          bottomTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) {
                              return const TextStyle(
                                  color: Colors.white);
                            },
                          ),
                          leftTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) {
                              return const TextStyle(
                                  color: Colors.white);
                            },
                          ),
                        ),
                      ),
                    )
                        : const SizedBox(),
                  )
                      : const CircularProgressIndicator(),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) =>
                        AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 900),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 0),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.13),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ExpansionTile(
                                  backgroundColor: Colors.white.withOpacity(0.13),
                                  title: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: " ${data[index].name}",
                                          style: const TextStyle(
                                              fontSize: 10, color: Colors.green),
                                        ),
                                      ],
                                      text: data[index].serviceProviderName ??
                                          'No name',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  subtitle: Text(
                                    data[index].addressDegree ?? '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12,
                                    ),
                                  ),
                                  trailing: FittedBox(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          data[index].view ?? "0",
                                          style: const TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        data[index].description ?? 'No description',
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton.icon(
                                              style: IconButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              onPressed: () {
                                                Get.defaultDialog(
                                                    title: "Are You Sure?",
                                                    content: const Text(
                                                        "Are you sure delete this service?"),
                                                    actions: [
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor: Colors.red,
                                                        ),
                                                        onPressed: () async {
                                                          await NetworkCaller
                                                              .deleteRequest(
                                                              url:
                                                              "https://api.khagrachariplus.com/api/v1/services/${data[index].sId}");
                                                          Get.back();
                                                          userProfileSebaController
                                                              .getLoadUserSeba();
                                                        },
                                                        child:
                                                        const Text("Delete"),
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor: Colors.white
                                                              .withOpacity(0.13),
                                                        ),
                                                        onPressed: () =>
                                                            Get.back(),
                                                        child: const Text("No"),
                                                      ),
                                                    ]);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                              label: const Text(
                                                "Delete",
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
