import 'package:get/get.dart';
import 'package:teamkhagrachari/data/model/seba_details_model.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';

import '../../data/urls..dart';

class SebaDetailsScreenController extends GetxController {
  var progress = true.obs;
  var sebaDetails = SebaDetailsModel().obs;
  var filteredDetails = <SebaDetailsDataListModel>[].obs;

  Future<SebaDetailsModel> fetchSebaDetails(String id) async {
    progress.value = true;
    final response = await NetworkCaller.getRequest(url: ApiUrl.categoryDetailsUrl + id);
    sebaDetails.value = SebaDetailsModel.fromJson(response.responseData);
    filteredDetails.value = sebaDetails.value.data?.data ?? [];
    progress.value = false;
    return sebaDetails.value;
  }

  void filterDetails(String query) {
    if (query.isEmpty) {
      filteredDetails.value = sebaDetails.value.data?.data ?? [];
    } else {
      filteredDetails.value = sebaDetails.value.data?.data
          ?.where((item) =>
      item.serviceProviderName
          ?.toLowerCase()
          .contains(query.toLowerCase()) ?? false ||
          item.name!.toLowerCase().contains(query.toLowerCase()))
          .toList() ?? [];
    }
  }
}
