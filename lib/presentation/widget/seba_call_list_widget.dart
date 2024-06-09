import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:teamkhagrachari/data/model/seba_details_model.dart';
import 'package:teamkhagrachari/presentation/utils/assets_path.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';
import 'package:teamkhagrachari/presentation/utils/uri_luncher.dart';


Widget buildSebaCallList(List<SebaDetailsModel> sebaDetailsList, BuildContext context ) {
  return Expanded(
    child: Visibility(
      visible: sebaDetailsList.isNotEmpty,
      replacement: Lottie.asset(AssetPath.loadingJson),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => ListTile(
            title: Text(sebaDetailsList[index].name),
            subtitle: Text(sebaDetailsList[index].description),
            trailing: InkWell(
                onTap: () => uriLaunchUrl(
                    'tel:${sebaDetailsList[index].phone}'),
                child: const Icon(
                  Icons.call,
                  size: 35,
                  color: Colors.green,
                )),
          ),
          separatorBuilder: (context, index) => Divider(
            color: MyColors.primaryColor,
          ),
          itemCount: sebaDetailsList.length),
    ),
  );
}