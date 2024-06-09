import 'package:get/get.dart';
import 'package:teamkhagrachari/data/model/blood_model.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import 'package:teamkhagrachari/data/urls..dart';

class BloodScreenController extends GetxController {
  List<BloodModel> bloodDetailsList = [];
  List<BloodModel> searchList = [];
  Future<void> fetchBloodDetails() async {
    bloodDetailsList.clear();
    final response = await NetworkCaller.getRequest(url: ApiUrl.bloodUrl);
    final List networkList = response.responseData['data']['data'];
    bloodDetailsList = networkList.map((element) => BloodModel.fromJson(element)).toList();
    searchList = List.from(bloodDetailsList);
    update();
  }

  void search(String query) {
    searchList = bloodDetailsList.where((element) {
      return element.name!.contains(query) ||
          element.upazila!.contains(query) ||
          element.bloodGroup!.contains(query);
    }).toList();
    update();
  }
}
