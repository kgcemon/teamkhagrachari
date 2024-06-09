import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/controller/home_screen_controller.dart';
import 'package:teamkhagrachari/presentation/screen/news_view_screen.dart';

class LastedNewsWidget extends StatelessWidget {
  const LastedNewsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GetBuilder<HomeScreenController>(builder: (value) => value.newsList.isNotEmpty
            ? SizedBox(
          height: 130,
          width: double.maxFinite,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: value.newsList.length,
            itemBuilder: (context, index) => SizedBox(
              width: 160,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    ModalBottomSheetRoute(
                        builder: (context) => NewsViewScreen(
                            newsViewList: value.newsList, index: index),
                        isScrollControlled: true),
                  ),
                  child: Column(
                    children: [
                      Image.network(
                        value.newsList[index].thumbnail,
                        fit: BoxFit.fitWidth,
                        height: 80,
                        width: double.infinity,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        value.newsList[index].title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 11),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
            : const LinearProgressIndicator(
          color: Colors.white,
        ),)
    );
  }
}
