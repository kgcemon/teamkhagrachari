import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import 'package:teamkhagrachari/presentation/widget/global/myappbar.dart';
import '../../controller/user_profile__seba_controller.dart';
import 'EditServiceScreen.dart';

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
      appBar: myAppbar(name: "User Services"),
      body: Obx(() {
        if (userProfileSebaController.filteredDetails.value.data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = userProfileSebaController.filteredDetails.value.data!;

        if (data.isEmpty) {
          return const Center(
            child: Text(
              'No data available.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          );
        }

        final totalViews = data
            .map((item) => int.tryParse(item.view ?? '0') ?? 0)
            .reduce((a, b) => a + b);

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimationLimiter(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatCard("Total Services", data.length.toString()),
                      _buildStatCard("Total Views", totalViews.toString()),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) =>
                        AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 700),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 8,
                            color: Colors.white.withOpacity(0.1),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: ExpansionTile(
                              backgroundColor: Colors.transparent,
                              collapsedBackgroundColor: Colors.transparent,
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${data[index].name} - ",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.lightGreenAccent),
                                    ),
                                  ],
                                  text: data[index].serviceProviderName ??
                                      'No name',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              subtitle: Text(
                                data[index].addressDegree ?? '',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 16,
                                ),
                              ),
                              trailing: FittedBox(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.amberAccent,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      data[index].view ?? "0",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    data[index].description ?? 'No description',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 14),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          onPressed: () {
                                            _showDeleteConfirmationDialog(
                                                context, data[index].sId);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            "Delete",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.teal,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 14),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          onPressed: () {
                                            // Navigate to the edit screen
                                            Get.to(
                                              () => EditServiceScreen(
                                                serviceId:
                                                    data[index].sId.toString(),
                                                initialServiceProviderName:
                                                    data[index]
                                                        .serviceProviderName
                                                        .toString(),
                                                initialAddressDegree:
                                                    data[index]
                                                        .location
                                                        .toString(),
                                                initialDescription: data[index]
                                                    .description
                                                    .toString(),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            "Edit",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
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
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String? serviceId) {
    Get.defaultDialog(
      title: "Delete Service",
      titleStyle: const TextStyle(
          color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 20),
      content: const Text(
        "Are you sure you want to delete this service? This action cannot be undone.",
        style: TextStyle(color: Colors.black, fontSize: 16),
        textAlign: TextAlign.center,
      ),
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.blueAccent, fontSize: 18),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () async {
            await NetworkCaller.deleteRequest(
              url: "https://api.khagrachariplus.com/api/v1/services/$serviceId",
            );
            Get.back();
            userProfileSebaController.getLoadUserSeba();
          },
          child: const Text(
            "Delete",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
