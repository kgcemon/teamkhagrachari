import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/upozila.dart';
import '../../../data/model/profile_model.dart';
import '../../controller/auth/login_controller.dart';
import '../../controller/profile_screen_controller.dart';
import '../../controller/user_profile_update_controller.dart';
import '../../utils/color.dart';

class ProfileUpdateScreen extends StatefulWidget {
  final ProfileModel profileData;

  const ProfileUpdateScreen({Key? key, required this.profileData}) : super(key: key);

  @override
  ProfileUpdateScreenState createState() => ProfileUpdateScreenState();
}

class ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController upozilaController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String bloodGroup = '';
  String upazila = '';
  LoginController controller = LoginController();
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    nameController.text = widget.profileData.data!.name ?? '';
    emailController.text = widget.profileData.data!.email ?? '';
    phoneController.text = widget.profileData.data!.phone ?? '';
    upozilaController.text = widget.profileData.data!.upazila ?? '';
    dateController.text = widget.profileData.data!.lastDonateDate ?? '';
    bloodGroup = widget.profileData.data!.bloodGroup ?? '';
    upazila = widget.profileData.data!.upazila ?? '';
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    upozilaController.dispose();
    dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateController.text.isNotEmpty
          ? DateTime.parse(dateController.text)
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme:
            ColorScheme.light(primary: MyColors.primaryColor),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        dateController.text = picked.toLocal().toIso8601String().split('T')[0];
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: _pickImage,
      child: Hero(
        tag: "emon",
        child: Stack(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: MyColors.secenderyColor,
              backgroundImage: _imageFile != null
                  ? FileImage(_imageFile!)
                  : (widget.profileData.data!.image != null &&
                  widget.profileData.data!.image!.isNotEmpty)
                  ? NetworkImage(widget.profileData.data!.image!)
              as ImageProvider
                  : null,
              child: (_imageFile == null &&
                  (widget.profileData.data!.image == null ||
                      widget.profileData.data!.image!.isEmpty))
                  ? Icon(
                Icons.camera_alt,
                color: MyColors.white,
                size: 50,
              )
                  : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: MyColors.primaryColor, width: 2),
                ),
                child:  Icon(
                  Icons.camera_alt,
                  color: MyColors.primaryColor,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTextField(TextEditingController controller, String labelText,
      String validationMessage,
      {TextInputType keyboardType = TextInputType.text,
        bool enabled = true}) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: MyColors.white),
      keyboardType: keyboardType,
      enabled: enabled,
      decoration: InputDecoration(
        filled: true,
        fillColor: MyColors.secenderyColor,
        focusedBorder: inputStyle(),
        enabledBorder: inputStyle(),
        labelText: labelText,
        labelStyle: TextStyle(color: MyColors.white),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        if (keyboardType == TextInputType.phone &&
            (value.length < 9 || value.length > 14)) {
          return validationMessage;
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField(
      String labelText,
      List<String> items,
      String currentValue,
      IconData icon,
      ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: currentValue.isNotEmpty ? currentValue : null,
      icon: Icon(icon, color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: MyColors.secenderyColor,
        focusedBorder: inputStyle(),
        enabledBorder: inputStyle(),
        labelText: labelText,
        labelStyle: TextStyle(color: MyColors.white),
      ),
      dropdownColor: MyColors.secenderyColor,
      style: TextStyle(color: MyColors.white),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: TextStyle(color: MyColors.white)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: dateController,
      style: TextStyle(color: MyColors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: MyColors.secenderyColor,
        focusedBorder: inputStyle(),
        enabledBorder: inputStyle(),
        labelText: 'সর্বশেষ রক্তদানের তারিখ',
        labelStyle: TextStyle(color: MyColors.white),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today, color: MyColors.white),
          onPressed: () {
            _selectDate(context);
          },
        ),
      ),
      readOnly: true,
      onTap: () {
        _selectDate(context);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please select date';
        }
        return null;
      },
    );
  }

  Widget _buildDonorCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "আপনি কি রক্ত দানে আগ্রহী?",
          style: TextStyle(color: Colors.white),
        ),
        GetBuilder<UserProfileUpdateController>(
          builder: (controller) => Checkbox(
            fillColor: const WidgetStatePropertyAll(Colors.white),
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
            value: controller.isDonor,
            onChanged: (value) {
              controller.setDonorStatus(value!);
              setState(() {});
            },
            activeColor: MyColors.secenderyColor,
            checkColor: Colors.green,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder inputStyle() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      color: MyColors.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Profile",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: MyColors.primaryColor,
      ),
      backgroundColor: MyColors.primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              _buildProfileImage(),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                        nameController, 'নাম', 'Please enter your name'),
                    const SizedBox(height: 15),
                    _buildTextField(emailController, 'ইমেইল',
                        'Please enter your email',
                        enabled: false),
                    const SizedBox(height: 15),
                    _buildTextField(phoneController, 'ফোন নাম্বার',
                        'আপনার ফোন নাম্বার সঠিক নয়',
                        keyboardType: TextInputType.phone),
                    const SizedBox(height: 20),
                    _buildDropdownField(
                      'উপজেলা',
                      [
                        'খাগড়াছড়ি সদর',
                        'পানছড়ি',
                        'মাটিরাঙ্গা',
                        'দীঘিনালা',
                        'মানিকছড়ি',
                        'লক্ষীছড়ি',
                        'মহালছড়ি',
                        'গুইমারা',
                        'রামগড়'
                      ],
                      upazila,
                      Icons.location_on,
                          (value) => setState(() => upazila = value ?? ''),
                    ),
                    _buildDonorCheckbox(),
                    const SizedBox(height: 15),
                    if (Get.find<UserProfileUpdateController>().isDonor) ...[
                      _buildDropdownField(
                        'রক্তের গ্রুপ',
                        bloodGroups,
                        bloodGroup,
                        Icons.bloodtype,
                            (value) => setState(() => bloodGroup = value ?? ''),
                      ),
                      const SizedBox(height: 15),
                      _buildDateField(),
                    ],
                    const SizedBox(height: 20),
                    GetBuilder<UserProfileUpdateController>(
                      builder: (controller) =>
                      controller.isProgress.value == false
                          ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller
                                .getUserProfileUpdate(
                              userid: widget.profileData.data!.sId ??
                                  "",
                              email: emailController.text,
                              phone: phoneController.text,
                              bloodGroup: bloodGroup,
                              upazila: upazila,
                              name: nameController.text,
                              lastDonateDate: dateController.text,
                              profileImage: _imageFile,
                            )
                                .then((value) async {
                              if (value == true) {
                                Get.back();
                                Get.snackbar(
                                  "Success",
                                  "Update Successful",
                                  backgroundColor:
                                  Colors.green.shade500,
                                  colorText: Colors.white,
                                );
                                Get.find<ProfileScreenController>()
                                    .getProfile();
                              }
                            });
                          }
                        },
                        child: const Text(
                          'Update Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                          : const CircularProgressIndicator(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
