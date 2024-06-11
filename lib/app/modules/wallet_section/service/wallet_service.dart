import 'dart:developer';

import 'package:trans_cash_solution/model/withdraw_money_model.dart';

import '../../../../Service/CoreService.dart';
import '../../../../Service/GlobalKeys.dart';
import '../../../../model/add_money_to_wallet_model.dart';
import '../../../../model/added_money_using_paypal_model.dart';

class WalletService {
  //Add money to wallet
  addMoneyToWallet({String? amount, String? cvv, String? card_id, String? token})async{
    Map data = {
      "amount": amount,
      "cvc": cvv,
      "card_id": card_id,
    };
    final response = await CoreService().apiService(
      endpoint: GlobalKeys.addMoneyToWallet,
      body: data,
        header: {"Authorization": "$token"}
    );
    var result = AddMoneyToWalletModel();
    try {
      result = AddMoneyToWalletModel.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }

  //Add money to wallet using Paypal
  addMoneyToWalletUsingPaypal({String? amount,  String? token})async{
    Map data = {
      "amount": amount,
    };
    final response = await CoreService().apiService(
        endpoint: GlobalKeys.addMoneyUsingPaypal,
        body: data,
        header: {"Authorization": "$token"}
    );
    var result = AddedMoneyUsingPaypalModel();
    try {
      result = AddedMoneyUsingPaypalModel.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }

  //Withdraw request
  withdrawMoney({String? amount,  String? token})async{
    Map data = {
      "amount": amount,
    };
    final response = await CoreService().apiService(
        endpoint: GlobalKeys.moneyRequest,
        body: data,
        header: {"Authorization": "$token"}
    );
    var result = WithdrawMoneyModel();
    try {
      result = WithdrawMoneyModel.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }
}