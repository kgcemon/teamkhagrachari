import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/upozila.dart';
import '../../../data/model/profile_model.dart';
import '../../controller/auth/login_controller.dart';
import '../../controller/profile_screen_controller.dart';
import '../../controller/user_profile_update_controller.dart';
import '../../utils/color.dart';

class ProfileUpdateScreen extends StatefulWidget {
  final ProfileModel profileData;

  const ProfileUpdateScreen({super.key, required this.profileData});

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

  @override
  void initState() {
    nameController.text = widget.profileData.data!.name.toString();
    emailController.text = widget.profileData.data!.email.toString();
    phoneController.text = widget.profileData.data!.phone.toString();
    upozilaController.text = widget.profileData.data!.upazila.toString();
    dateController.text = widget.profileData.data!.lastDonateDate.toString();
    bloodGroup = widget.profileData.data!.bloodGroup.toString();
    upazila = widget.profileData.data!.upazila.toString();
    Get.find<UserProfileUpdateController>().isDonor =
        bool.parse(widget.profileData.data!.isDonor.toString());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    upozilaController.dispose();
    dateController.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Profile",
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
                        enabled: false,
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
                          if (value!.isEmpty ||
                              value.length < 9 ||
                              value.length > 14) {
                            return 'আপনার ফোন নাম্বার সঠিক নয়';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
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
                            icon: Icon(Icons.calendar_today,
                                color: MyColors.white),
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
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        icon: const Icon(
                          Icons.bloodtype,
                          color: Colors.red,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyColors.secenderyColor,
                          focusedBorder: inputStyle(),
                          enabledBorder: inputStyle(),
                          labelText: bloodGroup,
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
                        onSaved: (value) {
                          bloodGroup = value!;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "আপনি কি রক্ত দানে আগ্রহি?",
                            style: TextStyle(color: Colors.white),
                          ),
                          GetBuilder<UserProfileUpdateController>(
                            builder: (controller) => Checkbox(
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.white)),
                              value: controller.isDonor,
                              onChanged: (value) {
                                controller.setDonorStatus(value!);
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        icon: const Icon(
                          Icons.location_on,
                          color: Colors.green,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: MyColors.secenderyColor,
                          focusedBorder: inputStyle(),
                          enabledBorder: inputStyle(),
                          labelText: upozilaController.text,
                          labelStyle: TextStyle(color: MyColors.white),
                        ),
                        dropdownColor: MyColors.secenderyColor,
                        style: TextStyle(color: MyColors.white),
                        items: [
                          'খাগড়াছড়ি সদর',
                          'পানছড়ি',
                          'মাটিরাঙ্গা',
                          'দীঘিনালা',
                          'মানিকছড়ি',
                          'লক্ষীছড়ি',
                          'মহালছড়ি',
                          'গুইমারা',
                          'রামগড়'
                        ].map((String group) {
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
                        onSaved: (value) {
                          upazila = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      GetBuilder<UserProfileUpdateController>(
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
                                          .getUserProfileUpdate(
                                              userid: widget
                                                      .profileData.data!.sId ??
                                                  "",
                                              email: emailController.text,
                                              phone: phoneController.text,
                                              bloodGroup: bloodGroup,
                                              upazila: upazila,
                                              name: nameController.text,
                                              lastDonateDate:
                                                  dateController.text)
                                          .then((value) async {
                                        if (value == true) {
                                          Get.back();
                                          Get.snackbar(
                                              backgroundColor:
                                                  Colors.green.shade500,
                                              "Success",
                                              "Update Successful");
                                          Get.find<ProfileScreenController>()
                                              .getProfile();
                                        }
                                      });
                                    }
                                  },
                                  child: const Text(
                                    'Update Profile',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              : const CircularProgressIndicator()),
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
