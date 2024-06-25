import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';
import 'package:lottie/lottie.dart';
import 'package:teamkhagrachari/presentation/controller/home_screen_controller.dart';
import 'package:teamkhagrachari/presentation/screen/dashboard/blood_screen.dart';
import 'package:teamkhagrachari/presentation/utils/assets_path.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'package:teamkhagrachari/presentation/widget/home/seba_catagory_card.dart';
import 'package:teamkhagrachari/presentation/widget/lasted_news_widget.dart';
import 'package:teamkhagrachari/presentation/widget/update_marquee.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List dedicatedServicesList = [
    {"name": "রক্তদাতা", "image": AssetPath.bloodPNG},
    {"name": "ক্রয়-বিক্রয়", "image": AssetPath.buySellPng},
    {"name": "শাদী মোবারক", "image": AssetPath.weddingPng},
    {"name": "বই বিনিময়", "image": AssetPath.weddingPng},
    {"name": "চাকরি", "image": AssetPath.weddingPng},
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
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  "Latest News",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const LastedNewsWidget(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text(
                  "Dedicated Services",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _dedicatedServices(),
              ),
              const SizedBox(
                height: 10,
              ),
              SebaCatagoryCard(
                sebaList: controller.category,
                sebaName: 'Important Services',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dedicatedServices() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < dedicatedServicesList.length; i++)
          GestureDetector(
              onTap: () {
                if (i == 0) {
                  Get.to(() => const BloodScreen());
                } else {
                  Get.defaultDialog(
                      backgroundColor: Colors.white,
                      title: dedicatedServicesList[i]['name'],
                      content: Lottie.asset("Assets/images/coming.json"));
                }
              },
              child: _dedicatedServicesCard(i)),
      ],
    );
  }

  Widget _dedicatedServicesCard(int i) {
    return AnimationLimiter(
      child: AnimationConfiguration.staggeredList(
        position: i,
        duration: const Duration(milliseconds: 1300),
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
                      dedicatedServicesList[i]['image'],
                      height: 30,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, size: 30);
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      dedicatedServicesList[i]['name'],
                      style: const TextStyle(fontSize: 12, color: Colors.white),
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
                  boxFit: BoxFit.cover,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.white,
                  images: sliderImagesList
                      .map(
                        (url) => ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: url,
                            placeholder: (context, url) =>
                                const CupertinoActivityIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            fit: BoxFit.cover,
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
