import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_like_css/gradient_like_css.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/common/device_manager/strings.dart';
import 'package:trans_cash_solution/common/widgets/frame.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/text_styles.dart';
import '../../../../common/widgets/app_button.dart';
import '../../../../common/widgets/required_text_field.dart';
import '../../../routes/app_routes.dart';
import '../controllers/auth_controller.dart';

class NewPasswordView extends GetView<AuthController> {
  const NewPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Frame(
        color: Theme.of(context).scaffoldBackgroundColor,
        topWidget: true,
        topString: controller.isTopCurrentPasswordEnabled.value
            ? AppLabels.changePassword
            : AppLabels.newPassword,
        topWidgetSpacing: controller.isTopCurrentPasswordEnabled.value
            ? ScreenConstant.screenHeightFifteen
            : ScreenConstant.screenHeightThirteen,
        padding: ScreenConstant.spacingAllXXL,
        content: Form(
          key: controller.isTopCurrentPasswordEnabled.value
              ? controller.forgotPasswordForUpdatePasswordFormKey
              : controller.newPasswordFormKey,
          child: Column(
            children: [
              Container(
                height: ScreenConstant.sizeXXXL,
              ),
              const Text(AppLabels.yourNewPasswordMustBe),
              Container(
                height: ScreenConstant.sizeXL,
              ),
              controller.isCurrentPasswordFieldEnabled.value
                  ? RequireTextField(
                      controller: controller.currentPasswordController,
                      labelText: AppLabels.currentPassword,
                      hintText: AppLabels.passwordHintText,
                      type: Type.passWord,
                    )
                  : const Offstage(),
              controller.isCurrentPasswordFieldEnabled.value
                  ? Container(
                      height: ScreenConstant.sizeXL,
                    )
                  : const Offstage(),
              RequireTextField(
                controller: controller.isCurrentPasswordFieldEnabled.value
                    ? controller.enterNewPasswordController
                    : controller.newPasswordController,
                labelText: AppLabels.enterNewPassword,
                hintText: AppLabels.passwordHintText,
                type: Type.passWord,
              ),
              Container(
                height: ScreenConstant.sizeXL,
              ),
              RequireTextField(
                controller: controller.isCurrentPasswordFieldEnabled.value
                    ? controller.confirmNewPasswordController
                    : controller.confirmPasswordController,
                labelText: AppLabels.confirmPassword,
                hintText: AppLabels.passwordHintText,
                type: Type.passWord,
              ),
              controller.isCurrentPasswordFieldEnabled.value
                  ? Container(
                      height: ScreenConstant.defaultHeightTwoHundredTen,
                    )
                  : Container(
                      height: ScreenConstant.defaultWidthThreeThirtySix,
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
                  : GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.isTopCurrentPasswordEnabled.value
                            ? controller.updateOldPassword()
                            : controller.newPassword();
                      },
                      child: Container(
                        width: .9.sw,
                        height: 60.ss,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: linearGradient(90, ['#31AD00', '#13DA02']),
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
                            "Update Password",
                            style: TextStyles.buttonTitle,
                          ),
                        ),
                      ),
                    ),
              // AppButton(
              //   padding: EdgeInsets.symmetric(
              //       horizontal: ScreenConstant.screenWidthSixth,
              //       vertical: ScreenConstant.sizeLarge),
              //   buttonIconEnabled: true,
              //   buttonText: controller.isTopCurrentPasswordEnabled.value
              //       ? AppLabels.updatePassword
              //       : AppLabels.resetPassword.tr,
              //   buttonTextStyle: TextStyles.buttonTitle,
              //   iconButton: true,
              //   onPressed: () {
              //     controller.isTopCurrentPasswordEnabled.value
              //         ? controller.updateOldPassword()
              //         : controller.newPassword();
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
