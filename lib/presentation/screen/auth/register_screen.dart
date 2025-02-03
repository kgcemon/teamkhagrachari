import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/upozila.dart';
import '../../controller/auth/login_controller.dart';
import '../../controller/auth/register_screen_controller.dart';
import '../../utils/assets_path.dart';
import '../../utils/color.dart';
import 'login_screen.dart';
// ... other imports ...

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final RegisterController registerController = Get.put(RegisterController());
  final LoginController loginController = Get.put(LoginController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController referController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String bloodGroup = "";
  String upazila = "";

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    referController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              MyColors.primaryColor,
              MyColors.secenderyColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 16,),
                _buildHeaderSection(),
                const SizedBox(height: 22),
                _buildRegistrationForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return const Text(
      'নতুন একাউন্ট তৈরি করুন',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildNameField(),
              const SizedBox(height: 16),
              _buildEmailField(),
              const SizedBox(height: 16),
              _buildPhoneField(),
              const SizedBox(height: 16),
              _buildBloodGroupDropdown(),
              const SizedBox(height: 16),
              _buildUpazilaDropdown(),
              const SizedBox(height: 16),
              _buildPasswordField(),
              const SizedBox(height: 16),
              _buildReferralField(),
              const SizedBox(height: 24),
              _buildRegisterButton(),
              const SizedBox(height: 16),
              _buildLoginLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        labelText: 'নাম (বাংলায়)',
        prefixIcon: Icon(Icons.person, color: MyColors.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      validator: (value) => value!.isEmpty ? 'নাম লিখুন' : null,
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'ইমেইল',
        prefixIcon: Icon(Icons.email, color: MyColors.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),

      ),
      validator: (value) => value!.isEmpty ? 'ইমেইল লিখুন' : null,
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'মোবাইল নাম্বার',
        prefixIcon: Icon(Icons.phone, color: MyColors.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      validator: (value) => value!.isEmpty ? 'মোবাইল নাম্বার লিখুন' : null,
    );
  }

  Widget _buildBloodGroupDropdown() {
    return GetBuilder<RegisterController>(
      builder: (controller) => controller.isDonor
          ? DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'রক্তের গ্রুপ',
          prefixIcon: Icon(Icons.bloodtype, color: MyColors.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        items: bloodGroups.map((String group) {
          return DropdownMenuItem<String>(
            value: group,
            child: Text(group),
          );
        }).toList(),
        onChanged: (value) => bloodGroup = value!,
        validator: (value) =>
        value == null ? 'রক্তের গ্রুপ নির্বাচন করুন' : null,
      )
          : const SizedBox(),
    );
  }

  Widget _buildUpazilaDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'উপজেলা',
        prefixIcon: Icon(Icons.location_on, color: MyColors.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      items: upozila.map((String group) {
        return DropdownMenuItem<String>(
          value: group,
          child: Text(group),
        );
      }).toList(),
      onChanged: (value) => upazila = value!,
      validator: (value) => value == null ? 'উপজেলা নির্বাচন করুন' : null,
    );
  }

  Widget _buildPasswordField() {
    return Obx(() => TextFormField(
      controller: passwordController,
      obscureText: loginController.obscurePassword.value,
      decoration: InputDecoration(
        labelText: 'পাসওয়ার্ড',
        prefixIcon: Icon(Icons.lock, color: MyColors.primaryColor),
        suffixIcon: IconButton(
          icon: Icon(
            loginController.obscurePassword.value
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: loginController.obscurePasswordChanger,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      validator: (value) => value!.isEmpty ? 'পাসওয়ার্ড লিখুন' : null,
    ));
  }

  Widget _buildReferralField() {
    return TextFormField(
      controller: referController,
      decoration: InputDecoration(
        labelText: 'রেফার কোড (ঐচ্ছিক)',
        prefixIcon: Icon(Icons.card_giftcard, color: MyColors.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return GetBuilder<RegisterController>(
      builder: (controller) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _handleRegistration,
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: controller.isProgress.value
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
            'রেজিস্ট্রেশন সম্পন্ন করুন',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ইতিমধ্যে একাউন্ট আছে? ',
          style: TextStyle(color: Colors.grey.shade600),
        ),
        TextButton(
          onPressed: () => Get.offAll(() => const LoginScreen()),
          child: Text(
            'লগইন করুন',
            style: TextStyle(
              color: MyColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _handleRegistration() {
    if (_formKey.currentState!.validate()) {
      registerController.registerUser(
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text,
        bloodGroup: bloodGroup,
        upazila: upazila,
        name: nameController.text,
        sponsor: referController.text,
      );
    }
  }
}