import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';

Widget buildImageSlider(List<dynamic> sliderImagesList) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: SizedBox(
      height: 120,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Carousel(
          boxFit: BoxFit.cover,
          dotBgColor: Colors.transparent,
          dotColor: Colors.white,
          images: List.generate(
            growable: true,
            sliderImagesList.length,
            (index) => CachedNetworkImage(
              imageUrl: "${sliderImagesList[index]}",
              imageBuilder: (context, imageProvider) => Container(
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    ),
  );
}
