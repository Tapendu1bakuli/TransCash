import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/widgets/frame.dart';
import '../../../../common/device_manager/assets.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/strings.dart';
import '../../../../common/device_manager/text_styles.dart';
import '../../../../common/widgets/app_button.dart';
import '../../../../common/widgets/required_text_field.dart';
import '../../../routes/app_routes.dart';
import '../controllers/auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Frame(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: ScreenConstant.spacingAllXXL,
        logo: true,
        logoName: Assets.landingLogo,
        logoHeight: ScreenConstant.defaultIconSize,
        logoWidth: ScreenConstant.defaultIconSize,
        content: Form(
          key: controller.loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: ScreenConstant.sizeUltraXXXL,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  AppLabels.login,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 25.fss),
                ),
              ),
              Container(
                height: ScreenConstant.sizeMidLarge,
              ),
              RequireTextField(
                controller: controller.emailLogInTextController,
                type: Type.email,
                labelText: AppLabels.emailAddress,
                hintText: AppLabels.emailAddressDemo,
              ),
              Container(
                height: ScreenConstant.sizeMidLarge,
              ),
              RequireTextField(
                controller: controller.passwordLogInTextController,
                labelText: AppLabels.password,
                type: Type.passWord,
              ),
              Container(
                height: ScreenConstant.sizeMidLarge,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.FORGOT_PASSWORD);
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    AppLabels.forgotPassword,
                    textAlign: TextAlign.justify,
                    style: TextStyles.subTitleBlue,
                  ),
                ),
              ),
              Container(
                height: ScreenConstant.screenWidthHalf,
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
                      buttonText: AppLabels.login.tr,
                      buttonTextStyle: TextStyles.buttonTitle,
                      iconButton: true,
                      buttonIcon: Icons.arrow_right_alt_outlined,
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        controller.login();
                      },
                    ),
              Container(
                height: ScreenConstant.sizeMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLabels.newUser,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Container(
                    width: ScreenConstant.sizeExtraSmall,
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Get.offAllNamed(Routes.REGISTER);
                    },
                    child: Text(AppLabels.registerHere,
                        style: TextStyles.subTitleBlue),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
