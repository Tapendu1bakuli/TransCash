import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import '../../../../common/device_manager/assets.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../global_widgets/profile_icon.dart';
import '../../notification_section.dart/widget/notification_delete_options_popup_menu_widget.dart';
import '../controller/home_controller.dart';

class HomeRecentActivityCard extends StatelessWidget {
  bool isNotificationPage;
  String? title;
  String? leading;
  String? subTitle;
  String? amount;
  String? duration;
  TextStyle? titleTextStyle;
  TextStyle? subTitleTextStyle;
  Function()? onDetailsTap;

  HomeRecentActivityCard(
      {super.key,
      this.isNotificationPage = false,
      this.duration,
      this.subTitleTextStyle,
      this.titleTextStyle,
      this.amount,
      this.title,
      this.leading,
      this.subTitle,
      this.onDetailsTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: onDetailsTap,
          child: Row(
            children: [
              ProfileIcon(
                borderRadious: 30,
                height: 48.ss,
                width: 48.ss,
                image: leading!,
              ),
              Container(
                width: 20.ss,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title??"",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  Container(
                    height: ScreenConstant.defaultWidthTen,
                  ),
                  isNotificationPage
                      ? Row(
                          children: [
                            InkWell(child: Image.asset(Assets.notificationListIcon)),
                            Container(
                              width: ScreenConstant.defaultWidthTen,
                            ),
                            Text(amount!,style: Theme.of(context).textTheme.displayMedium,),
                            Container(
                              width: ScreenConstant.defaultWidthTen,
                            ),
                            Text(subTitle!),
                          ],
                        )
                      : Text(
                          subTitle!,
                          style: subTitleTextStyle,
                        ),
                ],
              ),
              Expanded(
                child: Container(
                  width: 20.ss,
                ),
              ),
              isNotificationPage
                  ? const Offstage()
                  : Expanded(
                    child: FittedBox(
                      child: Text(
                          amount!,
                          style: Theme.of(context).textTheme.displayMedium,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        ),
                    ),
                  ),
              Container(
                width: ScreenConstant.defaultWidthTen,
              ),
              isNotificationPage
                  ? Column(
                      children: [
                        AvailibilityHoursOptionsPopupMenuWidget(),
                        Container(height: ScreenConstant.defaultWidthTen,),
                        Text(duration!),
                      ],
                    )
                  : SvgPicture.asset(
                      Assets.leftArrowIcon,
                    ),
            ],
          ),
        ),
      );
  }
}
