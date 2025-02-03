import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import 'package:teamkhagrachari/data/urls..dart';
import 'package:teamkhagrachari/presentation/controller/buy_sell_screen_controller.dart';
import 'package:teamkhagrachari/presentation/screen/buy_sell_screen.dart';
import 'package:teamkhagrachari/presentation/controller/home_screen_controller.dart';
import 'package:teamkhagrachari/presentation/utils/assets_path.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'package:teamkhagrachari/presentation/widget/home/seba_catagory_card.dart';
import 'package:teamkhagrachari/presentation/widget/lasted_news_widget.dart';
import '../../../local_notification_service.dart';
import '../../../main.dart';
import '../../../push_notification.dart';
import '../../controller/blood_screen_controller.dart';
import '../../controller/main_bottom_nav_bar_controller.dart';
import '../bijoy_result.dart';
import 'package:http/http.dart' as http;
import '../product_view_screen.dart';

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
  String totalView = "0";

  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-2912066127127483/5260391533',
      // Your Interstitial Ad Unit ID
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Failed to load an interstitial ad: ${error.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_isInterstitialAdReady) {
      _interstitialAd?.show();
    }
  }

  loadPopUp() async {
    if (popupCount == 0) {
      var response = await NetworkCaller.getRequest(url: ApiUrl.popUpUrls);
      if (response.responseCode == 200 &&
          response.responseData['success'] == true) {
        popupCount = 1;
        bool show =
            response.responseData['data'][0]['notice'].toString() != 'no';
        return show
            ? showDialog(
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
              )
            : null;
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
    _loadInterstitialAd();
  }


  List dedicatedServicesList = [
    {"name": "রক্তদাতা", "image": AssetPath.bloodPNG},
    {"name": "ক্রয়-বিক্রয়", "image": AssetPath.buySellPng},
    {"name": "শাদী মোবারক", "image": AssetPath.weddingPng},
    {"name": "ডাক্তারের সাক্ষাৎ", "image": AssetPath.weddingPng},
  ];

  final BuySellScreenController _buySellController =
      Get.put(BuySellScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: GetBuilder<HomeScreenController>(
        builder: (controller) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageSliderWidget(sliderImagesList: controller.sliderImageList),
                const SizedBox(height: 10),
                const Text(
                  "সর্বশেষ সংবাদ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const LastedNewsWidget(),
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      Get.to(() => DataScreen());
                    },
                    child: GestureDetector(
                      onTap: () {
                        //Get.to(()=>const VotingScreen());
                        _showInterstitialAd();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(22),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          color: Colors.white.withOpacity(0.1),
                          // Transparent background
                          borderRadius: BorderRadius.circular(10),
                          //border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                        ),
                        child: const Text(
                          "খাগড়াছড়ি প্লাস মেগা কন্টেস্ট",
                          style: TextStyle(
                            fontSize: 20,
                            // Bigger font size for clear visibility
                            color: Colors.blueAccent,
                            // Eye-catching color
                            fontWeight: FontWeight
                                .bold, // Bold text to make it prominent
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "ক্রয়-বিক্রয়",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0)),
                        onPressed: () {
                          Get.to(() => const BuySellScreen());
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "See All",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                            Icon(
                              Icons.arrow_right,
                              size: 30,
                              color: Colors.blueAccent,
                            )
                          ],
                        ))
                  ],
                ),
                Obx(
                  () => _buySellController.categoryList.value.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : GetBuilder<BuySellScreenController>(builder: (controller) => GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    shrinkWrap: true,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        mainAxisExtent: 100),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Get.to(() => ProductViewScreen(
                        categoryId:
                        _buySellController.categoryList[index].id,
                        title:
                        _buySellController.categoryList[index].name,
                      )),
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        color: Colors.transparent,
                        elevation: 20,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(5)),
                          child: FittedBox(
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  width: 50,
                                  imageUrl: imgUrlMaker(_buySellController
                                      .categoryList[index].icon ??
                                      ""),
                                  placeholder: (context, url) =>
                                  const CupertinoActivityIndicator(),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  child: Text(
                                    _buySellController
                                        .categoryList[index].name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),),
                ),
                SebaCatagoryCard(
                  sebaList: controller.category.where((item) {
                    final name = item.name.toString().toLowerCase();
                    return name.contains(importantServiceQuery);
                  }).toList(),
                  sebaName: 'গুরুত্বপূর্ণ সেবা',
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "রক্তদাতা",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0)),
                        onPressed: () {
                          Get.to(() => const BuySellScreen());
                        },
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell( onTap: () {
                              _showInterstitialAd();
                              Get.find<NavButtonControllerController>().changeIndex(1);
                            },
                              child: const Text(
                                "See All",
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                            ),
                            const Icon(
                              Icons.arrow_right,
                              size: 30,
                              color: Colors.blueAccent,
                            )
                          ],
                        ))
                  ],
                ),
                GetBuilder<BloodScreenController>(
                  builder: (controller) => controller.bloodDetailsList.isEmpty
                      ? const CircularProgressIndicator()
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 6,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 3,
                                  mainAxisExtent: 100),
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () => Get.find<NavButtonControllerController>().changeIndex(1),
                            child: Card(
                              margin: const EdgeInsets.all(0),
                              color: Colors.transparent,
                              elevation: 20,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(controller
                                          .bloodDetailsList[index].image
                                          .toString()),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3.0),
                                      child: Text(
                                        controller.bloodDetailsList[index].name
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String imgUrlMaker(String urls) {
  if (urls.contains("http")) {
    var mm = urls.split("http")[1];
    return "https$mm";
  } else {
    return urls;
  }
}

class ImageSliderWidget extends StatelessWidget {
  const ImageSliderWidget({super.key, required this.sliderImagesList});

  final List<String> sliderImagesList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: sliderImagesList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Carousel(
                dotSize: 5,
                dotSpacing: 15,
                dotPosition: DotPosition.values[DotPosition.bottomCenter.index],
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
    );
  }
}
