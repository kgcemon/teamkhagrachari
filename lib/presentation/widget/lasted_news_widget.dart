import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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
    return GetBuilder<HomeScreenController>(builder: (value) => value.newsList.isNotEmpty
        ? AspectRatio(
      aspectRatio: 3/1,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: value.newsList.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: AspectRatio(
                aspectRatio: 2/1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(value.newsList[index].thumbnail),fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(8),
                      color: Colors.white.withOpacity(0.1)),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      ModalBottomSheetRoute(
                          builder: (context) => NewsViewScreen(
                              newsViewList: value.newsList, index: index),
                          isScrollControlled: true),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8)),
                          color: Colors.black.withOpacity(0.5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          value.newsList[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 13,fontFamily: "banglafont"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
        : const LinearProgressIndicator(
      color: Colors.white,
    ),);
  }
}
