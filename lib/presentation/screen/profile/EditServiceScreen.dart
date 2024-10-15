import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/widget/global/myappbar.dart';

import '../../controller/EditServiceController.dart';
import '../../controller/user_profile__seba_controller.dart';

class EditServiceScreen extends StatelessWidget {
  final String serviceId;
  final String initialServiceProviderName;
  final String initialAddressDegree;
  final String initialDescription;

  const EditServiceScreen({
    Key? key,
    required this.serviceId,
    required this.initialServiceProviderName,
    required this.initialAddressDegree,
    required this.initialDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditServiceController controller = Get.put(EditServiceController());
    controller.initializeFields(
      serviceProviderName: initialServiceProviderName,
      addressDegree: initialAddressDegree,
      description: initialDescription,
    );

    // Reference to UserProfileSebaController to refresh data after update
    final UserProfileSebaController userProfileSebaController = Get.find<UserProfileSebaController>();

    // Form Key for validation
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: myAppbar(name: "Edit Service"),
      body: Obx(() {
        // Display loading indicator while updating
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, // Assign the form key
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16.0),

                  // Service Provider Name Field
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    initialValue: controller.serviceProviderName.value,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.white),
                      labelText: 'ব্যক্তি/প্রতিষ্ঠানের নাম/টাইটেল',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onChanged: (value) => controller.serviceProviderName.value = value,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Service provider name is required.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  // Address/Degree Field
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    initialValue: controller.addressDegree.value,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.white),
                      labelText: 'Address/Degree',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    onChanged: (value) => controller.addressDegree.value = value,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Address/Degree is required.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  // Description Field
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    initialValue: controller.description.value,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.white),
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    maxLines: 5,
                    onChanged: (value) => controller.description.value = value,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Description is required.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),

                  // Update Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      backgroundColor: Colors.teal,
                      textStyle: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      // Validate the form
                      if (_formKey.currentState!.validate()) {
                        // Attempt to update the service
                        bool success = await controller.updateService(serviceId);
                        if (success) {
                          // Refresh the service list
                          userProfileSebaController.getLoadUserSeba();

                          // Navigate back to the previous screen
                          Get.back();
                        } else {
                          // Show error message
                          Get.snackbar(
                            'Error',
                            controller.errorMessage.value,
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red.withOpacity(0.7),
                            colorText: Colors.white,
                            borderRadius: 8.0,
                            margin: const EdgeInsets.all(16.0),
                          );
                        }
                      }
                    },
                    child: const Text('Update Service',style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
