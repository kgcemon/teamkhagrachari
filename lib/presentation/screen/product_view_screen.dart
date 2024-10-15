import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'ProductDetailsScreen.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({super.key});

  @override
  ProductViewScreenState createState() => ProductViewScreenState();
}

class ProductViewScreenState extends State<ProductViewScreen> {
  String selectedSubcategory = 'All';
  String selectedLocation = 'All';
  String searchQuery = '';
  bool isSearchExpanded = false;

  final List<String> subcategories = [
    'All',
    'Jackets',
    'Trousers',
    'Shoes',
    'Accessories',
  ];

  final List<String> locations = [
    'All',
    'Dhaka',
    'Chittagong',
    'Khagrachari',
    'Sylhet',
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF2C2D41),
      appBar: AppBar(
        // App bar with title "Product Catalog" and background color matching theme
        title: const Text(
          "Product Catalog",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
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
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: DropdownButton<String>(
                        value: selectedSubcategory,
                        dropdownColor: Colors.indigoAccent,
                        icon: const Icon(Icons.arrow_downward, color: Colors.white),
                        elevation: 16,
                        style: const TextStyle(color: Colors.white),
                        underline: Container(
                          height: 2,
                          color: Colors.indigo,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSubcategory = newValue!;
                            print('Selected subcategory: \$selectedSubcategory');
                          });
                        },
                        items: subcategories.map<DropdownMenuItem<String>>((String value) {
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
                // Location filter dropdown
                if (!isSearchExpanded)
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: DropdownButton<String>(
                        value: selectedLocation,
                        dropdownColor: Colors.indigoAccent,
                        icon: const Icon(Icons.arrow_downward, color: Colors.white),
                        elevation: 16,
                        style: const TextStyle(color: Colors.white),
                        underline: Container(
                          height: 2,
                          color: Colors.indigo,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedLocation = newValue!;
                            print('Selected location: \$selectedLocation');
                          });
                        },
                        items: locations.map<DropdownMenuItem<String>>((String value) {
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
                  flex: isSearchExpanded ? 6 : 1,
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
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery = value;
                                    print('Search query: \$searchQuery');
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
            child: Padding(
              // Padding around the GridView for better layout spacing
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: GridView.builder(
                // Define the number of items in the GridView
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  // Set the number of columns to 2
                  crossAxisCount: 2,
                  // Set the aspect ratio of each item (width / height)
                  childAspectRatio: 3 / 4,
                  // Space between items in the horizontal direction
                  crossAxisSpacing: 10.0,
                  // Space between items in the vertical direction
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context, index) {
                  // Log message to indicate the item being built
                  print('Building item at index: \$index');
                  return Card(
                    elevation: 6,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      // Rounded corners for the card
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      onTap: () =>  Get.to(()=> const ProductDetailsScreen()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 6,
                            child: ClipRRect(
                              // Clip the image to have rounded top corners
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                              child: Image.network(
                                "https://img.drz.lazcdn.com/static/bd/p/6502ea35eac4cbdc199499e394609c5f.jpg_720x720q80.jpg_.webp",
                                fit: BoxFit.cover, // Cover the entire area of the widget
                                loadingBuilder: (context, child, loadingProgress) {
                                  // Show progress indicator while the image is loading
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    print('Loading image at index: \$index');
                                    return Center(
                                      child: CircularProgressIndicator(
                                        // Show loading progress if available
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                            : null,
                                      ),
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
                              // Padding around the product title
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Ladies Jacket",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo.shade900,
                                  fontSize: 18,
                                ),
                                maxLines: 2, // Limit the text to two lines
                                overflow: TextOverflow.ellipsis, // Ellipsis for overflow text
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              // Padding around the price and location row
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Price text with bold and green color
                                  const Text(
                                    "৳50",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal,
                                      fontSize: 16,
                                    ),
                                  ),
                                  // Location text with italic style and grey color
                                  Text(
                                    "Khagrachari",
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
            ),
          ),
        ],
      ),
    );
  }
}