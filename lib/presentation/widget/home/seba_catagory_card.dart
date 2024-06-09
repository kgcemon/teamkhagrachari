import 'package:flutter/material.dart';
import 'package:teamkhagrachari/data/model/CategoryModel.dart';
import 'package:teamkhagrachari/data/urls..dart';
import '../../screen/dashboard/seba_details.dart';
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

  GridView _buildGridView(BuildContext context) {
    return GridView.builder(
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
                  sebaID: sebaList[index].id,
                ),
              ),
            ),
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
                      Image.network(
                        sebaList[index].img.toString(),
                        width: 30,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error, size: 30);
                        },
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
        );
  }

  int _getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 120).floor();
    return crossAxisCount > 3 ? 3 : crossAxisCount;
  }
}
