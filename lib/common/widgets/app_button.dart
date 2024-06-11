import 'package:flutter/material.dart';

import '../device_manager/colors.dart';
import '../device_manager/screen_constants.dart';
import '../device_manager/text_styles.dart';

class AppButton extends StatelessWidget {
  final double? buttonHeight;
  final onPressed;
  final String buttonText;
  final Color? buttonColor;
  final TextStyle? buttonTextStyle;
  final EdgeInsets? padding;
  final iconButton;
  final buttonIcon;
  final buttonIconEnabled;

  AppButton(
      {this.iconButton = false,
        this.buttonHeight,
      this.buttonIconEnabled = false,
      this.buttonIcon,
      this.onPressed,
      this.buttonText = "",
      this.buttonColor,
      this.buttonTextStyle,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return iconButton
        ? InkWell(
            onTap: onPressed, // button pressed
            child: Container(
              height: buttonHeight?? ScreenConstant.sizeUltraXXXL,
              padding: padding ?? ScreenConstant.spacingAllMedium,
              decoration: buttonColor == null?BoxDecoration(
                  gradient: onPressed != null
                      ? const LinearGradient(
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(2.0, 0.0),
                          colors: [
                              AppColors.primaryColorDash,
                              AppColors.primaryColorDashHash
                            ])
                      : LinearGradient(
                          end: FractionalOffset(0.0, 2.0),
                          begin: FractionalOffset(0.0, 0.0),
                          colors: [
                              AppColors.primaryColorDash.withOpacity(0.2),
                              AppColors.white
                            ]),
                  color: buttonColor ?? AppColors.primaryColorDash,
                  borderRadius: BorderRadius.circular(30.0),
                  // set rounded corner radius
                  boxShadow: buttonColor != null
                      ? [
                          BoxShadow(
                              blurRadius: 2,
                              color: buttonColor!,
                              offset: const Offset(0, 3))
                        ]
                      : [
                          const BoxShadow(
                              blurRadius: 2,
                              color: AppColors.buttonShadowColor,
                              offset: Offset(0, 3))
                        ] // make rounded corner of border
                  ): BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                color: AppColors.red
              ),
              child: buttonIconEnabled
                  ? Text(
                      buttonText,
                      style: buttonTextStyle ?? TextStyles.buttonText,
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenConstant.sizeSmallHighest),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // icon
                          Text(
                            buttonText,
                            style: buttonTextStyle ?? TextStyles.buttonText,
                          ),
                          Icon(
                            buttonIcon ?? Icons.arrow_forward,
                            color: AppColors.white,
                            size: ScreenConstant.texIconSize,
                          ), // text
                        ],
                      ),
                    ),
            ),
          )
        : GestureDetector(
            onTap: onPressed,
            child: Container(
              height: ScreenConstant.sizeUltraXXXL,
              padding: padding ?? ScreenConstant.spacingAllMedium,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: AppColors.primaryColorDash),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenConstant.sizeSmallHighest),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      buttonText,
                      style: buttonTextStyle ?? TextStyles.buttonText,
                    ),
                    Icon(
                      buttonIcon ?? Icons.add,
                      color: AppColors.primaryColorDash,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
