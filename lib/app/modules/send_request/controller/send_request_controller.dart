import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:trans_cash_solution/Store/HiveStore.dart';
import 'package:trans_cash_solution/app/modules/home/controller/home_controller.dart';
import 'package:trans_cash_solution/app/modules/send_request/views/invite_screen.dart';

import '../../../../Service/sendRequestService.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/ui.dart';
import '../../../../model/pay_money_model.dart';
import '../../../../model/user_transaction_history_model.dart' as user;
import '../../../../model/user_transaction_history_model.dart';
import '../../../../model/validate_phone_model.dart';
import '../views/send_screen.dart';
import '../views/send_success_screen.dart';

class SendRequestController extends GetxController {
  HomeController homeController = Get.put(HomeController());
  TextEditingController amountTextController = TextEditingController();
  TextEditingController search = TextEditingController();
  TextEditingController message = TextEditingController();
  var contacts = <Contact>[].obs;
  var contactsOnSearch = <Contact>[].obs;
  RxDouble youSend = 0.0.obs;
  RxDouble theyReceived = 0.0.obs;
  var transactionList = <user.Data>[].obs;
  RxBool isSend = false.obs;
   Contact? _contact;
   RxBool isLoading = true.obs;
  final SendRequestService _sendRequestService = SendRequestService();
  @override
  void onInit() {
    var arguments = Get.arguments as Map<String, dynamic>;
    if(arguments!= null){
      isSend.value = arguments["isSend"];
    }
    fetchContact();
    super.onInit();
  }

  void fetchContact() async {
    debugPrint("Fetch contact init method");
    contacts.value = await ContactsService.getContacts();
    contactsOnSearch.value = await ContactsService.getContacts();
    debugPrint("List length:${contacts.length}");
    isLoading.value = false;
  }

  searchPress() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (search.text.isEmpty) {
      print("if block");
        contacts.clear();
        contacts.value = contactsOnSearch;
    } else {
      print("else block");
      _contacts.retainWhere((contact){
        String searchTerm = search.text.toLowerCase();
        String contactName = contact.displayName!.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }
        return false;
      });
      contacts.value = _contacts;
      print("length${contacts.length}");
    }
  }

  Future<void> validateNumberAsRegistered(String? number,String? name) async {
    isLoading.value = true;
    ValidatePhoneModel validatePhoneModel = await _sendRequestService.validatePhone(token: HiveStore().getString(Keys.TOKEN),number: number);
    if (validatePhoneModel.status == 200) {
      isLoading.value = false;
      Get.to(()=>SendScreen(name: name,userId: validatePhoneModel.data!.id,));
    } else if(validatePhoneModel.status == 202){
      isLoading.value = false;
      Get.to(()=>InviteScreen(name: name,));
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "${validatePhoneModel.shortMessage}",
          message: "${validatePhoneModel.longMessage}"));
    }else{
      isLoading.value = false;
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "${validatePhoneModel.shortMessage}",
          message: "${validatePhoneModel.longMessage}"));
    }
  }

  Future<void> sendMoney(String? amount,String? receiverId,String? name) async {
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
    PayMoneyModel payMoneyModel = await _sendRequestService.sendMoney(token: HiveStore().getString(Keys.TOKEN),amount: amount,receiverId: receiverId);
    Get.back();
    if (payMoneyModel.status == 200) {
      // homeController.getUserDetails();
       //fetchUserTransactionDetails(receiverId);
      Get.to(()=>SendSuccessScreen(name: name,amount: amount,userReceiverId: receiverId,));
    } else if(payMoneyModel.status == 202){
       //fetchUserTransactionDetails(receiverId);
      Get.to(()=>SendSuccessScreen(name: name,amount: amount,userReceiverId: receiverId,));
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "${payMoneyModel.longMessage}"));
    }else{
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "${payMoneyModel.shortMessage}",
          message: "${payMoneyModel.longMessage}"));
    }
  }

  Future<void> sendMoneyAgain(String? amount,String? receiverId,String? name) async {
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
    PayMoneyModel payMoneyModel = await _sendRequestService.sendMoney(token: HiveStore().getString(Keys.TOKEN),amount: amount,receiverId: receiverId);
    Get.back();
    if (payMoneyModel.status == 200) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "${payMoneyModel.longMessage}"));
      // homeController.getUserDetails();
       //fetchUserTransactionDetails(receiverId);
      // Get.to(()=>SendSuccessScreen(name: name,amount: amount,userReceiverId: receiverId,));
    } else if(payMoneyModel.status == 202){
      //fetchUserTransactionDetails(receiverId);
      // Get.to(()=>SendSuccessScreen(name: name,amount: amount,userReceiverId: receiverId,));
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "${payMoneyModel.longMessage}"));
    }else{
      Get.showSnackbar(Ui.ErrorSnackBar(
          title: "${payMoneyModel.shortMessage}",
          message: "${payMoneyModel.longMessage}"));
    }
  }

  Future<void> fetchUserTransactionDetails(String? receiverId) async {
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
    UserTransactionHistory userTransactionHistory = await _sendRequestService.fetchUserTransactionDetails(token: HiveStore().getString(Keys.TOKEN),receiverId: receiverId);
    Get.back();
    if (userTransactionHistory.status == 200) {
      youSend.value = userTransactionHistory.totalPay!.toDouble();
      theyReceived.value = userTransactionHistory.totalReceive!.toDouble();
      transactionList.assignAll(userTransactionHistory.data!);
      Get.showSnackbar(Ui.SuccessSnackBar(
          message: "${userTransactionHistory.longMessage}"));
    } else if(userTransactionHistory.status == 202){
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "${userTransactionHistory.longMessage}"));
    }else{
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "${userTransactionHistory.longMessage}"));
    }
  }
}
