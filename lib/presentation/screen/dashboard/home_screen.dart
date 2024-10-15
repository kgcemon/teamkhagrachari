import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';
import 'package:lottie/lottie.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import 'package:teamkhagrachari/data/urls..dart';
import 'package:teamkhagrachari/presentation/screen/buy_sell_screen.dart';
import 'package:teamkhagrachari/presentation/controller/home_screen_controller.dart';
import 'package:teamkhagrachari/presentation/screen/dashboard/blood_screen.dart';
import 'package:teamkhagrachari/presentation/utils/assets_path.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'package:teamkhagrachari/presentation/widget/home/seba_catagory_card.dart';
import 'package:teamkhagrachari/presentation/widget/lasted_news_widget.dart';
import 'package:teamkhagrachari/presentation/widget/update_marquee.dart';
import '../../../local_notification_service.dart';
import '../../../main.dart';
import '../../../push_notification.dart';

int popupCount = 0;
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  String importantServiceQuery = '';

  loadPopUp() async {
    if(popupCount == 0){
      var response = await NetworkCaller.getRequest(url: ApiUrl.popUpUrls);
      if (response.responseCode == 200 &&
          response.responseData['success'] == true) {
        popupCount = 1;
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            backgroundColor: Colors.transparent,
            //title: Text(""),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      color: Colors.red,
                      icon: const Icon(Icons.cancel),
                      onPressed: () => Get.back(),
                    )
                  ],
                ),
                Image.network(response.responseData['data'][0]['notice']),
              ],
            ),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadPopUp();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LocalNotificationService.initialize(context);
    });
    PushNotifications.init();
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        LocalNotificationService.display(message);
      }
    });
  }

  List dedicatedServicesList = [
    {"name": "রক্তদাতা", "image": AssetPath.bloodPNG},
    {"name": "ক্রয়-বিক্রয়", "image": AssetPath.buySellPng},
    {"name": "শাদী মোবারক", "image": AssetPath.weddingPng},
    {"name": "ডাক্তারের সাক্ষাৎ", "image": AssetPath.weddingPng},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: GetBuilder<HomeScreenController>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UpdateNewsMarquee(),
              ImageSliderWidget(sliderImagesList: controller.sliderImageList),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "Latest News",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const LastedNewsWidget(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text(
                  "Dedicated Services",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _dedicatedServices(),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7.0, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.13),
                  ),
                  child: TextField(
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: "Search Important Services",
                      hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        color: MyColors.white,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        importantServiceQuery = value.toLowerCase();
                      });
                    },
                  ),
                ),
              ),
              SebaCatagoryCard(
                sebaList: controller.category.where((item) {
                  final name = item.name.toString().toLowerCase();
                  return name.contains(importantServiceQuery);
                }).toList(),
                sebaName: 'Important Services',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dedicatedServices() {
    // Filter services based on the search query
    List filteredServices = dedicatedServicesList
        .where((service) =>
            service["name"].toString().toLowerCase().contains(searchQuery))
        .toList();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < filteredServices.length; i++)
          GestureDetector(
            onTap: () {
              if (i == 0) {
                Get.to(() => const BloodScreen());
              } else if (i == 1) {
                Get.to(() => const BuySellScreen());
              } else {
                Get.defaultDialog(
                  backgroundColor: Colors.white,
                  title: filteredServices[i]['name'],
                  content: Lottie.asset("Assets/images/coming.json"),
                );
              }
            },
            child: _dedicatedServicesCard(filteredServices, i),
          ),
      ],
    );
  }

  Widget _dedicatedServicesCard(List services, int i) {
    return AnimationLimiter(
      child: AnimationConfiguration.staggeredList(
        position: i,
        duration: const Duration(milliseconds: 500),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 5),
              child: Container(
                width: 100,
                height: 80,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      services[i]['image'],
                      height: 30,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, size: 30);
                      },
                    ),
                    const SizedBox(height: 5),
                    FittedBox(
                      child: Text(
                        services[i]['name'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: "banglafont",
                        ),
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
}

class ImageSliderWidget extends StatelessWidget {
  const ImageSliderWidget({super.key, required this.sliderImagesList});

  final List<String> sliderImagesList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        height: 140,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: sliderImagesList.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Carousel(
                  dotSize: 5,
                  dotSpacing: 15,
                  dotPosition:
                      DotPosition.values[DotPosition.bottomCenter.index],
                  boxFit: BoxFit.cover,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.white,
                  dotVerticalPadding: -15,
                  images: sliderImagesList
                      .map(
                        (url) => ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: url,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CupertinoActivityIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
      ),
    );
  }
}
