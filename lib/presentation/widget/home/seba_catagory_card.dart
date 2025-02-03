import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/data/model/CategoryModel.dart';
import 'package:teamkhagrachari/presentation/screen/importent_services.dart';
import '../../screen/seba_details.dart';
import '../../utils/assets_path.dart';

class SebaCatagoryCard extends StatelessWidget {
  final String sebaName;
  final List<CategoryModel> sebaList;

  const SebaCatagoryCard(
      {Key? key, required this.sebaList, required this.sebaName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sebaName,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () => Get.to(() => const ImportantServices()),
                    child: const Text(
                      "See All",
                      style: TextStyle(color: Colors.blueAccent),
                    ),),
                const Icon(
                  Icons.arrow_right,
                  size: 30,
                  color: Colors.blueAccent,
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        _buildGridView(context),
      ],
    );
  }

  Widget _buildGridView(BuildContext context) {
    return sebaList.isEmpty ?  Image.asset(AssetPath.loadingGif) : GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: getCrossAxisCount(context),
          mainAxisExtent: 100),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SebaDetails(
              sebaname: sebaList[index].name,
              sebaID: sebaList[index].id,
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
                    imageUrl: sebaList[index].img.toString(),
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
                      sebaList[index].name,
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
    );
  }

  int getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 120).floor();
    return crossAxisCount > 3 ? 3 : crossAxisCount;
  }
}
