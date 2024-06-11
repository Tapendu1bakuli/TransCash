import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trans_cash_solution/common/widgets/frame.dart';
import '../../../../common/device_manager/assets.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/strings.dart';
import '../../../../common/device_manager/text_styles.dart';
import '../../../../common/widgets/app_button.dart';
import '../../../../common/widgets/required_text_field.dart';
import '../controllers/auth_controller.dart';

class OTPVerificationView extends GetView<AuthController> {
    OTPVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("${ScreenConstant.spacingAllUltraXXXL}");
    debugPrint("${ScreenConstant.screenHeightFifteen}");
    return Obx(
      () => Frame(
        color: Theme.of(context).scaffoldBackgroundColor,
        topWidget: controller.isTopWidgetEnabled.value ? true : false,
        topWidgetSpacing: controller.isTopCurrentPasswordEnabled.value
            ? ScreenConstant.screenHeightTwelve
            : ScreenConstant.screenHeightThirteen,
        topString: AppLabels.verification,
        padding: ScreenConstant.spacingAllXXL,
        logo: true,
        logoName: Assets.otpLogo,
        logoHeight: ScreenConstant.defaultSizeTwoFifty,
        logoWidth: ScreenConstant.defaultSizeTwoFifty,
        content: Form(
          key: controller.otpVerificationFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLabels.otpVerification.tr,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Container(
                height: ScreenConstant.sizeMidLarge,
              ),
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: AppLabels.enterTheOTPSentTo.tr,
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 13)),
                    TextSpan(
                        text:controller.email.value,
                        style: Theme.of(context).textTheme.displaySmall),
                  ],
                ),
              ),
              Container(
                height: ScreenConstant.defaultWidthSixty,
              ),
              RequireTextField(
                controller: controller.otpVerificationController,
                type: Type.otp,
                labelText: AppLabels.emailAddress,
                hintText: AppLabels.emailAddressDemo,
              ),
              Container(
                height: ScreenConstant.defaultWidthTen,
              ),
              controller.enableResend.value
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLabels.didNotReceiveOTP.tr,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Container(
                          width: ScreenConstant.sizeExtraSmall,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.isTopWidgetEnabled.value
                                ? controller.resendOTPForgotPassword()
                                : controller.resendOTPForRegisterUser();
                          },
                          child: Text(
                            AppLabels.resendOTP.tr,
                            style: TextStyles.subTitleBlue,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLabels.resendOTPin.tr,
                          style: TextStyles.subTitleBlue,
                        ),
                        Container(
                          width: ScreenConstant.sizeExtraSmall,
                        ),
                        Text("${controller.secondsRemaining}"),
                        Container(
                          width: ScreenConstant.sizeExtraSmall,
                        ),
                        Text(
                          AppLabels.secoends.tr,
                          style: TextStyles.subTitleBlue,
                        ),
                      ],
                    ),
              controller.isTopWidgetEnabled.value
                  ? Container(
                      height: ScreenConstant.screenWidthSixth,
                    )
                  : Container(
                      height: ScreenConstant.screenWidthThird,
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
                      buttonText: AppLabels.verify.tr,
                      buttonTextStyle: TextStyles.buttonTitle,
                      iconButton: true,
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.isCurrentPasswordFieldEnabled.value = false;
                        controller.isTopCurrentPasswordEnabled.value = false;
                        controller.isTopWidgetEnabled.value
                            ? controller.verifyEmailForForgetPassword()
                            : controller.verifyEmail();
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
