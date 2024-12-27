import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/controller/auth/register_screen_controller.dart';
import 'package:teamkhagrachari/presentation/screen/auth/login_screen.dart';
import '../../../data/upozila.dart';
import '../../controller/auth/login_controller.dart';
import '../../utils/color.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController upozilaController = TextEditingController();
  String bloodGroup = "";
  String upazila = "";
  LoginController controller = LoginController();



  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    upozilaController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: MyColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: nameController,
                        style: TextStyle(color: MyColors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyColors.secenderyColor,
                          focusedBorder: inputStyle(),
                          enabledBorder: inputStyle(),
                          labelText: 'নাম',
                          labelStyle: TextStyle(color: MyColors.white),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: MyColors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyColors.secenderyColor,
                          focusedBorder: inputStyle(),
                          enabledBorder: inputStyle(),
                          labelText: 'ইমেইল',
                          labelStyle: TextStyle(color: MyColors.white),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: phoneController,
                        style: TextStyle(color: MyColors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyColors.secenderyColor,
                          focusedBorder: inputStyle(),
                          enabledBorder: inputStyle(),
                          labelText: 'ফোন নাম্বার',
                          labelStyle: TextStyle(color: MyColors.white),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      GetBuilder<RegisterController>(builder: (controller) =>
                      controller.isDonor == true ?  DropdownButtonFormField<String>(
                        icon: const Icon(Icons.bloodtype,color: Colors.red,),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyColors.secenderyColor,
                          focusedBorder: inputStyle(),
                          enabledBorder: inputStyle(),
                          labelText: 'রক্তের গ্রুপ',
                          labelStyle: TextStyle(color: MyColors.white),
                        ),
                        dropdownColor: MyColors.secenderyColor,
                        style: TextStyle(color: MyColors.white),
                        items: bloodGroups.map((String group) {
                          return DropdownMenuItem<String>(
                            value: group,
                            child: Text(group),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            bloodGroup = newValue!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your blood group';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          bloodGroup = value!;
                        },
                      ) : const SizedBox()),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        icon: const Icon(Icons.location_on,color: Colors.green,),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyColors.secenderyColor,
                          focusedBorder: inputStyle(),
                          enabledBorder: inputStyle(),
                          labelText: 'উপজেলা',
                          labelStyle: TextStyle(color: MyColors.white),
                        ),
                        dropdownColor: MyColors.secenderyColor,
                        style: TextStyle(color: MyColors.white),
                        items: upozila.map((String group) {
                          return DropdownMenuItem<String>(
                            value: group,
                            child: Text(group),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            upazila = newValue!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your upazila';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          upazila = value!;
                        },
                      ),
                      const SizedBox(height: 15),
                      Obx(() => TextFormField(
                        obscureText: controller.obscurePassword.value,
                        controller: passwordController,
                        style: TextStyle(color: MyColors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyColors.secenderyColor,
                          focusedBorder: inputStyle(),
                          enabledBorder: inputStyle(),
                          labelText: 'নতুন পাসওয়ার্ড',
                          labelStyle: TextStyle(color: MyColors.white),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.obscurePassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: MyColors.white,
                            ),
                            onPressed: () {
                              controller.obscurePasswordChanger();
                            },
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      )),
                      const SizedBox(height: 15),
                       TextFormField(
                        controller: referController,
                        style: TextStyle(color: MyColors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyColors.secenderyColor,
                          focusedBorder: inputStyle(),
                          enabledBorder: inputStyle(),
                          labelText: 'রেফার কোড (Optional)',
                          labelStyle: TextStyle(color: MyColors.white),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 20),
                      GetBuilder<RegisterController>(
                          builder: (controller) => controller
                                      .isProgress.value ==
                                  false
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      controller
                                          .registerUser(
                                              email: emailController.text,
                                              password: passwordController.text,
                                              phone: phoneController.text,
                                              bloodGroup: bloodGroup,
                                              upazila: upazila,
                                              name: nameController.text,
                                          sponsor: referController.text)
                                          .then(
                                        (value) async {
                                          if (value == true) {
                                            Get.snackbar(
                                                backgroundColor: Colors.green.shade500,
                                                "Success", "Registration Successful");
                                            Get.offAll(
                                                () => const LoginScreen());
                                          }
                                        },
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              : const CircularProgressIndicator()),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "আপনার কি ইতিমধ্যে একাউন্ট আছে?",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () => Get.offAll(() => const LoginScreen()),
                            child: const Text(
                              "লগইন করুন",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 70),
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
        borderSide: BorderSide(
          color: MyColors.white,
        ),
      );
}
