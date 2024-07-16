import 'package:get/get.dart';
import 'package:teamkhagrachari/data/model/network_response.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import 'package:teamkhagrachari/data/urls..dart';
import '../../data/model/ScrollTextModel.dart';

class HomePageScrollTextController extends GetxController {
  var filteredDetails = ScrollTextModel().obs;
  getLoadScrollText() async {
    NetworkResponse response =
    await NetworkCaller.getRequest(url: ApiUrl.scrollTextUrl);
    filteredDetails.value = ScrollTextModel.fromJson(response.responseData);
  }
}
