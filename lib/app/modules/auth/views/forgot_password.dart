import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/device_manager/strings.dart';
import '../../../../common/ui.dart';
import '../../../../common/widgets/frame.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/text_styles.dart';
import '../../../../common/widgets/app_button.dart';
import '../../../../common/widgets/required_text_field.dart';
import '../../../routes/app_routes.dart';
import '../controllers/auth_controller.dart';

class ForgotPasswordView extends GetView<AuthController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Frame(
        color: Theme.of(context).scaffoldBackgroundColor,
        onTap: () {
          controller.phoneForForgotPasswordController.text = "";
          controller.emailForForgotPasswordController.text = "";
          Get.back();
        },
        topWidget: true,
        topString: AppLabels.resetPassword,
        topWidgetSpacing: ScreenConstant.defaultWidthFifty,
        padding: ScreenConstant.spacingAllXXL,
        content: Form(
          key: controller.forgotPasswordFormKey,
          child: Column(
            children: [
              Container(
                height: ScreenConstant.screenHeightFourteen,
              ),
              Text(
                AppLabels.enterTheEmailAssociatedWith,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 15),
              ),
              Container(
                height: ScreenConstant.defaultHeightTwentyThree,
              ),
              controller.isResetPasswordWithMobileNumber.value
                  ? InkWell(
                      onTap: () {
                        controller.isResetPasswordWithMobileNumber.value =
                            false;
                      },
                      child: Text(
                        AppLabels.resetPasswordWithEmailAddress,
                        style: TextStyles.subTitleBlue
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                    )
                  : RequireTextField(
                      controller: controller.emailForForgotPasswordController,
                      type: Type.email,
                      labelText: AppLabels.emailAddress,
                      hintText: AppLabels.emailAddressDemo,
                    ),
              Container(
                height: ScreenConstant.defaultWidthThirty,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Expanded(
                    child: Divider(
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                  Container(
                    width: ScreenConstant.defaultWidthTen,
                  ),
                  Text(
                    AppLabels.or,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 17.fss),
                  ),
                  Container(
                    width: ScreenConstant.defaultWidthTen,
                  ),
                   Expanded(
                    child: Divider(
                      color: Theme.of(context).indicatorColor,
                    ),
                  ),
                ],
              ),
              Container(
                height: ScreenConstant.defaultHeightFifteen,
              ),
              controller.isResetPasswordWithMobileNumber.value
                  ? RequireTextField(
                      controller: controller.phoneForForgotPasswordController,
                      type: Type.phone,
                      labelText: AppLabels.mobileNumber.tr,
                      hintText: AppLabels.mobileNumberHintText.tr,
                    )
                  : InkWell(
                      onTap: () {
                        controller.isResetPasswordWithMobileNumber.value = true;
                      },
                      child: Text(
                        AppLabels.resetPasswordWithMobileNumber,
                        style: TextStyles.subTitleBlue
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
              Container(
                height: ScreenConstant.defaultHeightTwoHundredFifty,
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
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.screenWidthFourth,
                          vertical: ScreenConstant.sizeLarge),
                      buttonIconEnabled: true,
                      buttonText: AppLabels.send.tr,
                      buttonTextStyle: TextStyles.buttonTitle,
                      iconButton: true,
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.resetPassword();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
