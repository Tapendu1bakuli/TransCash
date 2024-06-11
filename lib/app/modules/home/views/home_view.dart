import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/app/modules/home/views/activity_details_screen.dart';
import 'package:trans_cash_solution/app/modules/home/widgets/home_card.dart';
import 'package:trans_cash_solution/common/device_manager/colors.dart';
import 'package:trans_cash_solution/common/device_manager/screen_constants.dart';
import 'package:trans_cash_solution/common/device_manager/text_styles.dart';
import '../../../../Store/HiveStore.dart';
import '../../../../common/device_manager/assets.dart';
import '../../../../common/widgets/frame.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/profile_icon.dart';
import '../controller/activity_controller.dart';
import '../controller/home_controller.dart';
import '../widgets/home_recent_activity_card.dart';

class HomeView extends GetView<HomeController> {
  ActivityController activityController = Get.put(ActivityController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(initState: (state) {
      Future.delayed(const Duration(milliseconds: 200), () {
        controller.fetchAllNotification();
        activityController.allTransactions();
      });
    }, builder: (_) {
      debugPrint(controller.allNotification.length.toString());
      return Frame(
        color: Theme.of(context).scaffoldBackgroundColor,
        isStack: true,
        content: Stack(children: [
          Obx(() => stackFirstChildren(context)),
          stackSecondChildren(context),
        ]),
      );
    });
  }

  Positioned stackSecondChildren(context) {
    return Positioned(
      top: .36.sh,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 20.0.ss, top: 35.ss, bottom: 15.ss),
              child: Text(
                "Recent activity",
                style: Get.textTheme.displayLarge
              ),
            ),
            Expanded(
                child: activityController.allTransactionsList.length
                        .isGreaterThan(0)
                    ? ListView.builder(
                        padding: EdgeInsets.all(5.ss),
                        shrinkWrap: true,
                        itemCount: activityController.allTransactionsList.length <= 5?activityController.allTransactionsList.length:5,
                        itemBuilder: (BuildContext context, int index) {
                          return HomeRecentActivityCard(
                            amount: activityController
                                .allTransactionsList[index].amount,
                            subTitle: activityController
                                .allTransactionsList[index].date,
                            titleTextStyle: Theme.of(context).textTheme.displayMedium,
                            subTitleTextStyle: TextStyle(
                              color: const Color(0xFF31AD00),
                              fontSize: FontSize.s12,
                            ),
                            leading: activityController
                                .allTransactionsList[index]
                                .senderDetails!
                                .profilePhoto,
                            title: activityController
                                .allTransactionsList[index].senderDetails!.name,
                            onDetailsTap: () {
                              Get.to(()=>ActivityDetailsScreen(
                                status: activityController.allTransactionsList[index].status,
                                id: activityController
                                    .allTransactionsList[index].id,
                                name: activityController.allTransactionsList[index].senderDetails!.name,
                                countryCode: activityController
                                    .allTransactionsList[index]
                                    .senderDetails!
                                    .countryCode,
                                contactNumber: activityController
                                    .allTransactionsList[index]
                                    .senderDetails!
                                    .phone,
                                date: activityController
                                    .allTransactionsList[index].date,
                                amount: activityController.allTransactionsList[index].amount,
                              ));
                            },
                          );
                        })
                    : Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [Text("No Transactions Yet.")],
                        ),
                      )),
          ],
        ),
      ),
    );
  }

  Positioned stackFirstChildren(BuildContext context) {
    return Positioned(
      top: ScreenConstant.sizeUltraXXXL,
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0.ss),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.PROFILE);
                  },
                  child: Stack(
                    children: [
                      ProfileIcon(
                          borderRadious: 15,
                          height: 50.ss,
                          width: 50.ss,
                          image: controller.profileImage.value.isNotEmpty
                              ? controller.profileImage.value
                              : HiveStore().getString(Keys.USEREPROFILEIMAGE)),
                      Positioned(
                        right: 1,
                        bottom: 0,
                        child: Container(
                          height: 10.ss,
                          width: 10.ss,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1),
                              color: const Color(0xFF31AD00),
                              shape: BoxShape.circle),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    controller.isNotificationPage.value = true;
                    Get.toNamed(Routes.NOTIFICATIONS);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.0.ss),
                    child: /*controller.allNotification.length.isGreaterThan(0)
                        ? Badge(
                            position: BadgePosition.topEnd(
                              top: -0.009.sh,
                              end: -0.009.sh,
                            ),
                            badgeStyle:
                                const BadgeStyle(badgeColor: Color(0xFF31AD00)),
                            badgeContent: Text(
                              controller.allNotification.length.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                            child: SvgPicture.asset(
                              Assets.notificationIcon,color: Theme.of(context).indicatorColor,
                            ),
                          )
                        : */SvgPicture.asset(
                            Assets.notificationIcon,
                          ),
                  ))
            ],
          ),
          Container(
            height: 50.ss,
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.0.ss, right: 5.ss),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeCard(
                  lableText: "Send",
                  icon: Assets.sendIcon,
                  onTap: () async {
                    controller.getUserDetails();
                    Get.back();
                    PermissionStatus? contactStatus =
                        await Permission.contacts.request();
                    if (contactStatus == PermissionStatus.granted) {
                      Get.toNamed(Routes.CONTACTSCREEN,
                          arguments: {"isSend": true});
                    } else {
                      Widget cancelButton = TextButton(
                        child: Text("Cancel", style: TextStyles.toggleNo),
                        onPressed: () {
                          Get.back();
                        },
                      );
                      Widget continueButton = TextButton(
                        child: Text("Settings",
                            style: TextStyles.availableTextGreen),
                        onPressed: () async {
                          Get.back();
                          openAppSettings();
                        },
                      );

                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: const Text(
                          "Sorry!",
                        ),
                        content: const Text(
                          "Please update your contact permission from the app settings.",
                        ),
                        actions: [
                          cancelButton,
                          continueButton,
                        ],
                      );

                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }
                  },
                ),
                HomeCard(
                  lableText: "Request",
                  icon: Assets.requestIcon,
                  onTap: () async {
                    controller.getUserDetails();
                    Get.back();
                    PermissionStatus? contactStatus =
                    await Permission.contacts.request();
                    if (contactStatus == PermissionStatus.granted) {
                      Get.toNamed(Routes.CONTACTSCREEN,
                          arguments: {"isSend": false});
                    } else {
                      Widget cancelButton = TextButton(
                        child: Text("Cancel", style: TextStyles.toggleNo),
                        onPressed: () {
                          Get.back();
                        },
                      );
                      Widget continueButton = TextButton(
                        child: Text("Settings",
                            style: TextStyles.availableTextGreen),
                        onPressed: () async {
                          Get.back();
                          openAppSettings();
                        },
                      );

                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: const Text(
                          "Sorry!",
                        ),
                        content: const Text(
                          "Please update your contact permission from the app settings.",
                        ),
                        actions: [
                          cancelButton,
                          continueButton,
                        ],
                      );

                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }
                  },
                ),
                HomeCard(
                  lableText: "Wallet",
                  icon: Assets.walletIcon,
                  onTap: () {
                    Get.toNamed(Routes.WALLETSCREEN);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
