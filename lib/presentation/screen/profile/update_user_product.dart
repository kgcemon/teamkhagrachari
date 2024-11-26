import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/controller/profile_screen_controller.dart';
import '../../../data/model/buysell_category_model.dart';
import '../../controller/user_product_update_controller.dart';
import '../../utils/color.dart';

class UserProductUpdateScreen extends StatefulWidget {
  String title;
  String condition;
  String brand;
  String prices;
  String phone;
  String describe;
  List img;

  UserProductUpdateScreen(
      {Key? key,
      required this.title,
      required this.condition,
      required this.prices,
      required this.brand,
      required this.describe,
      required this.phone,
        required this.img,
      })
      : super(key: key);

  @override
  State<UserProductUpdateScreen> createState() =>
      _UserProductUpdateScreenState();
}

class _UserProductUpdateScreenState extends State<UserProductUpdateScreen> {

  // Text Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController nameController = TextEditingController(); // New
  final TextEditingController brandController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountPriceController = TextEditingController(); // New
  final TextEditingController phoneController = TextEditingController(); // New
  final TextEditingController descriptionController = TextEditingController();

  // Initialize the controller
  final UserProductUpdateController controller = Get.put(UserProductUpdateController());

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    brandController.text = widget.brand;
    priceController.text = widget.prices;
    phoneController.text = widget.prices;
    descriptionController.text = widget.describe;
    controller.selectedCondition.value = widget.condition;
    Get.find<ProfileScreenController>().getProfile();
  }

  @override
  Widget build(BuildContext context) {

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
                            'Update Product',
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
                            controller: titleController,
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
                            controller: brandController,
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
                            controller: priceController,
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
                            controller: phoneController,
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
                            controller: descriptionController,
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
                                        : Image.network(widget.img[index]),
                                  ),
                                );
                              }),
                            );
                          }),
                          const SizedBox(height: 10.0),

                          Obx(() {
                            return controller.loading.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : ElevatedButton.icon(
                                    onPressed: controller.submitForm,
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
