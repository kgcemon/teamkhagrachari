import 'dart:convert';

import 'package:get/get.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import 'package:teamkhagrachari/data/urls..dart';
import '../../data/model/ProductDetailsModel.dart';

class ProductDetailsController extends GetxController {
  var isLoading = true.obs;
  var productDetails = Rxn<ProductDetailsModel>();

  void fetchProductDetails(String catId) async {
    try {
      isLoading(true);
      var response = await NetworkCaller.getRequest(url: ApiUrl.productsUrls(catId));
      ProductDetailsModel productDetailsModel = productDetailsModelFromJson(jsonEncode(response.responseData));
      productDetails.value = productDetailsModel;
      print(response.responseData);
    } catch (e) {
      print("Error fetching product details: $e");
    } finally {
      isLoading(false);
    }
  }
}
