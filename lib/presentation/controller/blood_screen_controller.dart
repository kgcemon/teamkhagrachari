import 'package:get/get.dart';
import 'package:teamkhagrachari/data/model/blood_model.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import '../../data/urls..dart';

class BloodScreenController extends GetxController {
  List<BloodModel> bloodDetailsList = [];
  List<BloodModel> filteredList = [];

  @override
  void onInit() {
    super.onInit();
    fetchBloodDetails();
  }

  Future<void> fetchBloodDetails() async {
    bloodDetailsList.clear();
    final response = await NetworkCaller.getRequest(url: ApiUrl.bloodUrl);
    final List networkList = response.responseData['data']['data'];
    bloodDetailsList = networkList.map((element) => BloodModel.fromJson(element)).toList();
    filteredList = List.from(bloodDetailsList);
    update();
  }

  void filterDonors({required String bloodGroup, required String upazila}) {
    filteredList = bloodDetailsList.where((donor) {
      final matchBloodGroup = bloodGroup == 'রক্তের গ্রুপ' || donor.bloodGroup == bloodGroup;
      final matchUpazila = upazila == 'উপজেলা' || donor.upazila == upazila;
      return matchBloodGroup && matchUpazila;
    }).toList();
    update();
  }
}
