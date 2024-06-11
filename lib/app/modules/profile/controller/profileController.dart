import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isProfileEditOptionEnabled = false.obs;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  RxString userName = "Robert Nile".obs;

  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
}
