import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trans_cash_solution/app/modules/auth/models/registration_model.dart';
import 'package:trans_cash_solution/app/modules/home/controller/home_controller.dart';
import 'package:trans_cash_solution/model/otp_verification_model.dart';
import '../../../../Store/HiveStore.dart';
import '../../../../apiService/AuthServices.dart';
import '../../../../common/device_manager/global_constants.dart';
import '../../../../common/ui.dart';
import '../../../../common/widgets/phone_field_widget.dart';
import '../../../../model/forget_password_resend_otp_model.dart';
import '../../../../model/forget_password_reset_model.dart';
import '../../../../model/otp_sent_for_forget_password_model.dart';
import '../../../../model/update_current_password_model.dart';
import '../../../../model/verify_register_resend_otp_model.dart';
import '../../../routes/app_routes.dart';
import '../models/logIn_model.dart';
import '../views/otp_verification_view.dart';

class AuthController extends GetxController {
  //Text Editing Controllers
  //For Login Page
  TextEditingController passwordLogInTextController = TextEditingController();
  TextEditingController emailLogInTextController = TextEditingController();

  //For Registration Page
  TextEditingController fullNameRegistrationController =
      TextEditingController();
  TextEditingController emailRegistrationController = TextEditingController();
  TextEditingController mobileRegistrationController = TextEditingController();
  TextEditingController passwordRegistrationController =
      TextEditingController();
  TextEditingController confirmPasswordRegistrationController =
      TextEditingController();
  RxBool registrationCheckBox = false.obs;

  //For Forgot Password Page
  TextEditingController emailForForgotPasswordController =
      TextEditingController();
  TextEditingController phoneForForgotPasswordController =
      TextEditingController();

  //For OTP Verification Page
  TextEditingController otpVerificationController = TextEditingController();

  //For New Password Page
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  //For Change Password Page
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController enterNewPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  //For Change Password Page
  //All Variables
  RxString email = "".obs;
  RxBool isResetPasswordWithMobileNumber = false.obs;
  RxBool isCurrentPasswordFieldEnabled = false.obs;
  RxBool isTopCurrentPasswordEnabled = false.obs;
  RxBool isTopWidgetEnabled = false.obs;
  RxString phoneNumber = " +91 9848984898".obs;
  RxString authToken = "".obs;
  RxBool isLoading = false.obs;
  final AuthService _authService = AuthService();

  //For timer
  Rx<int> secondsRemaining = 0.obs;
  Rx<bool> enableResend = false.obs;
  Timer? timer;

  //Global Keys

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> newPasswordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> forgotPasswordForUpdatePasswordFormKey =
      GlobalKey<FormState>();
  GlobalKey<FormState> otpVerificationFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    var arguments = Get.arguments;
    if(arguments != null){
      email.value = arguments["email"];
    }
    super.onInit();
  }

  addTimer() {
    secondsRemaining.value = 30;
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
      }
    });
  }

  void resendCode() {
    addTimer();
    secondsRemaining.value = 30;
    enableResend.value = false;
  }


  @override
  dispose() {
    timer!.cancel();
    super.dispose();
  }

// AuthController() {
//   _authService = AuthService();
// }

//
// @override
// Future<void> onInit() async {
//   super.onInit();
// }
//
// void setSelected(String value) {
//   selected.value = value;
// }
//


//Login
  void login() async {
    Get.focusScope?.unfocus();
    if (emailLogInTextController.text.isNotEmpty &&
        passwordLogInTextController.text.length.isGreaterThan(7)) {
      if (loginFormKey.currentState!.validate()) {
        isLoading.value = true;
        loginFormKey.currentState?.save();
        LogInModel loginModel = await _authService.login(
          email: emailLogInTextController.text,
          password: passwordLogInTextController.text,
          deviceToken: HiveStore().getString(Keys.FCMTOKEN)
        );
        if (loginModel.status == 200) {
          emailLogInTextController.text = "";
          passwordLogInTextController.text = "";
          HiveStore().setString(
              Keys.TOKEN, "Bearer ${loginModel.data!.accessToken.toString()}");
          HiveStore().setBool("isLoggedIn", true);
          loggedIn = true;
          isLoading.value = false;
          setStoredValue(
              loginModel.data!.name.toString(),
              loginModel.data!.email.toString(),
              loginModel.data!.phone.toString(),
              loginModel.data!.profileImage.toString(),
              loginModel.data!.countryCode.toString());
          Get.toNamed(Routes.HOME);
        } else if (loginModel.status == 401) {
          isLoading.value = false;
          Get.showSnackbar(Ui.ErrorSnackBar(message: loginModel.longMessage));
        } else if (loginModel.status == 202) {
          HiveStore()
              .setString(Keys.USEREMAIL, loginModel.data!.email.toString());
          authToken.value = "Bearer ${loginModel.data!.accessToken!}";
          setStoredValue(
              loginModel.data!.name.toString(),
              loginModel.data!.email.toString(),
              loginModel.data!.phone.toString(),
              loginModel.data!.profileImage.toString(),
              loginModel.data!.countryCode.toString());
          addTimer();
          isLoading.value = false;
          Get.offAllNamed(Routes.OTPVERIFICATION,arguments: {"email" : emailLogInTextController.text});
          onInit();
          Get.showSnackbar(Ui.ErrorSnackBar(message: loginModel.longMessage));
        }
      }
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "Fields are empty",
          message: "Email & password field is required."));
    }
  }

  //Set data's in HiveStore
  setStoredValue(String name, String email, String mobile, String profileImage,
      String countryCode) async {
    HiveStore().setString(Keys.USERNAME, name);
    HiveStore().setString(Keys.USEREMAIL, email);
    HiveStore().setString(Keys.USEREPROFILEIMAGE, profileImage);
    HiveStore().setString(Keys.USERMOBILE, mobile);
    HiveStore().setString(Keys.COUNTRYCODE, countryCode);
  }

//Forgot Password
// void forgotPassword() async {
//   Get.focusScope.unfocus();
//   GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
//   if(emailTextController.text.isEmpty){
//     forgotPasswordFormKey = forgotPasswordFormPhoneKey;
//   }else{
//     forgotPasswordFormKey = forgotPasswordFormEmailKey;
//   }
//   if (forgotPasswordFormKey.currentState.validate()) {
//     forgotPasswordFormKey.currentState.save();
//     loading.value = true;
//     _authService.forgotPassword(
//         email: emailTextController.text,
//         phoneNumber: phoneNumberTextController.text);
//     loading.value = false;
//   }
// }
//
  void register() async {
    Get.focusScope!.unfocus();
    if (registerFormKey.currentState!.validate()) {
      isLoading.value = true;
      registerFormKey.currentState!.save();
      if (fullNameRegistrationController.text.isNotEmpty &&
          emailRegistrationController.text.isNotEmpty &&
          mobileRegistrationController.text.length.isGreaterThan(5) &&
          passwordRegistrationController.text.isNotEmpty &&
          passwordRegistrationController.text.isNotEmpty &&
          confirmPasswordRegistrationController.text.isNotEmpty) {
        if (passwordRegistrationController.text ==
            confirmPasswordRegistrationController.text) {
          if (registerFormKey.currentState!.validate() &&
              registrationCheckBox.value == true) {
            isLoading.value = true;
            loginFormKey.currentState?.save();
            RegistrationModel registrationModel = await _authService.registerUser(
                name: fullNameRegistrationController.text,
                email: emailRegistrationController.text,
                password: passwordRegistrationController.text,
                confirmPassword: confirmPasswordRegistrationController.text,
                phone: getPhoneNumber(mobileRegistrationController.text).number,
                countryCode:
                    "+${getPhoneNumber(mobileRegistrationController.text).countryCode}");
            if (registrationModel.status == 200) {
              addTimer();
              debugPrint("Im in if");
              isLoading.value = false;
              authToken.value =
                  "Bearer ${registrationModel.data!.accessToken!}";
              HiveStore()
                  .setString(Keys.USEREMAIL, emailRegistrationController.text);
              Get.toNamed(Routes.OTPVERIFICATION,arguments: {"email" : emailRegistrationController.text});
              onInit();
            } else if (registrationModel.status == 202) {
              debugPrint("Im in else");
              isLoading.value = false;
              Get.showSnackbar(Ui.ErrorSnackBar(
                  title: "${registrationModel.shortMessage}",
                  message: "${registrationModel.longMessage}"));
            }
          } else {
            isLoading.value = false;
            Get.showSnackbar(Ui.ErrorSnackBar(
                title: "Agree with Terms & Conditions",
                message: "Tick the checkbox to Register."));
          }
        } else {
          isLoading.value = false;
          Get.showSnackbar(Ui.ErrorSnackBar(
              title: "Password mismatch",
              message: "Password & Confirm Password should be same!"));
        }
      } else {
        isLoading.value = false;
        Get.showSnackbar(Ui.ErrorSnackBar(
            title: "Fields are empty", message: "All fields is required."));
      }
    }
  }

//Reset Password

  void resetPassword() async {
    Get.focusScope?.unfocus();
    if (phoneForForgotPasswordController.text.isNotEmpty ||
        emailForForgotPasswordController.text.isNotEmpty) {
      if (forgotPasswordFormKey.currentState!.validate()) {
        isLoading.value = true;
        forgotPasswordFormKey.currentState?.save();
        if (emailForForgotPasswordController.text.isNotEmpty) {
          debugPrint("I am for email");
          OTPSentForForgetPasswordModel otpSentForForgetPasswordModel =
              await _authService.resetPassword(
            email: emailForForgotPasswordController.text,
            mobile: null,
          );
          if (otpSentForForgetPasswordModel.status == 200) {
            // emailForForgotPasswordController.text = "";
            // phoneForForgotPasswordController.text = "";
            authToken.value =
                "Bearer ${otpSentForForgetPasswordModel.data!.accessToken}";
            addTimer();
            isLoading.value = false;
            isTopWidgetEnabled.value = true;
            Get.toNamed(Routes.OTPVERIFICATION,arguments: {"email" : emailForForgotPasswordController.text});
            onInit();
          } else {
            isLoading.value = false;
            Get.showSnackbar(Ui.ErrorSnackBar(
                message: otpSentForForgetPasswordModel.longMessage));
            // Get.showSnackbar(Ui.ErrorSnackBar(
            //     title: "${otpSentForForgetPasswordModel.shortMessage}",
            //     message: "${otpSentForForgetPasswordModel.longMessage}"));
          }
        } else {
          debugPrint("I am for phone");
          OTPSentForForgetPasswordModel otpSentForForgetPasswordModel =
              await _authService.resetPassword(
                  mobile: phoneForForgotPasswordController.text, email: null);
          if (otpSentForForgetPasswordModel.status == 200) {
            isLoading.value = false;
            isTopWidgetEnabled.value = true;
            Get.toNamed(Routes.OTPVERIFICATION,arguments: {"email" : emailForForgotPasswordController.text});
            onInit();
          } else {
            isLoading.value = false;
            Get.showSnackbar(Ui.ErrorSnackBar(
                title: "${otpSentForForgetPasswordModel.shortMessage}",
                message: "${otpSentForForgetPasswordModel.longMessage}"));
          }
        }
      }
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "Fields are empty",
          message: "Email or phone number is required."));
    }
  }

//Forgot password reset password

  Future<void> verifyEmailForForgetPassword() async {
    if (otpVerificationController.text.isNotEmpty) {
      if (otpVerificationFormKey.currentState!.validate()) {
        isLoading.value = true;
        otpVerificationFormKey.currentState?.save();
        OTPVerificationModel otpVerificationModel =
            await _authService.forgetPasswordVerifyOTP(
                token: authToken.value, otp: otpVerificationController.text);
        if (otpVerificationModel.status == 200) {
          isLoading.value = false;
          isLoading.value = false;
          Get.toNamed(Routes.NEW_PASSWORD);
          Get.showSnackbar(Ui.SuccessSnackBar(
              title: "OTP Verification Successful",
              message: "You can reset password now."));
        } else {
          isLoading.value = false;
          Get.showSnackbar(Ui.ErrorSnackBar(
              title: "${otpVerificationModel.shortMessage}",
              message: "${otpVerificationModel.longMessage}"));
        }
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(
            title: "Something Went Wrong", message: "Try after some time"));
      }
    } else {
      isLoading.value = false;
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "Provide OTP", message: "Please enter a valid OTP"));
    }
  }

  //Verify email id

  Future<void> verifyEmail() async {
    isLoading.value = true;
    if (otpVerificationController.text.isNotEmpty) {
      if (otpVerificationFormKey.currentState!.validate()) {
        isLoading.value = true;
        otpVerificationFormKey.currentState?.save();
        OTPVerificationModel otpVerificationModel =
            await _authService.verifyOTP(
                token: authToken.value, otp: otpVerificationController.text);
        if (otpVerificationModel.status == 200) {
          isLoading.value = false;
          Get.offAllNamed(Routes.LOGIN);
          Get.showSnackbar(Ui.SuccessSnackBar(
              title: "OTP Verification Successful",
              message: "You can login now with your credential."));
        } else {
          isLoading.value = false;
          Get.showSnackbar(Ui.ErrorSnackBar(
              title: "${otpVerificationModel.shortMessage}",
              message: "${otpVerificationModel.longMessage}"));
        }
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(
            title: "Something Went Wrong", message: "Try after some time"));
      }
    } else {
      isLoading.value = false;
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "Provide OTP", message: "Please enter a valid OTP"));
    }
  }

  //Resend OTP for forgot password

  Future<void> resendOTPForgotPassword() async {
    isLoading.value = true;
    ForgetPasswordResendOTPModel forgetPasswordResendOTPModel =
        await _authService.forgotPasswordResendOTP(
            token: authToken.value,
            email: emailForForgotPasswordController.text);
    if (forgetPasswordResendOTPModel.status == 200) {
      enableResend.value = false;
      secondsRemaining.value = 0;
      addTimer();
      isLoading.value = false;
      Get.showSnackbar(Ui.SuccessSnackBar(
          title: "${forgetPasswordResendOTPModel.shortMessage}",
          message: "${forgetPasswordResendOTPModel.longMessage}"));
    } else {
      isLoading.value = false;
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "${forgetPasswordResendOTPModel.shortMessage}",
          message: "${forgetPasswordResendOTPModel.longMessage}"));
    }
  }

  //Resend OTP for forgot password

  Future<void> resendOTPForRegisterUser() async {
    isLoading.value = true;
    VerifyRegisterResendOtpModel verifyRegisterResendOtpModel =
        await _authService.registerResendOTP(
            token: authToken.value, email: emailRegistrationController.text);
    if (verifyRegisterResendOtpModel.status == 200) {
      enableResend.value = false;
      secondsRemaining.value = 0;
      addTimer();
      isLoading.value = false;
      Get.showSnackbar(Ui.SuccessSnackBar(
          title: "${verifyRegisterResendOtpModel.shortMessage}",
          message: "${verifyRegisterResendOtpModel.longMessage}"));
    } else {
      isLoading.value = false;
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "${verifyRegisterResendOtpModel.shortMessage}",
          message: "${verifyRegisterResendOtpModel.longMessage}"));
    }
  }

  //Change password after login

  void updateOldPassword() async {
    debugPrint("hello");
    Get.focusScope?.unfocus();
    if (currentPasswordController.text.isNotEmpty &&
        enterNewPasswordController.text.isNotEmpty &&
        confirmNewPasswordController.text.isNotEmpty) {
      if (forgotPasswordForUpdatePasswordFormKey.currentState!.validate()) {
        isLoading.value = true;
        forgotPasswordForUpdatePasswordFormKey.currentState?.save();
        if (enterNewPasswordController.text == confirmNewPasswordController.text) {
          UpdateCurrentPassword updateCurrentPassword =
              await _authService.updateCurrentPassword(
                  currentPassword: currentPasswordController.text,
                  newPassword: enterNewPasswordController.text,
                  confirmPassword: confirmNewPasswordController.text,
                  token: HiveStore().getString(Keys.TOKEN));
          if (updateCurrentPassword.status == 200) {
            isCurrentPasswordFieldEnabled.value = false;
            isTopCurrentPasswordEnabled.value = false;
            isLoading.value = false;
            currentPasswordController.text = "";
            enterNewPasswordController.text = "";
            confirmNewPasswordController.text = "";
            Get.back();
            Get.toNamed(Routes.PROFILE);
            Get.showSnackbar(Ui.SuccessSnackBar(
                title: "${updateCurrentPassword.shortMessage}",
                message: "${updateCurrentPassword.longMessage}"));
          } else {
            isLoading.value = false;
            Get.showSnackbar(Ui.ErrorSnackBar(
                title: "${updateCurrentPassword.shortMessage}",
                message: "${updateCurrentPassword.longMessage}"));
          }
        } else {
          isLoading.value = false;
          Get.showSnackbar(Ui.ErrorSnackBar(
              title: "Password Mismatched!",
              message: "New password and Confirm password should be same."));
        }
      }
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "Fields are empty", message: "All fields are required!"));
    }
  }

  //Forgot password and reset it

  void newPassword() async {
    Get.focusScope?.unfocus();
    if (newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      if (newPasswordFormKey.currentState!.validate()) {
        isLoading.value = true;
        newPasswordFormKey.currentState?.save();
        if (newPasswordController.text == confirmPasswordController.text) {
          ForgotPasswordResetModel forgotPasswordResetModel =
              await _authService.forgetPasswordReset(
                  password: newPasswordController.text, token: authToken.value);
          if (forgotPasswordResetModel.status == 200) {
            isLoading.value = false;
            Get.offAllNamed(Routes.LOGIN);
          } else {
            isLoading.value = false;
            Get.showSnackbar(Ui.ErrorSnackBar(
                title: "${forgotPasswordResetModel.shortMessage}",
                message: "${forgotPasswordResetModel.longMessage}"));
          }
        } else {
          Get.showSnackbar(Ui.ErrorSnackBar(
              title: "Password Mismatched!",
              message: "Password and Confirm password should be same."));
        }
      }
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "Fields are empty",
          message: "Email or phone number is required."));
    }
  }

// void registration() async {
//   Get.focusScope.unfocus();
//   if (salonFormKey.currentState.validate()) {
//     salonFormKey.currentState.save();
//     loading.value = true;
//     try {
//       dsc = Get.find<SettingsService>().address.value.description == null
//           ? Get.find<SettingsService>().address.value.address
//           : Get.find<SettingsService>().address.value.description;
//       add = Get.find<SettingsService>().address.value.address;
//       lat = Get.find<SettingsService>().address.value.latitude;
//       lng = Get.find<SettingsService>().address.value.longitude;
//       if (name.isEmpty ||
//           oldPhoneNum.completeNumber.isEmpty ||
//           oldMobileNum.completeNumber.isEmpty ||
//           availRange.isEmpty ||
//           lat.toString().isEmpty ||
//           lng.toString().isEmpty ||
//           add.toString().isEmpty ||
//           Uid.toString().isEmpty ||
//           dsc.isEmpty) {
//         Get.showSnackbar(Ui.ErrorSnackBar(
//             message:
//                 "There are errors in some fields please correct them!".tr));
//       } else {
//         bool status = await _userRepository.SalonSignUp(
//             name,
//             2,
//             oldPhoneNum.completeNumber,
//             oldMobileNum.completeNumber,
//             availRange,
//             lat,
//             lng,
//             add,
//             Uid,
//             dsc);
//         loading.value = false;
//         Get.find<AuthService>().user.value.address = Address(
//             address: add,
//             description: dsc,
//             latitude: lat,
//             longitude: lng,
//             userId: Uid,
//             isDefault: false);
//         await Get.showSnackbar(Ui.SuccessSnackBar(
//             message: status
//                 ? "Your salon added successfully, Please login".tr
//                 : "Your Salon not added, Please contact customer care".tr));
//         await Get.toNamed(Routes.ROOT, arguments: 0);
//       }
//     } catch (e) {
//       Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
//     } finally {
//       loading.value = false;
//     }
//   }
// }
//

// Future<void> resendOTPCode() async {
//   resendCode();
//   await _userRepository.sendCodeToPhone();
// }
//
// void sendResetLink() async {
//   Get.focusScope.unfocus();
//   if (forgotPasswordFormKey.currentState.validate()) {
//     forgotPasswordFormKey.currentState.save();
//     loading.value = true;
//     await _userRepository
//         .sendResetLinkEmail(currentUser.value)
//         .then((value) => Timer(Duration(seconds: 5), () {
//               Get.offAndToNamed(Routes.LOGIN);
//             }));
//     loading.value = false;
//   }
// }
}
