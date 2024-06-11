import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import '../../root/controllers/root_controller.dart';
import '../../../../common/device_manager/text_styles.dart';
import '../../../../common/widgets/app_button.dart';
import '../../../../common/widgets/frame.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/strings.dart';
import '../../../routes/app_routes.dart';

class LandingView extends GetView<RootController> {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    //ScreenConstant.setScreenAwareConstant(context);
    return Frame(
      color: Theme.of(context).scaffoldBackgroundColor,
        padding: ScreenConstant.spacingAllXL,
        content: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            Container(
              height: ScreenConstant.screenHeightFourth,
            ),
            Text(AppLabels.welcomeToTrashCash.tr, style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 26.fss)),
            Container(
              height: ScreenConstant.screenHeightNineteen,
            ),
            AppButton(
              buttonText: AppLabels.login.tr,
              buttonTextStyle: TextStyles.buttonTitle,
              iconButton: true,
              buttonIcon: Icons.arrow_right_alt_outlined,
              onPressed: () {
                Get.toNamed(Routes.LOGIN);
              },
            ),
            Container(
              height: ScreenConstant.sizeMedium,
            ),
            AppButton(
              iconButton: false,
              buttonText: AppLabels.register,
              buttonTextStyle: TextStyles.buttonTitleGreen,
              buttonIcon: Icons.arrow_right_alt_outlined,
              onPressed: () {
                Get.toNamed(Routes.REGISTER);
              },
            )
          ],
        ));
  }
}
