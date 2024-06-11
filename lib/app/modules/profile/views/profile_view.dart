import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_like_css/gradient_like_css.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/Store/HiveStore.dart';
import 'package:trans_cash_solution/app/modules/auth/controllers/auth_controller.dart';
import 'package:trans_cash_solution/app/modules/home/controller/home_controller.dart';
import 'package:trans_cash_solution/app/modules/profile/views/image_preview.dart';
import 'package:trans_cash_solution/common/widgets/frame.dart';
import 'package:trans_cash_solution/provider/theme_provider.dart';
import '../../../../common/device_manager/assets.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/strings.dart';
import '../../../../common/device_manager/text_styles.dart';
import '../../../../common/widgets/app_button.dart';
import '../../../../common/widgets/required_text_field.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/camera_gallery_pop_up_widget.dart';
import '../../global_widgets/profile_icon.dart';

class ProfileView extends GetView<HomeController> {
  ProfileView({super.key});

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(initState: (state) {
      Future.delayed(const Duration(milliseconds: 100), () {
        controller.getUserDetails();
      });
    }, builder: (_) {
      return Frame(
        color: Theme.of(context).scaffoldBackgroundColor,
        onTap: () {
          controller.isProfileEditOptionEnabled.value = false;
          Get.back();
        },
        padding: ScreenConstant.spacingAllXL,
        topWidget: true,
        topString: controller.isProfileEditOptionEnabled.value
            ? AppLabels.editProfile
            : AppLabels.profile,
        topWidgetSpacing: controller.isProfileEditOptionEnabled.value
            ? ScreenConstant.screenHeightFifteen
            : ScreenConstant.screenHeightEighth,
        content: Form(
          key: controller.profileFormKey,
          child: Obx(()=>Column(
              children: [
                Container(
                  height: ScreenConstant.sizeXXL,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        debugPrint("Hello");
                        controller.isProfileEditOptionEnabled.value?controller.onlyPreview.value = false:controller.onlyPreview.value = true;
                        Get.toNamed(Routes.IMAGEPREVIEWSCREEN);
                      },
                      child: Stack(
                        children: [
                          controller.temporaryProfileImageForUpload.value.isEmpty
                              ? ProfileIcon(
                                  borderRadious: 15,
                                  height: ScreenConstant.defaultHeightSixty,
                                  width: ScreenConstant.defaultHeightSixty,
                                  image:
                                  controller.profileImage.value,
                                )
                              : Container(
                                  height: ScreenConstant.defaultHeightSixty,
                                  width: ScreenConstant.defaultHeightSixty,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Image.file(fit: BoxFit.contain,File(controller
                                      .temporaryProfileImageForUpload.value))
                                ),
                          Positioned(
                            right: 1,
                            bottom: 0,
                            child: Container(
                              height: ScreenConstant.sizeSmall,
                              width: ScreenConstant.sizeSmall,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white, width: 1),
                                  color: const Color(0xFF31AD00),
                                  shape: BoxShape.circle),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: ScreenConstant.defaultWidthTwenty,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controller.fullName.value.tr,
                              style: Theme.of(context).textTheme.displayLarge),
                          Container(
                            height: ScreenConstant.defaultWidthTen,
                          ),
                          Text(AppLabels.online, style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    const Spacer(),
                    controller.isProfileEditOptionEnabled.value
                        ? Container(
                            width: ScreenConstant.defaultWidthTwenty,
                          )
                        : Expanded(
                            child: InkWell(
                                onTap: () {
                                  controller.isProfileEditOptionEnabled.value =
                                      true;
                                },
                                child: Image.asset(
                                  Assets.editIcon,
                                  height: ScreenConstant.sizeMedium,
                                )),
                          ),
                    controller.isProfileEditOptionEnabled.value
                        ? InkWell(
                      onTap: (){
                        debugPrint("there");
                        controller.onlyPreview.value = false;
                        Get.toNamed(Routes.IMAGEPREVIEWSCREEN);
                      },
                          child: Image.asset(
                      Assets.cameraICon,
                      height: ScreenConstant.sizeMedium,
                    ),
                        )
                        : const Offstage(),
                    controller.isProfileEditOptionEnabled.value?Container(width: ScreenConstant.defaultWidthForty,):const Offstage()
                  ],
                ),
                Container(
                  height: ScreenConstant.defaultWidthFifty,
                ),
                RequireTextField(
                  isReadOnly: !controller.isProfileEditOptionEnabled.value,
                  controller: controller.fullNameController,
                  type: Type.name,
                  labelText: AppLabels.fullName.tr,
                ),
                Container(
                  height: ScreenConstant.sizeMidLarge,
                ),
                !controller.isProfileEditOptionEnabled.value
                    ? RequireTextField(
                        isReadOnly: !controller.isProfileEditOptionEnabled.value,
                        controller: controller.emailController,
                        type: Type.email,
                        labelText: AppLabels.emailAddress.tr,
                      )
                    : const Offstage(),
                Container(
                  height: ScreenConstant.sizeMidLarge,
                ),
                !controller.isProfileEditOptionEnabled.value?
                RequireTextField(
                  isReadOnly: !controller.isProfileEditOptionEnabled.value,
                  controller: controller.mobileController,
                  type: Type.phoneWithPrefix,
                  prefixText: controller.countryCode.value,
                  hintText: AppLabels.mobileNumberHintText.tr,
                  labelText: AppLabels.mobileNumber.tr,
                ):const Offstage(),
                Container(
                  height: ScreenConstant.screenWidthHalf,
                ),
                controller.isProfileEditOptionEnabled.value
                    ? Container(
                        height: ScreenConstant.defaultWidthThirty,
                      )
                    : InkWell(
                        onTap: () {
                          authController.isTopCurrentPasswordEnabled.value = true;
                          authController.isCurrentPasswordFieldEnabled.value =
                              true;
                          Get.toNamed(Routes.NEW_PASSWORD);
                        },
                        child: Text(AppLabels.changePassword.tr,
                            style: TextStyles.subTitleBlue.copyWith(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.fss)),
                      ),
                controller.isProfileEditOptionEnabled.value
                    ? controller.isLoading.value
                        ? Container(
                            height: 35,
                            width: 35,
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
                          )
                        : Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.updateProfile();
                                },
                                child: Container(
                                  width: .9.sw,
                                  height: 60.ss,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    gradient: linearGradient(
                                        90, ['#31AD00', '#13DA02']),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Update Profile",
                                      style: TextStyles.buttonTitle,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 25.ss,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller
                                      .temporaryProfileImageForUpload.value = "";
                                  controller.isProfileEditOptionEnabled.value =
                                      false;
                                },
                                child: Container(
                                  width: .9.sw,
                                  height: 60.ss,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFF31AD00), width: 1),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: const Color(0xFF31AD00),
                                        fontSize: FontSize.s20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // AppButton(
                              //   buttonText: AppLabels.updateChanges.tr,
                              //   iconButton: true,
                              //   buttonTextStyle: TextStyles.buttonTitle,
                              //   buttonIcon: Icons.arrow_right_alt_outlined,
                              //   onPressed: () {
                              //     controller.updateProfile();
                              //   },
                              // ),
                              // Container(
                              //   height: ScreenConstant.defaultWidthTwenty,
                              // ),
                              // AppButton(
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: ScreenConstant.screenWidthFourth,
                              //       vertical: ScreenConstant.sizeLarge),
                              //   buttonColor: Colors.red,
                              //   buttonText: AppLabels.cancel.tr,
                              //   iconButton: true,
                              //   buttonTextStyle: TextStyles.buttonTitle,
                              //   buttonIconEnabled: true,
                              //   onPressed: () {
                              //     controller.isProfileEditOptionEnabled.value =
                              //         false;
                              //   },
                              // ),
                            ],
                          )
                    : Column(
                        children: [
                          Container(
                            height: ScreenConstant.defaultWidthThirty,
                          ),
                          AppButton(
                            buttonText: AppLabels.signOut.tr,
                            buttonTextStyle: TextStyles.buttonTitleGreen,
                            buttonIcon: Icons.arrow_right_alt_outlined,
                            onPressed: () {
                              showAlertDialog(context);
                            },
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.w300, fontSize: 14.fss),
      ),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Yes",
        style: TextStyle(
          color: AppColors.appPrimaryColor,
          fontSize: 14.fss,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () async {
        Get.back();
        await HiveStore().remove(Keys.TOKEN);
        await HiveStore().remove(Keys.USEREPROFILEIMAGE);
        await HiveStore().remove(Keys.USEREMAIL);
        await HiveStore().remove(Keys.USERNAME);
        await HiveStore().remove(Keys.USERMOBILE);
        await HiveStore().remove(Keys.COUNTRYCODE);
        Get.offAllNamed(Routes.LANDING);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Theme.of(context).canvasColor,
      title: Text(
        "Sign Out!",
        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 14.fss),
      ),
      content: Text(
        "Are you sure you want to sign out?",
        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 12.fss),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
