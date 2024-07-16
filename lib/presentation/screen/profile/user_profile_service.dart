import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/widget/global/myappbar.dart';
import '../../controller/user_profile__seba_controller.dart';
import '../../utils/uri_luncher.dart';

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
      body: Obx(() => userProfileSebaController.filteredDetails.value.data == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimationLimiter(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: userProfileSebaController
                      .filteredDetails.value.data!.length,
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
                                    text: userProfileSebaController
                                        .filteredDetails
                                        .value
                                        .data![index]
                                        .name,
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.green),
                                  )
                                ],
                                text: userProfileSebaController
                                        .filteredDetails
                                        .value
                                        .data![index]
                                        .serviceProviderName ??
                                    'No name',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              userProfileSebaController.filteredDetails.value
                                      .data![index].addressDegree ??
                                  '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontSize: 12,
                              ),
                            ),
                            // trailing: const Icon(
                            //   Icons.delete,
                            //   size: 35,
                            //   color: Colors.red,
                            // ),
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  userProfileSebaController.filteredDetails
                                          .value.data![index].description ??
                                      'No description',
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
            )),
    );
  }
}
