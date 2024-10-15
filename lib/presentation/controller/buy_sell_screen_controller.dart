import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/model/buysell_category_model.dart';
import '../../data/urls..dart';

class BuySellScreenController extends GetxController {
  var isLoading = true.obs; // Observable to track loading state for categories
  var categoryList = <Category>[].obs; // Observable list of categories

  // Add observable for subcategories
  var isLoadingSubcategories = false.obs;
  var subCategoryList = <Subcategory>[].obs;

  // API URL for categories
  final String apiUrl = ApiUrl.buySellCategoryUrl; // Replace with your actual API URL

  @override
  void onInit() {
    super.onInit();
    fetchCategories(); // Fetch categories when the controller is initialized
  }

  // Method to fetch categories from the API
  void fetchCategories() async {
    try {
      isLoading(true); // Set loading to true
      final response = await http.get(Uri.parse(apiUrl));
      print(response.body);
      if (response.statusCode == 200) {
        // Parse the JSON response
        var jsonData = json.decode(response.body);
        var buySellCategoryModel = BuySellCategoryModel.fromJson(jsonData);

        // Update the category list with the fetched data
        categoryList.value = buySellCategoryModel.data.data;
      } else {
        Get.snackbar('Error', 'Failed to load categories');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading(false); // Set loading to false after the data is fetched
    }
  }

  // Method to fetch subcategories for a specific category
  void fetchSubcategories(String categoryId) async {
    try {
      isLoadingSubcategories(true); // Set loading to true
      // Find the category with the given ID
      final category = categoryList.firstWhere((cat) => cat.id == categoryId);

      if (category.subcategories.isNotEmpty) {
        // If the category already has subcategories, use them
        subCategoryList.value = category.subcategories;
      } else {
        // Fetch subcategories from the API if not present
        final response = await http.get(Uri.parse('/$categoryId'));

        if (response.statusCode == 200) {
          // Parse the JSON response
          var jsonData = json.decode(response.body);
          var subcategories = (jsonData['data'] as List<dynamic>)
              .map((e) => Subcategory.fromJson(e))
              .toList();

          // Update the subcategory list with the fetched data
          subCategoryList.value = subcategories;
        } else {
          Get.snackbar('Error', 'Failed to load subcategories');
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoadingSubcategories(false); // Set loading to false after the data is fetched
    }
  }
}
