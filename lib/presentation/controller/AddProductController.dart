import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../data/model/buysell_category_model.dart';
import '../../data/urls..dart';
import '../controller/user_auth_controller.dart';

class AddProductController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController nameController = TextEditingController(); // New
  final TextEditingController brandController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountPriceController = TextEditingController(); // New
  final TextEditingController phoneController = TextEditingController(); // New
  final TextEditingController descriptionController = TextEditingController();

  // Observables
  var selectedCondition = 'New'.obs;
  final List<String> conditions = ['New', 'Used', 'N/A'];

  var selectedCategory = Rxn<Category>();
  var selectedSubcategory = Rxn<Subcategory>();
  var categories = <Category>[].obs;
  var subcategories = <Subcategory>[].obs;
  RxBool loading = false.obs;

  // Images
  final images = List<File?>.filled(3, null, growable: false).obs;

  // Image Picker
  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final url = ApiUrl.buySellCategoryUrl; // Your API URL as a String
    try {
      // Logging the URL
      log('Fetching categories from: $url');

      // Getting the token
      String token = UserAuthController.accessToken;
      log('Using token: $token');

      // Making the GET request with authorization header
      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": token},
      );

      // Logging response status and body
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Assuming the data is under jsonResponse['data']['data']
        final List<dynamic> data = jsonResponse['data']['data'];

        categories.value = data.map((item) => Category.fromJson(item)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch categories',
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while fetching categories',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  Future<void> pickImage(int index) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 15,
    );

    if (pickedFile != null) {
      images[index] = File(pickedFile.path);
    }
  }

  void removeImage(int index) {
    images[index] = null;
  }

  void onCategoryChanged(Category? category) {
    selectedCategory.value = category;
    if (category != null) {
      subcategories.value = category.subcategories;
      selectedSubcategory.value = null;
    } else {
      subcategories.clear();
    }
  }

  void onSubcategoryChanged(Subcategory? subcategory) {
    selectedSubcategory.value = subcategory;
  }

  void onConditionChanged(String? value) {
    selectedCondition.value = value!;
  }

  void submitForm() async {
    if (formKey.currentState!.validate()) {
      // Ensure at least one image is selected
      if (images.every((image) => image == null)) {
        Get.snackbar('Error', 'Please upload at least one image.',
            backgroundColor: Colors.redAccent, colorText: Colors.white);
        return;
      }

      // Ensure category and subcategory are selected
      if (selectedCategory.value == null || selectedSubcategory.value == null) {
        Get.snackbar('Error', 'Please select category and subcategory.',
            backgroundColor: Colors.redAccent, colorText: Colors.white);
        return;
      }

      loading.value = true;

      // Map condition to isUsed
      dynamic isUsed = selectedCondition.value;

      // Prepare the data
      final url = ApiUrl.addProductUrl; // Your API URL as a String

      try {
        var request = http.MultipartRequest('POST', Uri.parse(url));
        // Logging the URL
        log('Submitting product to: $url');
        // Getting the token
        String token = UserAuthController.accessToken;
        log('Using token: $token');
        // Adding headers
        request.headers['Authorization'] = token;
        // Add text fields
        request.fields['title'] = titleController.text.trim();
        request.fields['name'] = nameController.text.trim();
        request.fields['desc'] = descriptionController.text.trim();
        request.fields['price'] = priceController.text.trim();
        request.fields['discountPrice'] = "0";
        request.fields['subCategoryId'] = selectedSubcategory.value!.id;
        request.fields['categoryId'] = selectedCategory.value!.id;
        request.fields['brand'] = brandController.text.trim();
        request.fields['isUsed'] = isUsed.toString();
        request.fields['phone'] = phoneController.text.trim();

        // Add images with content type and validation
        for (int i = 0; i < images.length; i++) {
          if (images[i] != null) {
            String fieldName = i == 0 ? 'img' : 'img${i + 1}';
            // Get the file extension
            String extension = images[i]!.path.split('.').last.toLowerCase();
            // Determine the content type
            String? mimeType;
            if (extension == 'jpg' || extension == 'jpeg') {
              mimeType = 'image/jpeg';
            } else if (extension == 'png') {
              mimeType = 'image/png';
            } else {
              Get.snackbar('Error',
                  'Only images with png, jpg, or jpeg format are allowed.',
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white);
              return;
            }
            // Add the image to the request with the correct content type
            request.files.add(await http.MultipartFile.fromPath(
              fieldName,
              images[i]!.path,
              contentType: MediaType('image', extension),
            ));
          }
        }

        // Send the request
        var response = await request.send();

        // Convert the response to a string
        var responseString = await response.stream.bytesToString();

        // Logging response status and body
        log('Response status: ${response.statusCode}');
        log('Response body: $responseString');

        if (response.statusCode == 200) {
          Get.back();
          loading.value = false;
          // Handle successful response
          Get.snackbar('Success', 'আপনার প্রোডাক্টটি পেন্ডিং রয়েছে। অনুগ্রহ করে অ্যাপ্রুভের জন্য অপেক্ষা করুন।',
              backgroundColor: Colors.green, colorText: Colors.white);

          // Clear the form
          formKey.currentState!.reset();
          resetState();
        } else {
          // Handle error response
          Get.snackbar('Error', 'Failed to add product.',
              backgroundColor: Colors.redAccent, colorText: Colors.white);
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred: $e',
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    }
  }

  void resetState() {
    selectedCondition.value = 'New';
    selectedCategory.value = null;
    selectedSubcategory.value = null;
    subcategories.clear();
    images.fillRange(0, images.length, null);
    // Clear text controllers
    titleController.clear();
    nameController.clear();
    brandController.clear();
    priceController.clear();
    discountPriceController.clear();
    phoneController.clear();
    descriptionController.clear();
  }

  @override
  void onClose() {
    // Dispose controllers
    titleController.dispose();
    nameController.dispose(); // Dispose new controllers
    brandController.dispose();
    priceController.dispose();
    discountPriceController.dispose(); // Dispose new controllers
    phoneController.dispose(); // Dispose new controllers
    descriptionController.dispose();
    super.onClose();
  }
}
