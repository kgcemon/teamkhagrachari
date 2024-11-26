import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/controller/user_uploaded_product_controller.dart';
import 'package:teamkhagrachari/presentation/screen/profile/update_user_product.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';

class UserUploadedProduct extends StatefulWidget {
  const UserUploadedProduct({super.key});

  @override
  State<UserUploadedProduct> createState() => _UserUploadedProductState();
}

class _UserUploadedProductState extends State<UserUploadedProduct> {
  UserUploadedProductController userUploadedProductController =
      UserUploadedProductController();

  @override
  void initState() {
    userUploadedProductController.loadUserUploadedProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Products",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: MyColors.primaryColor,
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: userUploadedProductController.myProducts.length,
          itemBuilder: (context, index) {
            var product = userUploadedProductController.myProducts[index];
            return Card(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 3,
              child: ListTile(
                contentPadding: const EdgeInsets.all(10.0),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    product['img'],
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey),
                  ),
                ),
                title: Text(
                  product['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    "${product['status']}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        Get.to(() => UserProductUpdateScreen(
                            title: product['name'],
                            condition: product["isUsed"],
                            prices: product['price'],
                            brand: product['brand'],
                            describe: product['desc'],
                            phone: product['phone'],
                            img: [product["img"],
                              product["img2"],
                              product["img3"]],
                            ));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              "Are You Sure?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: const Text(
                              "Are you sure you want to proceed with this action? This operation cannot be undone.",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            actionsPadding: const EdgeInsets.only(
                                bottom: 16, left: 16, right: 16),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Dismiss the dialog
                                      },
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        side: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Add space between buttons
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        userUploadedProductController
                                            .deleteProduct(
                                                id: "${product['_id']}")
                                            .then(
                                              (value) =>
                                                  userUploadedProductController
                                                      .loadUserUploadedProduct(),
                                            );

                                        Get.back();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                      ),
                                      child: const Text(
                                        "Confirm",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
