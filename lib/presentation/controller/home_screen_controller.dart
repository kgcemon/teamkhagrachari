import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/data/model/CategoryModel.dart';
import 'package:teamkhagrachari/data/model/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:teamkhagrachari/data/network_caller/network_caller.dart';
import 'package:teamkhagrachari/data/urls..dart';

class HomeScreenController extends GetxController {
  String username = '';
  String phoneNumber = '';
  List<CategoryModel> _category = [];
  List<NewsModel> _newsList = [];
  bool _loadingProgress = true;

  List<CategoryModel> get category => _category;

  List<NewsModel> get newsList => _newsList;

  bool get loadingProgress => _loadingProgress;

  void loadAll() async {
    await fetchAllCategory();
    await loadNews();
  }

  Future<void> fetchAllCategory() async {
    try {
      final response = await NetworkCaller.getRequest(url: ApiUrl.categoryUrl);
      if (response.responseCode == 200) {
        _category.clear();
        _category = categoryModelFromJson(
          jsonEncode(response.responseData['data']['data']),
        );
        update();
      } else {
        if (kDebugMode) {
          print(
              'Failed to load categories with status code: ${response.responseCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('An error occurred: $e');
      }
    }
  }

  Future<void> loadNews() async {
    _newsList.clear();
    try {
      final response = await http.get(Uri.parse(ApiUrl.newsApiUrl));

      if (response.statusCode == 200) {
        List<dynamic> responseList = jsonDecode(response.body);
        _newsList =
            responseList.map((element) => NewsModel.fromJson(element)).toList();
        _loadingProgress = false;
        update();
      } else {
        Get.snackbar("Ops", response.statusCode.toString());
        _loadingProgress = false;
      }
    } catch (e) {
      _loadingProgress = false;
      Get.snackbar("Ops", e.toString());
    }
  }
}
