import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/assets.dart';
import '../../global_widgets/profile_icon.dart';
import '../../home/controller/home_controller.dart';
import '../../home/widgets/home_recent_activity_card.dart';
import 'notification_delete_options_popup_menu_widget.dart';

class NotificationListViewItemWidget extends GetView<HomeController> {
  const NotificationListViewItemWidget({
    Key? key,
    this.logoName = "",
    this.subTitle = "",
    this.amount = "",
    this.duration = "",
    this.date = "",
    this.title = "",
    this.onDetailsTap,
    this.subTitleTextStyle,
    this.titleTextStyle,
    this.index,
  }) : super(key: key);
  final String logoName;
  final TextStyle? titleTextStyle;
  final TextStyle? subTitleTextStyle;
  final String title;
  final String subTitle;
  final String amount;
  final String duration;
  final String date;
  final int? index;
  final Function()? onDetailsTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Theme.of(context).canvasColor,
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 38.ss,
              width: 38.ss,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: const DecorationImage(
                  image: AssetImage("assets/icons/transCash.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 0.0001.sw,
            ),
            Column(
              children: [
                SizedBox(height: 0.07.sh, width: 0.5.sw, child: Text(title)),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: ScreenConstant.defaultHeightTwentyThree),
                      child: InkWell(
                          child: Image.asset(Assets.notificationListIcon)),
                    ),
                    Container(
                      width: 0.02.sw,
                    ),
                    SizedBox(
                        height: 0.06.sh, width: 0.5.sw, child: Text(subTitle,style: TextStyle(fontSize: 11),)),
                  ],
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  AvailibilityHoursOptionsPopupMenuWidget(
                    index: index,
                  ),
                  Container(
                    height: 0.07.sh,
                  ),
                  Text(
                    duration!,
                    style: const TextStyle(fontSize: 9),
                  ),
                  Container(
                    height: 0.003.sh,
                  ),
                  Text(
                    date!,
                    style: const TextStyle(fontSize: 8),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

// ListTile(
// leading: Container(
// height: 38.ss,
// width: 38.ss,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(30),
// image:const DecorationImage(
// image: AssetImage("assets/icons/transCash.png"),
// fit: BoxFit.cover,
// ),
// ),
// ),
// title: Text(title),
// subtitle: Row(
// children: [
// InkWell(child: Image.asset(Assets.notificationListIcon)),
// Container(width: 5.ss,),
// Expanded
// (child: Text(subTitle)),
// ],
// ),
// trailing: Column(
// children: [
// const AvailibilityHoursOptionsPopupMenuWidget(),
// Padding(
// padding:  EdgeInsets.only(top:18.0.ss),
// child: Text(duration!),
// ),
// ],
// ),
// )
