import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/strings.dart';
import '../../../../common/device_manager/text_styles.dart';
import '../../../../common/widgets/app_button.dart';
import '../controller/send_request_controller.dart';

class InviteScreen extends GetView<SendRequestController> {
  String? name;

  InviteScreen({
    this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Theme.of(context).indicatorColor,),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: AppColors.appAccentColor),
        title: Text(
          "Invite $name to TransCash",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenConstant.defaultWidthForty,vertical: ScreenConstant.defaultWidthOneNinety),
              child: Text("$name is not registered with TransCash.",style: TextStyles.title.copyWith(color: AppColors.activityDetailsAppBarColor),),
            ),
              Padding(
                padding: ScreenConstant.spacingAllXXXL,
                child: AppButton(
                  buttonText: AppLabels.invite.tr,
                  buttonTextStyle: TextStyles.buttonTitle,
                  iconButton: true,
                  buttonIcon: Icons.arrow_right_alt_outlined,
                  onPressed: () {
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
