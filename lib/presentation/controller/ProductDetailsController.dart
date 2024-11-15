import 'package:get/get.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import '../../data/model/ProductDetailsModel.dart';
import '../../data/urls..dart';

class ProductDetailsController extends GetxController {
  var isLoading = true.obs;
  var totalItemCount = "0".obs;
  var productDetails = Rxn<ProductDetailsModel>();
  var errorMessage = ''.obs;

  void fetchProductDetails(String catId) async {
    try {
      isLoading(true);
      errorMessage('');
      var response = await NetworkCaller.getRequest(
        url: ApiUrl.productsUrls(catId),
      );

      if (response.isSuccess && response.responseData != null) {
        productDetails.value = ProductDetailsModel.fromJson(response.responseData);
        totalItemCount.value =
            productDetails.value?.data.data.length.toString() ?? '0';
      } else {
        errorMessage('Failed to load product details.');
      }
    } catch (e) {
      errorMessage('An error occurred while fetching product details.');
      print("Error fetching product details: $e");
    } finally {
      isLoading(false);
    }
  }
}
