import 'dart:developer';

import '../model/pay_money_model.dart';
import '../model/user_transaction_history_model.dart';
import '../model/validate_phone_model.dart';
import '../model/verify_register_resend_otp_model.dart';
import 'CoreService.dart';
import 'GlobalKeys.dart';

class SendRequestService{
  validatePhone({String? token,
    String? number}) async {
    Map data = {
      "phone": number!,
    };
    final response = await CoreService().apiService(
        method: METHOD.POST,
        endpoint: GlobalKeys.verifyNumber,
        body: data,
        header: {"Authorization": "$token"});

    var result = ValidatePhoneModel();
    try {
      result = ValidatePhoneModel.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }

  sendMoney({String? token,
    String? amount,String? receiverId}) async {
    Map data = {
        "amount" : amount,
        "receiver_id": receiverId
    };
    final response = await CoreService().apiService(
        method: METHOD.POST,
        endpoint: GlobalKeys.payMoney,
        body: data,
        header: {"Authorization": "$token"});

    var result = PayMoneyModel();
    try {
      result = PayMoneyModel.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }

  fetchUserTransactionDetails({String? token,
    String? receiverId}) async {
    Map data = {
      "user_id": receiverId
    };
    final response = await CoreService().apiService(
        method: METHOD.POST,
        endpoint: GlobalKeys.userTransactionDetails,
        body: data,
        header: {"Authorization": "$token"});

    var result = UserTransactionHistory();
    try {
      result = UserTransactionHistory.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }
}