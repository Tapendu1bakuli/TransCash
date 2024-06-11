import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/common/helper.dart';
import 'package:trans_cash_solution/model/transaction_history_model.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/text_styles.dart';
import '../../../modules/home/controller/activity_controller.dart';
import '../../../routes/app_routes.dart';
import '../widgets/home_recent_activity_card.dart';
import 'activity_details_screen.dart';

class ActivityListScreen extends GetView<ActivityController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetX<ActivityController>(initState: (state) {
      Future.delayed(const Duration(milliseconds: 100), () {
      controller.allTransactions();
      });
    }, builder: (_) {
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: ListView.builder(
      padding: EdgeInsets.all(5.ss),
      shrinkWrap: true,
      itemCount: controller.allTransactionsList.length,
      itemBuilder: (BuildContext context, int index) {
      return HomeRecentActivityCard(
      amount: controller.allTransactionsList[index].amount,
      subTitle: controller.allTransactionsList[index].date,
        subTitleTextStyle: TextStyle(
          color: const Color(0xFF31AD00),
          fontSize: FontSize.s12,
        ),
        titleTextStyle: TextStyle(
          color: const Color(0xFF3A3A3A),
          fontSize: FontSize.s18,
        ),
      leading: controller.allTransactionsList[index].senderDetails!.profilePhoto,
      title: controller.allTransactionsList[index].senderDetails!.name,
      onDetailsTap: () {
        Get.to(()=>ActivityDetailsScreen(
          status: controller.allTransactionsList[index].status,
          id: controller
              .allTransactionsList[index].id,
          name: controller.allTransactionsList[index].senderDetails!.name,
          countryCode: controller
              .allTransactionsList[index]
              .senderDetails!
              .countryCode,
          contactNumber: controller
              .allTransactionsList[index]
              .senderDetails!
              .phone,
          date: controller
              .allTransactionsList[index].date,
          amount: controller.allTransactionsList[index].amount,
        ));
      },
      );
      }),
    );
    });
  }
}
