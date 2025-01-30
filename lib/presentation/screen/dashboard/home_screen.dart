import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';
import 'package:lottie/lottie.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import 'package:teamkhagrachari/data/urls..dart';
import 'package:teamkhagrachari/presentation/screen/buy_sell_screen.dart';
import 'package:teamkhagrachari/presentation/controller/home_screen_controller.dart';
import 'package:teamkhagrachari/presentation/screen/dashboard/blood_screen.dart';
import 'package:teamkhagrachari/presentation/screen/voting_screen.dart';
import 'package:teamkhagrachari/presentation/utils/assets_path.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'package:teamkhagrachari/presentation/widget/home/seba_catagory_card.dart';
import 'package:teamkhagrachari/presentation/widget/lasted_news_widget.dart';
import '../../../local_notification_service.dart';
import '../../../main.dart';
import '../../../push_notification.dart';
import '../bijoy_result.dart';
import 'package:http/http.dart' as http;

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
      adUnitId: 'ca-app-pub-2912066127127483/5260391533', // Your Interstitial Ad Unit ID
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
    loadViews();
    _loadInterstitialAd();
  }

  loadViews() async {
    var data = await http
        .get(Uri.parse("https://lottery.khagrachariplus.com/api/showView"));
    List<dynamic> result = jsonDecode(data.body);
    totalView = result[0]['count'].toString();
    setState(() {});
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageSliderWidget(sliderImagesList: controller.sliderImageList),
                const SizedBox(height: 10),
                const Text(
                  "Latest News",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const LastedNewsWidget(),
                const SizedBox(height: 10),
                const Text(
                  "Running Events",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      Get.to(() => DataScreen());
                    },
                    child: GestureDetector(
                      onTap: () {
                        Get.to(()=>const VotingScreen());
                        _showInterstitialAd();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(22),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          color: Colors.white.withOpacity(0.1), // Transparent background
                          borderRadius: BorderRadius.circular(10),
                          //border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                        ),
                        child: const Text(
                          "খাগড়াছড়ি প্লাস মেগা কন্টেস্ট",
                          style: TextStyle(
                            fontSize: 16, // Bigger font size for clear visibility
                            color: Colors.orangeAccent, // Eye-catching color
                            fontFamily: "banglafont",
                            fontWeight: FontWeight.bold, // Bold text to make it prominent
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Dedicated Services",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _dedicatedServices(),
                ),
                // const SizedBox(height: 10),
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: Colors.white.withOpacity(0.13),
                //   ),
                //   child: TextField(
                //     cursorColor: Colors.white,
                //     style: const TextStyle(color: Colors.white),
                //     decoration: InputDecoration(
                //       border: InputBorder.none,
                //       enabledBorder: InputBorder.none,
                //       focusedBorder: InputBorder.none,
                //       filled: true,
                //       fillColor: Colors.transparent,
                //       hintText: "Search Important Services",
                //       hintStyle: const TextStyle(
                //         color: Colors.white,
                //         fontSize: 12,
                //       ),
                //       suffixIcon: Icon(
                //         Icons.search,
                //         color: MyColors.white,
                //       ),
                //     ),
                //     onChanged: (value) {
                //       setState(() {
                //         importantServiceQuery = value.toLowerCase();
                //       });
                //     },
                //   ),
                // ),
                const SizedBox(height: 10),
                SebaCatagoryCard(
                  sebaList: controller.category.where((item) {
                    final name = item.name.toString().toLowerCase();
                    return name.contains(importantServiceQuery);
                  }).toList(),
                  sebaName: 'Important Services',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Image.network(
                      "https://khagrachariplus.com/wp-content/uploads/2024/10/Khagrahcari-Plus-ad.gif"),
                ),
                const SizedBox(
                  height: 70,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dedicatedServices() {
    List filteredServices = dedicatedServicesList
        .where((service) =>
            service["name"].toString().toLowerCase().contains(searchQuery))
        .toList();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
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
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: _dedicatedServicesCard(filteredServices, i),
            ),
          ),
      ],
    );
  }

  Widget _dedicatedServicesCard(List services, int i) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: -0,
          child: services[i]['name'] == "রক্তদাতা" ||
                  services[i]['name'] == "ক্রয়-বিক্রয়"
              ? Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColors.white.withOpacity(0.35), // Gold-like color
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 10,
                  ),
                )
              : const Text(""),
        ),
        Container(
          width: 110,
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
      ],
    );
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
