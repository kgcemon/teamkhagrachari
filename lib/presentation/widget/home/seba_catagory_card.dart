import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teamkhagrachari/data/model/CategoryModel.dart';
import '../../screen/seba_details.dart';

class SebaCatagoryCard extends StatelessWidget  {
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
        Text(
          sebaName,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        _buildGridView(context),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sebaList.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: getCrossAxisCount(context),
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
              child: Card(
                margin: const EdgeInsets.all(0),
                color: Colors.transparent,
                elevation: 20,
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
    );
  }

  int getCrossAxisCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 120).floor();
    return crossAxisCount > 3 ? 3 : crossAxisCount;
  }
}

