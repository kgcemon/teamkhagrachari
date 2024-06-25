import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:teamkhagrachari/data/model/CategoryModel.dart';
import '../../screen/seba_details.dart';
import '../../utils/color.dart';

class SebaCatagoryCard extends StatelessWidget {
  final String sebaName;
  final List<CategoryModel> sebaList;

  const SebaCatagoryCard(
      {Key? key, required this.sebaList, required this.sebaName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              color: MyColors.primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                sebaName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _buildGridView(context),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  Widget _buildGridView(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sebaList.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                crossAxisCount: _getCrossAxisCount(context),
                mainAxisExtent: 75),
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
              child: AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 3,
                duration: const Duration(milliseconds: 1500),
                child: FlipAnimation(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(5)),
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
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
                              height: 7,
                            ),
                            Text(
                              sebaList[index].name,
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
  }

  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 120).floor();
    return crossAxisCount > 3 ? 3 : crossAxisCount;
  }
}
