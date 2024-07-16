import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/data/model/CategoryModel.dart';
import 'package:teamkhagrachari/presentation/controller/add_user_service_controller.dart';
import 'package:teamkhagrachari/presentation/controller/home_screen_controller.dart';
import 'package:teamkhagrachari/presentation/screen/main_nav_screen.dart';
import 'package:teamkhagrachari/presentation/utils/color.dart';

class AddUserServiceScreen extends StatefulWidget {
  const AddUserServiceScreen({super.key});

  @override
  AddUserServiceScreenState createState() => AddUserServiceScreenState();
}

class AddUserServiceScreenState extends State<AddUserServiceScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController addressDegreeController = TextEditingController();
  TextEditingController serviceInfoController = TextEditingController();
  String categoryID = '';
  String upazila = '';
  List<String> categoryList = [];
  List<CategoryModel> list = Get.find<HomeScreenController>().category;

  final AddUserServiceController _controller =
      Get.find<AddUserServiceController>();

  @override
  void initState() {
    super.initState();
    addCategory();
  }

  addCategory() {
    for (var element in list) {
      categoryList.add(element.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "আপনার সেবা যোগ করুন",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: MyColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        iconDisabledColor: Colors.white,
                        iconEnabledColor: Colors.white,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.13),
                          focusedBorder: inputStyle(),
                          enabledBorder: inputStyle(),
                          labelText: 'সার্ভিস ক্যাটাগরি',
                          labelStyle: TextStyle(color: MyColors.white),
                        ),
                        dropdownColor: MyColors.secenderyColor,
                        style: TextStyle(color: MyColors.white),
                        items: categoryList.map((String group) {
                          return DropdownMenuItem<String>(
                            value: group,
                            child: Text(group),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            var matchingElement = list.firstWhere(
                                (element) => element.name == newValue);
                            categoryID = matchingElement.id;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your category';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: addressDegreeController,
                        style: TextStyle(color: MyColors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.13),
                          focusedBorder: inputStyle(),
                          enabledBorder: inputStyle(),
                          labelText: 'ঠিকানা/ডিগ্রি',
                          labelStyle: TextStyle(color: MyColors.white),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        maxLines: 5,
                        controller: serviceInfoController,
                        style: TextStyle(color: MyColors.white),
                        decoration: InputDecoration(
                          labelText: "আপনার সেবার বিবরণ লিখুন",
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.13),
                          focusedBorder: inputStyle(),
                          enabledBorder: inputStyle(),
                          labelStyle: TextStyle(color: MyColors.white),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your service description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      GetBuilder<AddUserServiceController>(
                        builder: (controller) => controller.isProgress == false
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.white.withOpacity(0.65),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _controller
                                          .addUserServices(
                                              addressDegree:
                                                  addressDegreeController.text,
                                              description:
                                                  serviceInfoController.text,
                                              categoryID: categoryID)
                                          .then(
                                        (value) {
                                          if (value['success'] == true) {
                                            Get.snackbar(
                                                backgroundColor: Colors.green,
                                                colorText: Colors.white,
                                                "ধন্যবাদ",
                                                "আপনার সেবাটি পেন্ডিং রয়েছে। অ্যাপ্রুভের জন্যে অপেক্ষা করুন");
                                            Get.offAll(() =>
                                                const MainNavScreen(
                                                    title: "Khagrachari Plus"));
                                          } else {
                                            Get.snackbar(
                                                "Error", value['message']);
                                          }
                                        },
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'সেবা যুক্ত করুন',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              )
                            : const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder inputStyle() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      );

  @override
  void dispose() {
    addressDegreeController.dispose();
    serviceInfoController.dispose();
    super.dispose();
  }
}
