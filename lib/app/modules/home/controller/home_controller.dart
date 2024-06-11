import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trans_cash_solution/Service/HomeService.dart';
import 'package:trans_cash_solution/model/all_notification_model.dart' as notification;
import 'package:trans_cash_solution/model/delete_notification_model.dart';
import 'package:trans_cash_solution/model/profile_update_model.dart';
import '../../../../Store/HiveStore.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/ui.dart';
import '../../../../model/all_notification_model.dart';
import '../../../../model/user_model.dart';
import '../../../routes/app_routes.dart';

class HomeController extends GetxController {
  //For camera

  //For profile page
  RxBool onlyPreview = true.obs;
  RxBool isProfileEditOptionEnabled = false.obs;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  //Home related
  RxBool isLoading = false.obs;
  final HomeServices _homeServices = HomeServices();
  var selectedIndex = 0.obs;
  RxBool isNotificationPage = false.obs;
  RxString authorizationToken = "".obs;
  RxString fullName = "".obs;
  RxString emailAddress = "".obs;
  RxString mobileNumber = "".obs;
  RxString temporaryProfileImageForUpload = "".obs;
  RxString profileImage = "".obs;
  RxString countryCode = "".obs;
  RxString totalWalletMoney = "".obs;
  var allNotification = <notification.Data>[].obs;

  @override
  void onInit() {
    getStoredValue();
    super.onInit();
  }

  //Fetch Notification
  void fetchAllNotification() async {
    Get.dialog(
        Center(
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(40)),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: AppColors.appPrimaryColor,
              ),
            ),
          ),
        ),
        barrierDismissible: false);
    AllNotificationModel? allNotificationModel = await _homeServices.getAllNotification(authorizationToken.value);
    Get.back();
    if(allNotificationModel!.status == 200){
      allNotification.assignAll(allNotificationModel.data!);
      Get.showSnackbar(Ui.SuccessSnackBar(
          title: "${allNotificationModel.shortMessage}",
          message: "${allNotificationModel.longMessage}"));
    }else{
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "${allNotificationModel.shortMessage}",
          message: "${allNotificationModel.longMessage}"));
    }
    Get.back();
  }

  //Delete Notification
  void deleteNotification(int? index) async {
    Get.dialog(
        Center(
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(40)),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: AppColors.appPrimaryColor,
              ),
            ),
          ),
        ),
        barrierDismissible: false);
    DeleteNotificationModel deleteNotificationModel = await _homeServices.deleteNotification(index, authorizationToken.value);
    if(deleteNotificationModel.status == 200){
      Get.back();
      fetchAllNotification();
    }else{
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "${deleteNotificationModel.longMessage}"));
    }
  }

  //Get User Details
  void getUserDetails() async {
    Get.dialog(
        Center(
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(40)),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: AppColors.appPrimaryColor,
              ),
            ),
          ),
        ),
        barrierDismissible: false);
    UserModel? userModel =
        await _homeServices.getUserDetails(authorizationToken.value);

    if (userModel!.status == 200) {
      fullName.value = userModel.data!.name!;
      emailAddress.value = userModel.data!.email!;
      profileImage.value = userModel.data!.profileUrl!;
      debugPrint("profile image:$profileImage");
      mobileNumber.value = userModel.data!.phone!;
      countryCode.value = userModel.data!.countryCode!;
      fullNameController.text = fullName.value;
      emailController.text = emailAddress.value;
      mobileController.text = userModel.data!.phone!;
      totalWalletMoney.value = userModel.data!.totalAmount!;
      HiveStore().setString(Keys.USEREPROFILEIMAGE, profileImage.value);
      HiveStore().setString(Keys.TOTALAMOUNT, totalWalletMoney.value);
      Get.toNamed(Routes.PROFILE);
    } else {
      Get.back();
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "Something Went Wrong", message: "Check your Credentials"));
    }
    Get.back();
  }

  void getUserTotalMoney() async {
    Get.dialog(
        Center(
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(40)),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: AppColors.appPrimaryColor,
              ),
            ),
          ),
        ),
        barrierDismissible: false);
    UserModel? userModel =
    await _homeServices.getUserDetails(authorizationToken.value);
    Get.back();
    if (userModel!.status == 200) {
      totalWalletMoney.value = userModel.data!.totalAmount!;
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "Something Went Wrong", message: "Check your Credentials"));
    }
    Get.back();
  }

  void getUserTotalMoneyAfterPaypalSuccessful() async {
    UserModel? userModel =
    await _homeServices.getUserDetails(authorizationToken.value);
    if (userModel!.status == 200) {
      totalWalletMoney.value = userModel.data!.totalAmount!;
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "Something Went Wrong", message: "Check your Credentials"));
    }
  }

  //Update Profile
  void updateProfile() async {
    Get.focusScope!.unfocus();
    if (profileFormKey.currentState!.validate()) {
      isLoading.value = true;
      profileFormKey.currentState!.save();
      if (fullNameController.text.isNotEmpty ||
          mobileController.text.isNotEmpty) {
        if (fullNameController.text != fullName.value ||
            mobileController.text != mobileNumber.value ||
            temporaryProfileImageForUpload.value.isNotEmpty) {
          if (profileFormKey.currentState!.validate()) {
            debugPrint("fileName ${temporaryProfileImageForUpload.value}");
            isLoading.value = true;
            UpdateProfileModel updateProfileModel =
                await _homeServices.updateProfile(
                    token: authorizationToken.value,
                    name: fullNameController.text,
                    profileImage: temporaryProfileImageForUpload.value);
            if (updateProfileModel.status == 200) {
              temporaryProfileImageForUpload.value = "";
              isLoading.value = false;
              isProfileEditOptionEnabled.value = false;
              Get.closeAllSnackbars();
              getUserDetails();
              Get.showSnackbar(Ui.SuccessSnackBar(
                  title: "${updateProfileModel.shortMessage}",
                  message: "${updateProfileModel.longMessage}"));
            } else {
              temporaryProfileImageForUpload.value = "";
              isLoading.value = false;
              isProfileEditOptionEnabled.value = false;
              Get.showSnackbar(Ui.ErrorSnackBar(
                  title: "${updateProfileModel.shortMessage}",
                  message: "${updateProfileModel.longMessage}"));
            }
          }
        } else {
          isLoading.value = false;
          Get.showSnackbar(Ui.ErrorSnackBar(
              title: "Nothing to update",
              message: "There is nothing for update!"));
        }
      } else {
        isLoading.value = false;
        Get.showSnackbar(Ui.ErrorSnackBar(
            title: "Fields are empty",
            message: "There is nothing for update!"));
      }
    }
  }

  //Get data's from HiveStore
  getStoredValue() async {
    authorizationToken.value = HiveStore().getString(Keys.TOKEN) ?? "";
    mobileController.text = HiveStore().getString(Keys.USERMOBILE) ?? "";
    emailController.text = HiveStore().getString(Keys.USEREMAIL) ?? "";
    profileImage.value = HiveStore().getString(Keys.USEREPROFILEIMAGE) ?? "";
    fullNameController.text = HiveStore().getString(Keys.USERNAME) ?? "";
    countryCode.value = HiveStore().getString(Keys.COUNTRYCODE) ?? "";
  }
}
