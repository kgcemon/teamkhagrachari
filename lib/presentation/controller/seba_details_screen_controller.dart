import 'dart:convert';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:teamkhagrachari/data/model/seba_details_model.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import 'package:teamkhagrachari/data/urls..dart';

class SebaDetailsScreenController extends GetxController {
  List<SebaDetailsModel> sebaDetailsList = [];
  List<SebaDetailsModel> searchList = [];

  fetchSebaDetails(String id) async {
    sebaDetailsList.clear();
    final response =
        await NetworkCaller.getRequest(url: ApiUrl.categoryDetailsUrl + id);
    sebaDetailsList = sebaDetailsModelFromJson(
        jsonEncode(response.responseData['data']['data']));
    searchList = sebaDetailsList;
    update();
  }

  search(String name) {
    searchList = sebaDetailsList
        .where((element) =>
            element.name.contains(name) ||
            element.description.contains(name) ||
            element.phone.contains(name))
        .toList();
    print(searchList);
    update();
  }
}
