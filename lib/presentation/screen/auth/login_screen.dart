import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teamkhagrachari/presentation/screen/auth/register_screen.dart';
import '../../controller/auth/login_controller.dart';
import '../../controller/main_bottom_nav_bar_controller.dart';
import '../../utils/assets_path.dart';
import '../../utils/color.dart';
import '../main_nav_screen.dart';
// ... other imports ...

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final LoginController controller = Get.put(LoginController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          {
            Get.find<NavButtonControllerController>().selectedIndex = 0;
            Get.offAll(() => const MainNavScreen(title: "Khagrachari Plus"));
            return false;
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                _buildHeaderSection(),
                const SizedBox(height: 40),
                _buildLoginForm(),
                const SizedBox(height: 24),
                _buildFooterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      children: [
        Image.asset(
          AssetPath.mainLogoPNG,
          height: 150,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 20),
        const Text(
          'লগ ইন করুন',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
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
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 24),
              _buildLoginButton(),
              const SizedBox(height: 16),
              _buildForgotPasswordButton(),
            ],
          ),
        ),
      ),
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      validator: (value) => value!.isEmpty ? 'ইমেইল লিখুন' : null,
    );
  }

  Widget _buildPasswordField() {
    return Obx(() => TextFormField(
          controller: passwordController,
          obscureText: controller.obscurePassword.value,
          decoration: InputDecoration(
            labelText: 'পাসওয়ার্ড',
            prefixIcon: Icon(Icons.lock, color: MyColors.primaryColor),
            suffixIcon: IconButton(
              icon: Icon(
                controller.obscurePassword.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: controller.obscurePasswordChanger,
            ),
            border: OutlineInputBorder(
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

  Widget _buildLoginButton() {
    return Obx(() => controller.isProgress.value
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primaryColor,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 3,
            ),
            child: const Text(
              'লগ ইন',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ));
  }

  Widget _buildForgotPasswordButton() {
    return Column(
      children: [
        TextButton(
          onPressed: () => _showForgotPasswordDialog(),
          child: Text(
            'পাসওয়ার্ড ভুলে গেছেন?',
            style: TextStyle(
              color: MyColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        _buildGoogleSignInButton(controller),
      ],
    );
  }

  Widget _buildFooterSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'নতুন একাউন্ট তৈরি করুন? ',
          style: TextStyle(color: Colors.white.withOpacity(0.9)),
        ),
        GestureDetector(
          onTap: () => Get.offAll(() => const RegistrationScreen()),
          child: const Text(
            'রেজিস্ট্রেশন',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      controller
          .userLogin(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((success) {
        if (success) {
          Get.offAll(() => const MainNavScreen(title: 'Khagrachari Plus'));
          Get.find<NavButtonControllerController>().selectedIndex = 2;
        }
      });
    }
  }

  Widget _buildGoogleSignInButton(LoginController loginController) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {
          controller.googleSignIn();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: Image.network(
            'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
            height: 24), // Ensure you add a Google logo in your assets
        label: const Text(
          'Sign in with Google',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 300, maxWidth: 400),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'পাসওয়ার্ড রিসেট',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: MyColors.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'আপনার ইমেইল ঠিকানা লিখুন, আমরা রিসেট লিংক পাঠাবো',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 60, // Fixed height for text field
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'ইমেইল',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: Get.back,
                      child: const Text('বাতিল'),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      // Constrained button width
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {
                          if (emailController.text.isEmail) {
                            controller.forgetPassApiCall(
                                email: emailController.text);
                            Get.back();
                          } else {
                            Get.snackbar(
                              'ত্রুটি',
                              'সঠিক ইমেইল ঠিকানা লিখুন',
                              backgroundColor: Colors.red[200],
                            );
                          }
                        },
                        child: const Text('পাঠান'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
