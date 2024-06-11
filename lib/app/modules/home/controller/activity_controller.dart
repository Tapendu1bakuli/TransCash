import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:trans_cash_solution/app/modules/home/service/activity_service.dart';
import 'package:trans_cash_solution/model/add_card_model.dart';
import 'package:trans_cash_solution/model/delete_card_model.dart';
import 'package:trans_cash_solution/model/saved_card_model.dart' as cards;
import 'package:trans_cash_solution/model/transaction_history_model.dart' as transaction;
import '../../../../Service/payment_card_service.dart';
import '../../../../Store/HiveStore.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/ui.dart';
import '../../../../model/add_bank_response_model.dart';
import '../../../../model/fet_all_card_model.dart' as banks;
import '../../../../model/fet_all_card_model.dart';
import '../../../../model/saved_card_model.dart';
import '../../../../model/transaction_history_model.dart';

class ActivityController extends GetxController {
  ScreenshotController screenshotController = ScreenshotController();
  RxBool isAddCardScreenActivated = false.obs;
  RxBool isAddBankAccountScreenActivated = false.obs;
  final formKeyCheckout = GlobalKey<FormState>();
  final formKeyBankAccountCheckout = GlobalKey<FormState>();
  TextEditingController nameInCardController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  Rx<CardType> paymentCard = CardType.Others.obs;
  RxBool checkBoxForCheckOut = false.obs;
  RxBool validateCheckout = false.obs;
  RxBool validateBankAccountCheckout = false.obs;
  RxBool isDeleteOptionEnabled = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingCheckout = false.obs;
  CardType? cardTypeImage;
  final ActivityService _activityService = ActivityService();
  var allCards = <cards.Data>[].obs;
  var allBanks = <banks.Data>[].obs;
  var allTransactionsList = <transaction.Data>[].obs;
  var selectedDrowpdown = 'Personal'.obs;
  List dropdownText = ['Personal', 'Saving', 'Checking'];

  @override
  void onInit() {
    paymentCard.value = CardType.Others;
    cardNumberController.addListener(getCardTypeFrmNumber);
  }

  getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(cardNumberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    paymentCard.value = cardType;
    debugPrint("getCardTypefromnumber:${paymentCard.value}");
    cardTypeImage = paymentCard.value;
    debugPrint("payment.value:${cardTypeImage}");
    // return cardType;
  }

  void addCardDetails() async {
    Get.focusScope!.unfocus();
    if (formKeyCheckout.currentState!.validate()) {
      isLoading.value = true;
      formKeyCheckout.currentState!.save();
      if (nameInCardController.text.isNotEmpty &&
          cardNumberController.text.isNotEmpty &&
          expiryController.text.isNotEmpty) {
        if (formKeyCheckout.currentState!.validate()) {
          formKeyCheckout.currentState?.save();
          AddCardModel addCardModel = await _activityService.addCardDetails(
              fullName: nameInCardController.text,
              cardNumber: cardNumberController.text,
              expiryMonth: int.parse(expiryController.text.split("/").first),
              expiryYear: int.parse(expiryController.text.split("/").last),
              token: HiveStore().getString(Keys.TOKEN));
          if (addCardModel.status == 200) {
            fetchCardDetails();
            nameInCardController.text = "";
            cardNumberController.text = "";
            expiryController.text = "";
            cvvController.text = "";
            isLoading.value = false;
            isAddCardScreenActivated.value = false;
            Get.showSnackbar(Ui.SuccessSnackBar(
                title: "${addCardModel.shortMessage}",
                message: "${addCardModel.longMessage}"));
          } else {
            nameInCardController.text = "";
            cardNumberController.text = "";
            expiryController.text = "";
            cvvController.text = "";
            isLoading.value = false;
            Get.showSnackbar(Ui.ErrorSnackBar(
                title: "${addCardModel.shortMessage}",
                message: "${addCardModel.longMessage}"));
          }
        }
      } else {
        isLoading.value = false;
        Get.showSnackbar(Ui.ErrorSnackBar(
            title: "Fields are empty", message: "All fields is required."));
      }
    }
    Get.back();
  }

  void addBankDetails() async {
    Get.focusScope!.unfocus();
    if (formKeyBankAccountCheckout.currentState!.validate()) {
      isLoading.value = true;
      formKeyBankAccountCheckout.currentState!.save();
      if (accountHolderNameController.text.isNotEmpty &&
          accountNumberController.text.isNotEmpty &&
          bankNameController.text.isNotEmpty &&
          ifscCodeController.text.isNotEmpty
      ) {
        if (formKeyBankAccountCheckout.currentState!.validate()) {
          formKeyBankAccountCheckout.currentState?.save();
          AddBankResponseModel addBankResponseModel = await _activityService.addBanks(
              name: accountHolderNameController.text,
              accountNumber: accountNumberController.text,
              accountType: selectedDrowpdown.value,
              ifscCode: ifscCodeController.text,
              bankName: bankNameController.text,
              token: HiveStore().getString(Keys.TOKEN));
          if (addBankResponseModel.status == 200) {
            fetchBankDetails();
          accountHolderNameController.text = "";
          selectedDrowpdown = "".obs;
          accountNumberController.text = "";
          ifscCodeController.text = "";
          bankNameController.text = "";
            isLoading.value = false;
            isAddCardScreenActivated.value = false;
            Get.showSnackbar(Ui.SuccessSnackBar(
                title: "${addBankResponseModel.shortMessage}",
                message: "${addBankResponseModel.longMessage}"));
          } else {
            nameInCardController.text = "";
            cardNumberController.text = "";
            expiryController.text = "";
            cvvController.text = "";
            isLoading.value = false;
            Get.showSnackbar(Ui.ErrorSnackBar(
                title: "${addBankResponseModel.shortMessage}",
                message: "${addBankResponseModel.longMessage}"));
          }
        }
      } else {
        isLoading.value = false;
        Get.showSnackbar(Ui.ErrorSnackBar(
            title: "Fields are empty", message: "All fields is required."));
      }
    }
    Get.back();
  }

  fetchCardDetails() async {
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
    SavedCardModel savedCardModel = await _activityService.fetchSavedCards(
        token: HiveStore().getString(Keys.TOKEN));
    Get.back();
    if (savedCardModel.status == 200) {
      allCards.assignAll(savedCardModel.data!);
      Get.showSnackbar(Ui.SuccessSnackBar(
          title: "${savedCardModel.shortMessage}",
          message: "${savedCardModel.longMessage}"));
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "${savedCardModel.shortMessage}",
          message: "${savedCardModel.longMessage}"));
    }
    Get.back();
  }

  fetchBankDetails() async {
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
    FetchAllBankModel fetchAllBankModel = await _activityService.fetchSavedBanks(
        token: HiveStore().getString(Keys.TOKEN));
    Get.back();
    if (fetchAllBankModel.status == 200) {
      allBanks.addAll(fetchAllBankModel.data!);
      debugPrint("all banks length:${allBanks.length}");
      Get.showSnackbar(Ui.SuccessSnackBar(
          title: "${fetchAllBankModel.shortMessage}",
          message: "${fetchAllBankModel.longMessage}"));
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "${fetchAllBankModel.shortMessage}",
          message: "${fetchAllBankModel.longMessage}"));
    }
    Get.back();
  }

  fetchAllCardDetailsForAddMoney() async {
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
    SavedCardModel savedCardModel = await _activityService.fetchSavedCards(
        token: HiveStore().getString(Keys.TOKEN));
    if (savedCardModel.status == 200) {
      allCards.assignAll(savedCardModel.data!);
      Get.showSnackbar(Ui.SuccessSnackBar(
          title: "${savedCardModel.shortMessage}",
          message: "${savedCardModel.longMessage}"));
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "${savedCardModel.shortMessage}",
          message: "${savedCardModel.longMessage}"));
    }
    Get.back();
  }

  deleteCard(int? index) async {
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
    DeleteCardModel deleteCardModel = await _activityService.deleteSavedCards(
        token: HiveStore().getString(Keys.TOKEN),index: index);
    if (deleteCardModel.status == 200) {
      Get.back();
      fetchCardDetails();
      Get.showSnackbar(Ui.SuccessSnackBar(
          title: "${deleteCardModel.shortMessage}",
          message: "${deleteCardModel.longMessage}"));
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "${deleteCardModel.shortMessage}",
          message: "${deleteCardModel.longMessage}"));
    }
    Get.back();
  }

  allTransactions() async {
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
    TransactionHistoryModel transactionHistoryModel = await _activityService.allTransactions(
        token: HiveStore().getString(Keys.TOKEN));
    Get.back();
    if (transactionHistoryModel.status == 200) {
      allTransactionsList.assignAll(transactionHistoryModel.data!);
      debugPrint("allTransactionList size ${allTransactionsList.length}");
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "${transactionHistoryModel.longMessage}"));
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "${transactionHistoryModel.longMessage}"));
    }
    Get.back();
  }

  allTransactionsFromWalletScreen() async {
    Get.back();
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
    TransactionHistoryModel transactionHistoryModel = await _activityService.allTransactions(
        token: HiveStore().getString(Keys.TOKEN));
    Get.back();
    if (transactionHistoryModel.status == 200) {
      allTransactionsList.assignAll(transactionHistoryModel.data!);
      debugPrint("allTransactionList size ${allTransactionsList.length}");
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "${transactionHistoryModel.longMessage}"));
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "${transactionHistoryModel.longMessage}"));
    }
    Get.back();
  }
}
