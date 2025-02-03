import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/screen/seba_details.dart';
import '../controller/home_screen_controller.dart';
import '../widget/global/myappbar.dart';

class ImportantServices extends StatelessWidget {
  const ImportantServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(name: 'গুরুত্বপূর্ণ সেবা'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GetBuilder<HomeScreenController>(
          builder: (controller) => GridView.builder(
            itemCount: controller.category.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                mainAxisExtent: 100),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SebaDetails(
                    sebaname: controller.category[index].name,
                    sebaID: controller.category[index].id,
                  ),
                ),
              ),
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
                          imageUrl: controller.category[index].img.toString(),
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
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Text(
                            controller.category[index].name,
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
          ),
        ),
      ),
    );
  }
}
