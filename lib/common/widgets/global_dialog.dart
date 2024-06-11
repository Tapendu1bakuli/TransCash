import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../device_manager/colors.dart';
import '../device_manager/screen_constants.dart';
import '../device_manager/strings.dart';
import '../device_manager/text_styles.dart';
import 'custom_elevated_button.dart';

class GlobalDialog extends StatelessWidget {
  final String text;
  const GlobalDialog({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenConstant.sizeExtraLarge),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenConstant.sizeLarge),
          ),
          child: SizedBox(
            height: ScreenConstant.defaultHeightTwoHundred,
            child: Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenConstant.sizeXL),
                      child: Text(text,style: TextStyles.title,textAlign: TextAlign.center),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(left: ScreenConstant.sizeXL,right: ScreenConstant.sizeXL,top: ScreenConstant.sizeLarge,bottom: ScreenConstant.sizeLarge),
                      child: CustomElevatedButton(
                        text: AppLabels.ok.tr,
                        backgroundColor: AppColors.primaryColorDash,
                        iconEnable: false,
                        textColor: AppColors.white,
                        textStyle: TextStyles.title16Transparent,
                        padding: ScreenConstant.spacingAllMedium,
                        onTap: (){
                          Get.back();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
