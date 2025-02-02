import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:teamkhagrachari/data/model/news_model.dart';
import 'package:teamkhagrachari/data/model/slider_image_model.dart';
import '../../data/model/CategoryModel.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/urls..dart';

class HomeScreenController extends GetxController {
  String username = '';
  String phoneNumber = '';

  List<CategoryModel> _category = [];
  List<CategoryModel> _filteredCategory = []; // List to hold filtered categories

  List<NewsModel> _newsList = [];
  List<NewsModel> _filteredNewsList = []; // List to hold search results for news

  bool _loadingProgress = true;

  TextEditingController searchController = TextEditingController(); // Search controller

  // Getters for category and news lists
  List<CategoryModel> get category => _filteredCategory.isEmpty ? _category : _filteredCategory;
  List<NewsModel> get newsList => _filteredNewsList.isEmpty ? _newsList : _filteredNewsList;

  bool get loadingProgress => _loadingProgress;

  final List<String> _sliderImageList = [];
  List<String> get sliderImageList => _sliderImageList;

  @override
  void onInit() {
    super.onInit();

    // Listener for search input
    searchController.addListener(() {
      searchItems(searchController.text);
    });
  }

  Future<void> loadAll({required Function(double) onProgress}) async {
    double progress = 0.0;
    onProgress(progress);

    await _fetchAllCategory((newProgress) {
      progress = newProgress;
      onProgress(progress);
    });

    await _getImageLoad((newProgress) {
      progress = newProgress;
      onProgress(progress);
    });

    _loadingProgress = false;
    update();
  }

  Future<void> _fetchAllCategory(Function(double) onProgress) async {
    if (_category.isEmpty) {
      try {
        final response =
        await NetworkCaller.getRequest(url: ApiUrl.categoryUrl(page: 1, limit: 100));
        if (response.responseCode == 200) {
          _category.clear();
          _category = categoryModelFromJson(
            jsonEncode(response.responseData['data']['data']),
          );
          _filteredCategory = _category; // Initialize filtered category list
          onProgress(50.0);
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
  }

  Future<void> _getImageLoad(Function(double) onProgress) async {
    if (_sliderImageList.isEmpty) {
      var response = await NetworkCaller.getRequest(url: ApiUrl.sliderImgUrls);
      var data = SliderImageModel.fromJson(response.responseData);
      _sliderImageList.clear();
      for (int i = 0; i < data.data.length; i++) {
        _sliderImageList.add(data.data[i].img);
      }
      onProgress(100.0);
      update();
    }
  }

  Future<void> loadNews() async {
    if (_newsList.isEmpty) {
      try {
        final response = await http.get(Uri.parse(ApiUrl.newsApiUrl));
        if (response.statusCode == 200) {
          List<dynamic> responseList = jsonDecode(response.body);
          _newsList = responseList
              .map((element) => NewsModel.fromJson(element))
              .toList();
          _filteredNewsList = _newsList; // Initialize filtered news list
          _loadingProgress = false;
          update();
        } else {
          Get.snackbar("Oops", response.statusCode.toString());
          _loadingProgress = false;
        }
      } catch (e) {
        _loadingProgress = false;
        Get.snackbar("Oops", e.toString());
      }
    }
  }

  // Search for both categories and news
  void searchItems(String query) {
    // Filter categories
    if (query.isEmpty) {
      _filteredCategory = _category;
    } else {
      _filteredCategory = _category
          .where((cat) =>
          cat.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    // Filter news
    if (query.isEmpty) {
      _filteredNewsList = _newsList;
    } else {
      _filteredNewsList = _newsList
          .where((news) =>
          news.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    update(); // Notify listeners to rebuild UI
  }
}
