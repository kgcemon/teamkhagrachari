import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/bangla_convertor.dart';
import '../controller/ProductDetailsController.dart';
import '../utils/assets_path.dart';
import 'ProductDetailsScreen.dart';
import '../../data/model/ProductDetailsModel.dart';

class ProductViewScreen extends StatefulWidget {
  final String title;
  final String categoryId;

  const ProductViewScreen({Key? key, required this.categoryId, required this.title})
      : super(key: key);

  @override
  ProductViewScreenState createState() => ProductViewScreenState();
}

class ProductViewScreenState extends State<ProductViewScreen> {
  String selectedSubcategory = 'All';
  String selectedLocation = 'All';
  String searchQuery = '';
  bool isSearchExpanded = false;

  // Lists to store subcategories and locations from API
  List<String> subcategories = ['All'];
  List<String> locations = ['All'];

  final ProductDetailsController _productDetailsController =
  Get.put(ProductDetailsController());

  // List to store filtered products
  List<ProductDetails> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _productDetailsController.fetchProductDetails(widget.categoryId);
    // Listen for changes in the product details
    _productDetailsController.productDetails.listen((_) {
      initializeFilters();
      filterProducts();
    });
  }

  // Method to initialize subcategories and locations from API data
  void initializeFilters() {
    if (_productDetailsController.productDetails.value == null) {
      return;
    }
    List<ProductDetails> products =
        _productDetailsController.productDetails.value!.data.data;

    // Extract unique subcategory names
    Set<String> subcategorySet =
    products.map((product) => product.subCategoryId.name).toSet();
    setState(() {
      subcategories = ['All'] + subcategorySet.toList();
      // Reset selected subcategory if it's no longer available
      if (!subcategories.contains(selectedSubcategory)) {
        selectedSubcategory = 'All';
      }
    });

    // Extract unique locations (upazila names)
    Set<String> locationSet =
    products.map((product) => product.userId.upazila).toSet();
    setState(() {
      locations = ['All'] + locationSet.toList();
      // Reset selected location if it's no longer available
      if (!locations.contains(selectedLocation)) {
        selectedLocation = 'All';
      }
    });
  }

  // Method to filter products based on selected filters and search query
  void filterProducts() {
    if (_productDetailsController.productDetails.value == null) {
      setState(() {
        filteredProducts = [];
      });
      return;
    }
    List<ProductDetails> products =
        _productDetailsController.productDetails.value!.data.data;
    List<ProductDetails> tempList = products.where((product) {
      // Apply subcategory filter
      bool matchesSubcategory = selectedSubcategory == 'All' ||
          product.subCategoryId.name == selectedSubcategory;

      // Apply location filter
      bool matchesLocation = selectedLocation == 'All' ||
          product.userId.upazila == selectedLocation;

      // Apply search query filter
      bool matchesSearchQuery = searchQuery.isEmpty ||
          product.name.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesSubcategory && matchesLocation && matchesSearchQuery;
    }).toList();

    setState(() {
      filteredProducts = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C2D41),
      appBar: AppBar(
        title: Obx(
              () => Text(
            "${widget.title} (${BanglaConvertor.convertPrice(_productDetailsController.totalItemCount.value)} টি)",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          // Filters UI
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                if (!isSearchExpanded)
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: DropdownButton<String>(
                        value: selectedSubcategory,
                        dropdownColor: Colors.indigoAccent,
                        icon: const Icon(Icons.arrow_downward,
                            color: Colors.white),
                        elevation: 16,
                        style: const TextStyle(color: Colors.white),
                        underline: Container(
                          height: 3,
                          color: Colors.indigo,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSubcategory = newValue!;
                            if (kDebugMode) {
                              print('Selected subcategory: $selectedSubcategory');
                            }
                            filterProducts();
                          });
                        },
                        items: subcategories
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                const SizedBox(width: 8.0),
                if (!isSearchExpanded)
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: DropdownButton<String>(
                        value: selectedLocation,
                        dropdownColor: Colors.indigoAccent,
                        icon: const Icon(Icons.arrow_downward,
                            color: Colors.white),
                        elevation: 16,
                        style: const TextStyle(color: Colors.white),
                        underline: Container(
                          height: 2,
                          color: Colors.indigo,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedLocation = newValue!;
                            if (kDebugMode) {
                              print('Selected location: $selectedLocation');
                            }
                            filterProducts();
                          });
                        },
                        items: locations
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                const SizedBox(width: 8.0),
                // Search box
                Expanded(
                  flex: isSearchExpanded ? 6 : 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isSearchExpanded = !isSearchExpanded;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.white),
                          if (isSearchExpanded)
                            Expanded(
                              child: TextField(
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(color: Colors.white70),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 15),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery = value;
                                    if (kDebugMode) {
                                      print('Search query: $searchQuery');
                                    }
                                    filterProducts();
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
                  () {
                if (_productDetailsController.isLoading.value) {
                  return const Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.white,
                    ),
                  );
                } else if (_productDetailsController.errorMessage.value.isNotEmpty) {
                  return Center(
                    child: Text(
                      _productDetailsController.errorMessage.value,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10.0),
                    child: filteredProducts.isEmpty
                        ? const Center(
                      child: Text(
                        'No products found.',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                        : GridView.builder(
                      itemCount: filteredProducts.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 4,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemBuilder: (context, index) {
                        ProductDetails product = filteredProducts[index];

                        if (kDebugMode) {
                          print('Building item at index: $index');
                        }
                        return Card(
                          elevation: 6,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: InkWell(
                            onTap: () => Get.to(
                                  () => ProductDetailsScreen(
                                data:  _productDetailsController
                                    .productDetails.value!, index: index,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: ClipRRect(
                                    borderRadius:
                                    const BorderRadius.vertical(
                                      top: Radius.circular(15),
                                    ),
                                    child: Image.network(
                                      product.img,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child,
                                          loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          if (kDebugMode) {
                                            print(
                                              'Loading image at index: $index');
                                          }
                                          return Center(
                                            child:
                                            SizedBox(
                                              height: 80,
                                                child: Image.asset(AssetPath.loadingGif)),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      product.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo.shade900,
                                        fontSize: 18,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "৳${product.price}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          product.userId.upazila,
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
