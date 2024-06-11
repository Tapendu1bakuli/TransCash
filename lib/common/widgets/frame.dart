import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/common/helper.dart';

import '../../app/modules/auth/controllers/auth_controller.dart';
import '../device_manager/colors.dart';
import '../device_manager/screen_constants.dart';
import '../device_manager/text_styles.dart';

class Frame extends StatelessWidget {
  const Frame({
    Key? key,
    this.formKey,
    this.topWidget = false,
    this.topString = "",
    this.logo = false,
    this.isStack = false,
    this.logoName = "",
    this.content = const Offstage(),
    this.color = AppColors.white,
    this.logoHeight = 0.0,
    this.logoWidth = 0.0,
    this.padding = const EdgeInsets.all(0),
    this.topWidgetSpacing = 0.0,
    this.onTap,
    this.appBar,
    this.topLeadingIconColor = AppColors.appAccentColor
  }) : super(key: key);
  final GlobalKey? formKey;
  final AppBar? appBar;
  final bool logo;
  final bool isStack;
  final bool topWidget;
  final String topString;
  final String logoName;
  final double logoHeight;
  final double logoWidth;
  final Widget content;
  final Color color;
  final Color topLeadingIconColor;
  final EdgeInsets padding;
  final double topWidgetSpacing;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
        appBar: appBar,
        backgroundColor: color,
        body: isStack?content:Padding(
          padding: EdgeInsets.only(top: 10.0.ss),
          child: Form(
            key: formKey,
            child: ListView(
              padding: padding,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                topWidget
                    ? Row(
                        children: [
                          GestureDetector(
                            onTap: onTap ??
                                () {
                                  Get.back();
                                },
                            child: Icon(Icons.arrow_back_ios_new,color: Theme.of(context).indicatorColor,),
                          ),
                          Container(width: topWidgetSpacing),
                          Text(
                            topString,
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 21),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : Offstage(),
                logo
                    ? Column(
                        children: [
                          Container(
                            height: ScreenConstant.screenHeightMinimum,
                          ),
                          Image.asset(
                            logoName,
                            height: logoHeight,
                            width: logoWidth,
                          ),
                          Container(
                            height: ScreenConstant.screenHeightMinimum,
                          ),
                        ],
                      )
                    : const Offstage(),
                content,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
