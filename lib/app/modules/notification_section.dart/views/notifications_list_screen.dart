import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trans_cash_solution/app/modules/home/controller/home_controller.dart';
import 'package:trans_cash_solution/common/device_manager/colors.dart';
import 'package:trans_cash_solution/common/device_manager/data_time_utilities.dart';
import 'package:trans_cash_solution/common/device_manager/screen_constants.dart';
import 'package:trans_cash_solution/common/device_manager/strings.dart';
import 'package:trans_cash_solution/common/widgets/frame.dart';
import '../../../../common/device_manager/text_styles.dart';
import '../controller/notifications_controller.dart';
import '../widget/notification_listView_Item_widget.dart';

class NotificationsListScreen extends GetView<HomeController> {
  const NotificationsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(initState: (state) {
      Future.delayed(const Duration(milliseconds: 100), () {
        controller.fetchAllNotification();
      });
    }, builder: (_) {
      return Frame(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              controller.isNotificationPage.value = false;
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).indicatorColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            AppLabels.notification,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 21),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0.0,
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        topWidgetSpacing: ScreenConstant.screenWidthFourth,
        padding: ScreenConstant.spacingAllMedium,
        content:controller.allNotification.isNotEmpty? ListView.builder(
            padding: const EdgeInsets.all(5),
            shrinkWrap: true,
            itemCount: controller.allNotification.length,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return NotificationListViewItemWidget(
                titleTextStyle: TextStyles.titleBlackInLine,
                subTitleTextStyle: TextStyles.subTitleDarkGreen,
                subTitle: controller.allNotification[index].body!,
                title: controller.allNotification[index].title!,
                duration: DateTimeUtility()
                    .parseToLocal(dateTime: controller.allNotification[index].createdAt, returnFormat: "hh:mm a"),
                date: DateTimeUtility()
                    .parseToLocal(dateTime: controller.allNotification[index].createdAt, returnFormat: "dd.MM.yyyy"),
                  index: controller.allNotification[index].id,
              );
            }):Center(child: Column(children:const [
            Text("No notification to show.")
        ],),)
      );
    });
  }
}
// subTitle: controller.allNotification[index].body,
// title: controller.allNotification[index].title,