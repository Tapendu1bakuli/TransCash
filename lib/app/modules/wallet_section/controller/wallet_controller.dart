import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/app/modules/home/controller/activity_controller.dart';
import 'package:trans_cash_solution/app/modules/home/controller/home_controller.dart';
import 'package:trans_cash_solution/app/modules/wallet_section/service/wallet_service.dart';
import 'package:trans_cash_solution/model/withdraw_money_model.dart';

import '../../../../Store/HiveStore.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/ui.dart';
import '../../../../model/add_money_to_wallet_model.dart';
import '../../../../model/added_money_using_paypal_model.dart';
import '../views/bottom_sheet_lists_of_cards.dart';

class WalletController extends GetxController {
  HomeController homeController = Get.put(HomeController());
  ActivityController activityController = Get.put(ActivityController());
  GlobalKey<FormState> walletFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> cvvFormKey = GlobalKey<FormState>();
  TextEditingController walletAmount = TextEditingController();
  TextEditingController walletAmountRequest = TextEditingController();
  RxBool isLoading = false.obs;
  final WalletService _walletService = WalletService();

    // TODO: implement dependencies
    void showBottomSheetOfLists() {
      debugPrint("showBottomSheetOfLists");
      Get.bottomSheet(
        DraggableScrollableSheet(
          initialChildSize: 1,
          minChildSize: 1,
          maxChildSize: 1,
          builder: (_,controller) {
            return BottomSheetOfLists();
          },
        ),
        barrierColor: Colors.transparent,
        isDismissible: false,
      );
    }

  void addMoneyToWallet(String? id) async {
    Get.dialog(
        Center(
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(40)),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: AppColors.appPrimaryColor,
              ),
            ),
          ),
        ),
        barrierDismissible: false);
    Get.focusScope!.unfocus();
    if (walletFormKey.currentState!.validate()) {
      walletFormKey.currentState!.save();
      if (walletAmount.text.isNotEmpty &&
          activityController.cvvController.text.isNotEmpty) {
        if (walletFormKey.currentState!.validate()) {
          walletFormKey.currentState?.save();
          AddMoneyToWalletModel addMoneyToWalletModel = await _walletService.addMoneyToWallet(
            amount: walletAmount.text,
              cvv: activityController.cvvController.text,
              card_id: id,
              token: HiveStore().getString(Keys.TOKEN));
           Get.back();
          if (addMoneyToWalletModel.status == 200) {
            activityController.cvvController.text = "";
            walletAmount.text = "";
            homeController.getUserTotalMoney();
            Get.showSnackbar(Ui.SuccessSnackBar(
                title: "${addMoneyToWalletModel.shortMessage}",
                message: "${addMoneyToWalletModel.longMessage}"));
          } else {Get.showSnackbar(Ui.ErrorSnackBar(
                title: "${addMoneyToWalletModel.shortMessage}",
                message: "${addMoneyToWalletModel.longMessage}"));
          }
        }
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(
            title: "Fields are empty", message: "All fields is required."));
      }
    }
    Get.back();
  }

  void addMoneyToWalletUsingPayPal(String? amount) async {
    Get.dialog(
        Center(
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(40)),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: AppColors.appPrimaryColor,
              ),
            ),
          ),
        ),
        barrierDismissible: false);
    AddedMoneyUsingPaypalModel addedMoneyUsingPaypalModel = await _walletService.addMoneyToWalletUsingPaypal(
              amount: amount,
              token: HiveStore().getString(Keys.TOKEN));
    if (addedMoneyUsingPaypalModel.status == 200) {
            Get.showSnackbar(Ui.SuccessSnackBar(
                message: "${addedMoneyUsingPaypalModel.longMessage}"));
            homeController.getUserTotalMoneyAfterPaypalSuccessful();
          } else {
            homeController.getUserTotalMoneyAfterPaypalSuccessful();
            Get.showSnackbar(Ui.ErrorSnackBar(
              message: "${addedMoneyUsingPaypalModel.longMessage}"));
          }
  }

  void withdrawMoney(String? amount) async {
    Get.dialog(
        Center(
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(40)),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: AppColors.appPrimaryColor,
              ),
            ),
          ),
        ),
        barrierDismissible: false);
    WithdrawMoneyModel withdrawMoneyModel = await _walletService.withdrawMoney(
      amount: amount,
      token: HiveStore().getString(Keys.TOKEN)
    );
    if(withdrawMoneyModel.status==200){
      walletAmountRequest.text = "";
      Get.back();
      Get.back();
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "${withdrawMoneyModel.longMessage}"));
    }else{
      walletAmountRequest.text = "";
      Get.back();
      Get.back();
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "${withdrawMoneyModel.longMessage}"));
    }
  }


  @override
  void dependencies() {
    // TODO: implement dependencies
  }
  }

