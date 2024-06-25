import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/controller/auth/login_controller.dart';
import 'package:teamkhagrachari/presentation/screen/auth/register_screen.dart';
import 'package:teamkhagrachari/presentation/screen/main_nav_screen.dart';
import '../../controller/main_bottom_nav_bar_controller.dart';
import '../../controller/profile_screen_controller.dart';
import '../../utils/color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String phoneNumber = '';
  String bloodGroup = '';
  String upazila = '';

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  LoginController controller = LoginController();

  final List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: MyColors.primaryColor,
      body: WillPopScope(
        onWillPop: () async {
          Get.find<NavButtonControllerController>().selectedIndex = 0;
          Get.offAll(() => const MainNavScreen(title: "Khagrachari Plus"));
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Text(
                  'লগ ইন করুন',
                  style: TextStyle(
                    color: MyColors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  style: TextStyle(color: MyColors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: MyColors.secenderyColor,
                    focusedBorder: inputStyle(),
                    enabledBorder: inputStyle(),
                    labelText: 'ইমেইল',
                    labelStyle: TextStyle(color: MyColors.white),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    phoneNumber = value!;
                  },
                ),
                const SizedBox(height: 15),
                Obx(() => TextFormField(
                  controller: passwordController,
                  style: TextStyle(color: MyColors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: MyColors.secenderyColor,
                    focusedBorder: inputStyle(),
                    enabledBorder: inputStyle(),
                    labelText: 'পাসওয়ার্ড',
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
                  obscureText: controller.obscurePassword.value,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    phoneNumber = value!;
                  },
                ),),
                const SizedBox(height: 20),
                Obx(() => controller.isProgress.value == true
                    ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
                    : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      controller
                          .userLogin(
                        email: emailController.text,
                        password: passwordController.text,
                      )
                          .then(
                            (value) async {
                          if (value == true) {
                            Get.snackbar(
                                backgroundColor: Colors.green.shade500,
                                "Success", "Login Successful");
                            await Get.find<ProfileScreenController>()
                                .getProfile();
                            Get.offAll(() => const MainNavScreen(
                              title: 'Khagrachari Plus',
                            ));
                            Get.find<NavButtonControllerController>()
                                .selectedIndex = 2;
                          }
                        },
                      );
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.black),
                  ),
                )),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "নতুন একাউন্ট করতে চান?",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () => Get.offAll(() => const RegistrationScreen()),
                      child: const Text(
                        "রেজিস্ট্রেশন করুন ",
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
