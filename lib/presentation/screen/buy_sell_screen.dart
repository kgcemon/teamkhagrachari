import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/controller/buy_sell_screen_controller.dart';
import 'package:teamkhagrachari/presentation/screen/add_product_screen.dart';
import 'package:teamkhagrachari/presentation/screen/product_view_screen.dart';
import 'package:teamkhagrachari/presentation/widget/global/myappbar.dart';

class BuySellScreen extends StatefulWidget {
  const BuySellScreen({super.key});

  @override
  State<BuySellScreen> createState() => _BuySellScreenState();
}

class _BuySellScreenState extends State<BuySellScreen> {
  // Initialize the controller
  final BuySellScreenController controller = Get.put(BuySellScreenController());

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const AddProductScreen());
        },
        label: const Text(
          "বিজ্ঞাপন যোগ করুন",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        icon: const Icon(Icons.add, size: 20),
        backgroundColor: Colors.teal,
        // You can change this to any color you like
        splashColor: Colors.tealAccent, // The splash effect color when tapped
      ),
      appBar: myAppbar(name: "ক্রয়-বিক্রয়"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Image.network(
                "https://khagrachariplus.com/wp-content/uploads/2024/07/Add-KP-scaled.jpg"),
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: LinearProgressIndicator(color: Colors.white,backgroundColor: Colors.green,));
              }

              if (controller.categoryList.isEmpty) {
                return const Center(
                    child: Text('No categories found',
                        style: TextStyle(color: Colors.white)));
              }

              return Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: controller.categoryList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      crossAxisCount: getCrossAxisCount(context),
                      mainAxisExtent: 75),
                  itemBuilder: (context, index) =>
                      AnimationConfiguration.staggeredGrid(
                    position: index,
                    columnCount: 3,
                    duration: const Duration(milliseconds: 900),
                    child: FlipAnimation(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => ProductViewScreen(
                                categoryId: controller.categoryList[index].id,
                                title: controller.categoryList[index].name,
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  CachedNetworkImage(
                                    width: 50,
                                    imageUrl: imgUrlMaker(
                                        controller.categoryList[index].icon ??
                                            ""),
                                    // Fetch the image URL
                                    placeholder: (context, url) =>
                                        const CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    controller.categoryList[index].name,
                                    // Fetch the category name
                                    style: const TextStyle(
                                        fontSize: 13, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  String imgUrlMaker(String urls) {
    if (urls.contains("http")) {
      var mm = urls.split("http")[1];
      return "https$mm";
    } else {
      return urls;
    }
  }

  int getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 120).floor();
    return crossAxisCount > 3 ? 3 : crossAxisCount;
  }
}
