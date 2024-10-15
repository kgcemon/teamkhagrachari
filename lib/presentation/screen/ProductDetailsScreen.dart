import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: const Color(0xFF2C2D41),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: NetworkImage("https://img.drz.lazcdn.com/static/bd/p/6502ea35eac4cbdc199499e394609c5f.jpg_720x720q80.jpg_.webp"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Product Title
            Text(
              "Ladies Jacket",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            // Product Price
            Text(
              "৳50",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            // Product Description
            const Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "This ladies jacket is perfect for winter, providing warmth and comfort with a stylish look. Made with high-quality materials, it ensures durability and a fashionable appearance.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}