import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPassChangeScreen extends StatefulWidget {
  const ForgotPassChangeScreen({super.key});

  @override
  _ForgotPassChangeScreenState createState() => _ForgotPassChangeScreenState();
}

class _ForgotPassChangeScreenState extends State<ForgotPassChangeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false; // For loading state

  @override
  void dispose() {
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Function to call the reset password API
  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('https://api.khagrachariplus.com/api/v1/auth/reset-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'newPassword': _passwordController.text,
        'code': _codeController.text,
      }),
    );

    setState(() {
      _isLoading = false;
    });

    print(response.body);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      // Handle successful response12232
      Navigator.pop(context); // Optionally, navigate back after success
      Navigator.pop(context); // Optionally, navigate back after success
      Get.snackbar(backgroundColor: Colors.green,"ধন্যবাদ", "আপনার পাসওয়ার্ড সফলভাবে পরিবর্তন হয়েছে। অনুগ্রহ করে লগইন করুন। ধন্যবাদ। ");
    } else {
      // Handle error response
      final responseBody = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${responseBody['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Forget Password",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Code TextFormField
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: "Code",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Password TextFormField
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Confirm Password TextFormField
              TextFormField(
                style: const TextStyle(color: Colors.white),
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: _isLoading
                      ? null
                      : () {
                    _resetPassword();
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Submit",style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
