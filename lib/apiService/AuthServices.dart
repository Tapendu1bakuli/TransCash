import 'dart:developer';
import 'package:trans_cash_solution/app/modules/auth/models/registration_model.dart';
import 'package:trans_cash_solution/model/otp_verification_model.dart';
import 'package:trans_cash_solution/model/update_current_password_model.dart';
import '../Service/CoreService.dart';
import '../Service/GlobalKeys.dart';
import '../app/modules/auth/models/logIn_model.dart';
import '../model/forget_password_resend_otp_model.dart';
import '../model/forget_password_reset_model.dart';
import '../model/otp_sent_for_forget_password_model.dart';
import '../model/verify_register_resend_otp_model.dart';

class AuthService {
  //Login
  login({String? email, String? password, String? deviceToken}) async {
    Map data = {
      "email": email,
      "password": password,
      "device_token" : deviceToken
    };
    final response = await CoreService().apiService(
      endpoint: GlobalKeys.logIn,
      body: data,
    );

    var result = LogInModel();
    try {
      result = LogInModel.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }

  registerUser({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
    String? countryCode,
  }) async {
    Map data = {
      "name": name,
      "email": email,
      "password": password,
      "confirm_password": confirmPassword,
      "country_code": countryCode,
      "phone": phone,
    };
    final response = await CoreService().apiService(
      method: METHOD.POST,
      endpoint: GlobalKeys.registration,
      body: data,
    );
    var result = RegistrationModel();
    try {
      result = RegistrationModel.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }

  //Reset Password
  resetPassword({String? email, String? mobile}) async {
    Map data = {
      "email": email,
    };
    final response = await CoreService().apiService(
      endpoint: GlobalKeys.forgotPassword,
      body: data,
    );

    var result = OTPSentForForgetPasswordModel();
    try {
      result = OTPSentForForgetPasswordModel.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }

  // resendOTP(String email) async {
  //   final response = await CoreService().apiService(
  //       method: METHOD.GET,
  //       endpoint: GlobalKeys.RESEND_OTP,
  //       params: {"email": email});
  //
  //   return response;
  // }

  verifyOTP({String? otp, String? token}) async {
    Map data = {"otp": otp};
    final response = await CoreService().apiService(
        method: METHOD.POST,
        endpoint: GlobalKeys.verifyOtp,
        body: data,
        header: {"Authorization": "$token"});
    var result = OTPVerificationModel();
    try {
      result = OTPVerificationModel.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }

  forgotPasswordResendOTP({String? email,String? token}) async{
    Map data = {
      "email" : email,
    };
    final response = await CoreService().apiService(
        method: METHOD.POST,
        endpoint: GlobalKeys.forgotPasswordResendOTP,
        body: data,
        header: {"Authorization": "$token"}
    );
    var result = ForgetPasswordResendOTPModel();
    try {
      result = ForgetPasswordResendOTPModel.fromJson(response);
    }
    catch (e){
      log("Error while parsing:$e");
    }
    return result;
}

   registerResendOTP({String? email,String? token}) async{
     Map data = {
       "email" : email,
     };
     final response = await CoreService().apiService(
         method: METHOD.POST,
         endpoint: GlobalKeys.registerResendOTP,
         body: data,
         header: {"Authorization": "$token"}
     );
     var result = VerifyRegisterResendOtpModel();
     try {
       result = VerifyRegisterResendOtpModel.fromJson(response);
     }
     catch (e){
       log("Error while parsing:$e");
     }
     return result;
   }

   forgetPasswordVerifyOTP({String? otp,String? token}) async {
     Map data = {
       "otp" : otp
     };
     final response = await CoreService().apiService(
         method: METHOD.POST,
         endpoint: GlobalKeys.forgotPasswordVerifyOtp,
         body: data,
         header: {"Authorization": "$token"}
     );
     var result = OTPVerificationModel();
     try {
       result = OTPVerificationModel.fromJson(response);
     }
     catch (e){
       log("Error while parsing:$e");
     }
     return result;
   }


  forgetPasswordReset({String? password, String? token}) async {
    Map data = {"password": password};
    final response = await CoreService().apiService(
        method: METHOD.POST,
        endpoint: GlobalKeys.forgotPasswordReset,
        body: data,
        header: {"Authorization": "$token"});
    var result = ForgotPasswordResetModel();
    try {
      result = ForgotPasswordResetModel.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }

  updateCurrentPassword(
      {String? currentPassword,
      String? newPassword,
      String? confirmPassword,
      String? token}) async {
    Map data = {
      "old_password": currentPassword,
      "new_password": newPassword,
      "new_confirm_password": confirmPassword,
    };
    final response = await CoreService().apiService(
        method: METHOD.POST,
        endpoint: GlobalKeys.passwordUpdate,
        body: data,
        header: {"Authorization": "$token"});
    var result = UpdateCurrentPassword();
    try {
      result = UpdateCurrentPassword.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }
  // verifyEmail(String email) async {
  //   Map data = {"email": email};
  //
  //   final response = await CoreService().apiService(
  //     method: METHOD.POST,
  //     endpoint: GlobalKeys.FORGOT_PASSWORD,
  //     body: data,
  //   );
  //
  //   return response;
  // }

  // resetPassword(String email, String password) async {
  //   Map data = {"email": email, "newPassword": password};
  //   final response = await CoreService().apiService(
  //     method: METHOD.POST,
  //     endpoint: GlobalKeys.RESET_PASSWORD,
  //     body: data,
  //   );
  //
  //   return response;
  // }
}
