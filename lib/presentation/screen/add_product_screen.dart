import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/controller/profile_screen_controller.dart';
import '../../data/model/buysell_category_model.dart';
import '../controller/AddProductController.dart';
import '../utils/color.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProfileScreenController>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final AddProductController controller = Get.put(AddProductController());

    return Scaffold(body: GetBuilder<ProfileScreenController>(
      builder: (controllers) {
        if (controllers.profileData.data == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container(
            decoration: BoxDecoration(
              color: MyColors.primaryColor,
            ),
            child: SafeArea(
              child: Obx(() {
                if (controller.categories.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                } else {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 24.0),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Page Title
                          const Text(
                            'Add New Product',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24.0),

                          // Category Dropdown
                          Obx(() {
                            return DropdownButtonFormField<Category>(
                              value: controller.selectedCategory.value,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Category',
                                labelStyle:
                                    const TextStyle(color: Colors.white70),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(Icons.category,
                                    color: Colors.white70),
                              ),
                              dropdownColor: MyColors.secenderyColor,
                              items: controller.categories
                                  .map((category) => DropdownMenuItem(
                                        value: category,
                                        child: Text(
                                          category.name,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: controller.onCategoryChanged,
                              validator: (value) => value == null
                                  ? 'Please select a category'
                                  : null,
                            );
                          }),
                          const SizedBox(height: 16.0),

                          // Subcategory Dropdown
                          Obx(() {
                            return DropdownButtonFormField<Subcategory>(
                              value: controller.selectedSubcategory.value,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Subcategory',
                                labelStyle:
                                    const TextStyle(color: Colors.white70),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                    Icons.subdirectory_arrow_right,
                                    color: Colors.white70),
                              ),
                              dropdownColor: MyColors.secenderyColor,
                              items: controller.subcategories
                                  .map((subcategory) => DropdownMenuItem(
                                        value: subcategory,
                                        child: Text(
                                          subcategory.name,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: controller.onSubcategoryChanged,
                              validator: (value) => value == null
                                  ? 'Please select a subcategory'
                                  : null,
                            );
                          }),
                          const SizedBox(height: 16.0),

                          // Name
                          TextFormField(
                            controller: controller.nameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Title',
                              labelStyle:
                                  const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.label,
                                  color: Colors.white70),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),

                          // Condition Dropdown
                          Obx(() {
                            return DropdownButtonFormField<String>(
                              value: controller.selectedCondition.value,
                              style: const TextStyle(color: Colors.white),
                              dropdownColor: MyColors.secenderyColor,
                              decoration: InputDecoration(
                                labelText: 'Condition',
                                labelStyle:
                                    const TextStyle(color: Colors.white70),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                    Icons.assignment_turned_in,
                                    color: Colors.white70),
                              ),
                              items: controller.conditions
                                  .map((condition) => DropdownMenuItem(
                                        value: condition,
                                        child: Text(
                                          condition,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: controller.onConditionChanged,
                            );
                          }),
                          const SizedBox(height: 16.0),

                          // Brand
                          TextFormField(
                            controller: controller.brandController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Brand',
                              labelStyle:
                                  const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.branding_watermark,
                                  color: Colors.white70),
                            ),
                          ),
                          const SizedBox(height: 16.0),

                          // Price
                          TextFormField(
                            controller: controller.priceController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Price',
                              labelStyle:
                                  const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the price';
                              }
                              final n = num.tryParse(value);
                              if (n == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),

                          // Phone
                          TextFormField(
                            controller: controller.phoneController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Phone',
                              labelStyle:
                                  const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.phone,
                                  color: Colors.white70),
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),

                          // Description
                          TextFormField(
                            controller: controller.descriptionController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Description',
                              labelStyle:
                                  const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.description,
                                  color: Colors.white70),
                            ),
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the Description';
                              }
                            },
                          ),
                          const SizedBox(height: 10.0),

                          // Image Upload Section
                          Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(3, (index) {
                                return GestureDetector(
                                  onTap: () => controller.pickImage(index),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white54),
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.white.withOpacity(0.2),
                                    ),
                                    child: controller.images[index] != null
                                        ? Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.file(
                                                  controller.images[index]!,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Positioned(
                                                right: 0,
                                                child: GestureDetector(
                                                  onTap: () => controller
                                                      .removeImage(index),
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.black54,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : const Icon(
                                            Icons.add_a_photo,
                                            color: Colors.white70,
                                            size: 40,
                                          ),
                                  ),
                                );
                              }),
                            );
                          }),
                          const SizedBox(height: 10.0),
                          // Submit Button
                          // Inside your widget tree, where you have the submit button
                          Obx(() {
                            return controller.loading.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : ElevatedButton.icon(
                                    onPressed: controller.images
                                                .where((image) => image != null)
                                                .length <
                                            3
                                        ? () => ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Please upload 3 images')))
                                        : controller.submitForm,
                                    icon: const Icon(Icons.save),
                                    label: const Text('Add Product'),
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(50),
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      textStyle: const TextStyle(fontSize: 18),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  );
                          }),
                        ],
                      ),
                    ),
                  );
                }
              }),
            ),
          );
        }
      },
    ));
  }
}
