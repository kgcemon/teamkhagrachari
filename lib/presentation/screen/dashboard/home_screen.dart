import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/controller/home_screen_controller.dart';
import 'package:teamkhagrachari/presentation/utils/assets_path.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'package:teamkhagrachari/presentation/widget/global/image_slider_widget.dart';
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
  ];

  @override
  Widget build(BuildContext context) {
    List sliderImagesList = [
      'https://steemitimages.com/DQmTUGF69AFBVJavNkHeNwJnGqN3EELrgK3UyhZbGUHFj7X/khagrachari.jpg',
      'https://steemitimages.com/DQmbuVssn3vdVJvvnhNjEBSc9k3bQMqgsvx2yvRj3cBAgDx/khagrachari3.jpg',
    ];
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      body: GetBuilder<HomeScreenController>(builder: (controller) => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UpdateNewsMarquee(),
            buildImageSlider(sliderImagesList),
            const SizedBox(
                height: 15
            ),
            const SizedBox(
              height: 10,
            ),
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
      ),),
    );
  }

  Row _dedicatedServices() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < dedicatedServicesList.length && i < 3; i++)
          GestureDetector(
            onTap: () {

            },
              child: _dedicatedServicesCard(i)),
      ],
    );
  }

  Padding _dedicatedServicesCard(int i) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 5),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                dedicatedServicesList[i]['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, size: 30);
                },
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            dedicatedServicesList[i]['name'],
            style: const TextStyle(fontSize: 9, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
