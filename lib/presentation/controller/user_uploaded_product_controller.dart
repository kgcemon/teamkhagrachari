import 'package:get/get.dart';
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import 'package:teamkhagrachari/data/urls..dart';

class UserUploadedProductController extends GetxController{
  RxBool isLoading = false.obs;
  RxList myProducts = [].obs;

  void loadUserUploadedProduct()async{
    var response = await NetworkCaller.getRequest(url: "${ApiUrl.mainUrl}/products/get-my-products");
    print(response.responseData);
    myProducts.value = response.responseData['data'];
    isLoading.value = false;}


  Future deleteProduct({required id})async{
    var response = await NetworkCaller.deleteRequest(url: "${ApiUrl.mainUrl}/products/$id");

  }


}