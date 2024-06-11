import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/helper.dart';
import '../../../../common/widgets/frame.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/strings.dart';
import '../../../../common/device_manager/text_styles.dart';
import '../../../../common/widgets/app_button.dart';
import '../../../../common/widgets/required_text_field.dart';
import '../../../routes/app_routes.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Frame(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: ScreenConstant.spacingAllXL,
        content: Form(
          key: controller.registerFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: ScreenConstant.screenWidthSixth,
              ),
              Text(
                AppLabels.registerNow.tr,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 25.fss),
              ),
              Container(
                height: ScreenConstant.sizeMidLarge,
              ),
              RequireTextField(
                controller: controller.fullNameRegistrationController,
                type: Type.name,
                labelText: AppLabels.fullName.tr,
                hintText: AppLabels.fullNameHintText.tr,
              ),
              Container(
                height: ScreenConstant.sizeMidLarge,
              ),
              RequireTextField(
                controller: controller.emailRegistrationController,
                type: Type.email,
                labelText: AppLabels.emailAddress.tr,
                hintText: AppLabels.emailAddressDemo.tr,
              ),
              Container(
                height: ScreenConstant.sizeMidLarge,
              ),
              RequireTextField(
                controller: controller.mobileRegistrationController,
                type: Type.phone,
                labelText: AppLabels.mobileNumber.tr,
                hintText: AppLabels.mobileNumberHintText.tr,
              ),
              Container(
                height: ScreenConstant.sizeMidLarge,
              ),
              RequireTextField(
                controller: controller.passwordRegistrationController,
                type: Type.passWord,
                labelText: AppLabels.password.tr,
                hintText: AppLabels.passwordHintText.tr,
              ),
              Container(
                height: ScreenConstant.sizeMidLarge,
              ),
              RequireTextField(
                controller: controller.confirmPasswordRegistrationController,
                type: Type.passWord,
                labelText: AppLabels.confirmPassword.tr,
                hintText: AppLabels.passwordHintText.tr,
              ),
              Container(
                height: ScreenConstant.sizeMidLarge,
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: Colors.white,
                ),
                child: CheckboxListTile(
                  selected: controller.registrationCheckBox.value,
                  value: controller.registrationCheckBox.value,
                  activeColor: AppColors.activityDetailsAppBarColor,
                  onChanged: (value) {
                    controller.registrationCheckBox.value = value!;
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: ScreenConstant.spacingAllZero,
                  title: GestureDetector(
                    onTap: () {
                      Helper().launchToUrl("https://www.google.com/");
                    },
                    child: Text(AppLabels.termsAndCondition,
                        style: TextStyles.subTitleBlue),
                  ),
                ),
              ),
              Container(
                height: ScreenConstant.defaultWidthNinetyEight,
              ),
              controller.isLoading.value
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
                  : AppButton(
                      buttonText: AppLabels.register.tr,
                      buttonTextStyle: TextStyles.buttonTitle,
                      iconButton: true,
                      buttonIcon: Icons.arrow_right_alt_outlined,
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.register();
                      },
                    ),
              Container(
                height: ScreenConstant.sizeSmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLabels.alreadyHaveAnAccount,
                      style: Theme.of(context).textTheme.displaySmall),
                  Container(
                    width: ScreenConstant.sizeExtraSmall,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.isTopCurrentPasswordEnabled.value = true;
                      FocusManager.instance.primaryFocus?.unfocus();
                      Get.toNamed(Routes.LOGIN);
                    },
                    child: Text(AppLabels.loginNow,
                        style: TextStyles.subTitleBlue),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
