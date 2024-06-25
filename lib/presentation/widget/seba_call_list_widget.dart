import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:teamkhagrachari/data/model/seba_details_model.dart';

import '../utils/uri_luncher.dart';

Widget buildSebaCallList(
    List<SebaDetailsDataListModel> sebaDetailsList, BuildContext context) {
  if (sebaDetailsList.isEmpty) {
    return const Center(child: CircularProgressIndicator());
  }

  return AnimationLimiter(
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: sebaDetailsList.length,
      itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
        position: index,
        duration: const Duration(milliseconds: 900),
        child: SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.13),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ExpansionTile(
                backgroundColor:  Colors.white.withOpacity(0.13),
                title: Text(
                  sebaDetailsList[index].serviceProviderName ?? 'No name',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  sebaDetailsList[index].name ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                  ),
                ),
                trailing: InkWell(
                  onTap: () =>
                      uriLaunchUrl('tel:${sebaDetailsList[index].phone}'),
                  child: const Icon(
                    Icons.call,
                    size: 35,
                    color: Colors.green,
                  ),
                ),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.topLeft,
                    child: Text(
                      sebaDetailsList[index].description ?? 'No description',
                      style: const TextStyle(color: Colors.white),
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
