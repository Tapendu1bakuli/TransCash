import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/app/modules/home/controller/activity_controller.dart';
import 'package:trans_cash_solution/app/modules/home/controller/home_controller.dart';
import 'package:trans_cash_solution/app/modules/wallet_section/controller/wallet_controller.dart';
import 'package:trans_cash_solution/common/widgets/required_text_field.dart';
import '../../../../common/device_manager/assets.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/strings.dart';
import '../../../../common/device_manager/text_styles.dart';
import '../../../../common/ui.dart';
import '../../../../common/widgets/app_button.dart';
import '../../../../common/widgets/frame.dart';

class WalletScreen extends StatelessWidget {
  ActivityController activityController = Get.put(ActivityController());
  WalletController walletController = Get.put(WalletController());
  HomeController homeController = Get.put(HomeController());

  WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetX<ActivityController>(initState: (state) {
      Future.delayed(const Duration(milliseconds: 100), () {
        activityController.allBanks.clear();
        activityController.fetchAllCardDetailsForAddMoney();
        activityController.fetchBankDetails();
        homeController.getUserTotalMoney();
      });
    }, builder: (_) {
      debugPrint("all cards length:${activityController.allCards.length}");
      return Frame(
        onTap: () {
          activityController.allTransactionsFromWalletScreen();
        },
        formKey: walletController.walletFormKey,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        color: Theme.of(context).scaffoldBackgroundColor,
        topWidget: true,
        content: Column(children: [
          walletFirstCard(context),
          walletSecondCard(context),
          walletThirdCard(context)
        ]),
      );
    });
  }

  showAlertDialog(BuildContext context, String? amount) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Theme.of(context).canvasColor,
      title: Column(
        children: [
          Container(
            height: ScreenConstant.defaultHeightForty,
          ),
          Container(
              height: ScreenConstant.defaultHeightOneHundred,
              child:
                  Image.asset("assets/icons/solar_letter-opened-broken.png")),
          Container(
            height: 3.ss,
          ),
          Text(
            "Request Sent",
            style: TextStyle(
                color: Color(0xff31AD00),
                fontWeight: FontWeight.w700,
                fontSize: 18.fss),
          ),
          Container(
            height: 14.ss,
          ),
          Text(
            "By presenting your id Proof in the office, you can withdraw money immediately.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xff31AD00),
              fontWeight: FontWeight.w400,
              fontSize: 18.fss,
            ),
          ),
          Container(
            height: 19.ss,
          ),
        ],
      ),
      content: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          walletController
              .withdrawMoney(walletController.walletAmountRequest.text);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenConstant.sizeLarge,
              vertical: ScreenConstant.defaultWidthForty),
          child: Container(
            width: .8.sw,
            height: 45.ss,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF31AD00), width: 1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                "Confirm",
                style: TextStyle(
                  color: const Color(0xFF31AD00),
                  fontSize: FontSize.s16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Padding walletThirdCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightTen),
      child: Card(
        color: Theme.of(context).canvasColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.dividerColor2, width: 1),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: ScreenConstant.spacingAllLarge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(AppLabels.withDrawFrom,
                      style: Theme.of(context).textTheme.bodyMedium),
                  Container(
                    width: ScreenConstant.sizeExtraSmall,
                  ),
                  Text(AppLabels.wallet, style: TextStyles.walletText),
                ],
              ),
              Container(
                height: ScreenConstant.defaultHeightTwentyThree,
              ),
              RequireTextField(
                controller: walletController.walletAmountRequest,
                type: Type.amount,
                hintText: "\$ 2560",
              ),
              Container(
                height: ScreenConstant.defaultHeightTwentyThree,
              ),
              InkWell(
                onTap: () {
                  if (walletController.walletAmountRequest.text != "" &&
                      walletController.walletAmountRequest.text != "0") {
                    showAlertDialog(
                        context, walletController.walletAmountRequest.text);
                  } else {
                    Get.showSnackbar(Ui.ErrorSnackBar(
                        message: "Kindly provide valid amount."));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenConstant.sizeLarge),
                  child: Container(
                    width: .8.sw,
                    height: 45.ss,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF31AD00), width: 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        "Send Request",
                        style: TextStyle(
                          color: Color(0xFF31AD00),
                          fontSize: FontSize.s16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding walletSecondCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenConstant.defaultHeightTen),
      child: Card(
        color: Theme.of(context).canvasColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.dividerColor2, width: 1),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: ScreenConstant.spacingAllLarge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(AppLabels.addMoneyTo,
                      style: Theme.of(context).textTheme.bodyMedium),
                  Container(
                    width: ScreenConstant.sizeExtraSmall,
                  ),
                  Text(AppLabels.wallet, style: TextStyles.walletText),
                ],
              ),
              Container(
                height: ScreenConstant.defaultHeightTwentyThree,
              ),
              RequireTextField(
                controller: walletController.walletAmount,
                type: Type.amount,
                hintText: "\$ 1000",
              ),
              Container(
                height: ScreenConstant.defaultHeightTwentyThree,
              ),
              Padding(
                padding: EdgeInsets.only(left: ScreenConstant.sizeMidLarge),
                child: AppButton(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                  buttonHeight: ScreenConstant.sizeXXXL,
                  buttonIconEnabled: true,
                  buttonText: AppLabels.proceedToPay.tr,
                  buttonTextStyle: TextStyles.buttonTitle,
                  iconButton: true,
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (activityController.allCards.isNotEmpty) {
                      if (walletController.walletAmount.text.isNotEmpty) {
                        if (double.parse(walletController.walletAmount.text) <=
                            0.0) {
                          Get.showSnackbar(Ui.ErrorSnackBar(
                              title: "Amount is empty",
                              message: "Kindly enter valid amount."));
                        } else {
                          if (walletController.walletFormKey.currentState!
                              .validate()) {
                            walletController.walletFormKey.currentState!.save();
                            Get.closeAllSnackbars();
                            walletController.showBottomSheetOfLists();
                          } else {
                            Get.showSnackbar(Ui.ErrorSnackBar(
                                title: "Amount is empty",
                                message: "Kindly enter amount."));
                          }
                        }
                      } else {
                        Get.showSnackbar(Ui.ErrorSnackBar(
                            title: "Amount is empty",
                            message: "Kindly enter amount."));
                      }
                    } else {
                      Get.showSnackbar(Ui.ErrorSnackBar(
                          title: "Add card first",
                          message: "Kindly add card first."));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding walletFirstCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: ScreenConstant.defaultHeightTwentyThree),
      child: Card(
        color: Theme.of(context).canvasColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.dividerColor2, width: 1),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: ScreenConstant.spacingAllLarge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppLabels.walletBalance,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Expanded(
                    child: Container(
                      width: ScreenConstant.defaultHeightTen,
                    ),
                  ),
                  SvgPicture.asset(
                    Assets.walletIcon,
                    color: Theme.of(context).indicatorColor,
                  )
                ],
              ),
              Text(
                "\$ ${homeController.totalWalletMoney.value}",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Container(
                height: ScreenConstant.defaultHeightTwentyThree,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        height: ScreenConstant.defaultHeightForty,
                        width: ScreenConstant.defaultHeightForty,
                        decoration: BoxDecoration(
                            color: AppColors.activityDetailsShareDesignColor,
                            border: Border.all(color: AppColors.dividerColor2),
                            shape: BoxShape.circle),
                        child: Padding(
                          padding: ScreenConstant.spacingAllExtraSmall,
                          child: SvgPicture.asset(
                            Assets.bankTransferIcon,
                          ),
                        ),
                      ),
                      Container(
                        height: ScreenConstant.defaultHeightTen,
                      ),
                      Text(
                        AppLabels.transferToBank,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: ScreenConstant.defaultHeightForty,
                        width: ScreenConstant.defaultHeightForty,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.dividerColor2),
                            color: AppColors.activityDetailsShareDesignColor,
                            shape: BoxShape.circle),
                        child: Padding(
                          padding: ScreenConstant.spacingAllDefault,
                          child: SvgPicture.asset(
                            Assets.addMoneyIcon,
                          ),
                        ),
                      ),
                      Container(
                        height: ScreenConstant.defaultHeightTen,
                      ),
                      Text(
                        AppLabels.automaticAddMoney,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  )
                ],
              ),
              Container(
                height: ScreenConstant.defaultHeightTen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
