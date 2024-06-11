import 'dart:developer';

import 'package:trans_cash_solution/model/all_notification_model.dart';
import 'package:trans_cash_solution/model/delete_card_model.dart';
import 'package:trans_cash_solution/model/saved_card_model.dart';

import '../../../../Service/CoreService.dart';
import '../../../../Service/GlobalKeys.dart';
import '../../../../model/add_bank_response_model.dart';
import '../../../../model/add_card_model.dart';
import '../../../../model/fet_all_card_model.dart';
import '../../../../model/transaction_history_model.dart';

class ActivityService {
  //Add card
  addCardDetails(
      {String? fullName,
      String? cardNumber,
      int? expiryMonth,
      int? expiryYear,
      String? token}) async {
    Map data = {
      "name": fullName,
      "number": cardNumber,
      "exp_month": expiryMonth,
      "exp_year": expiryYear,
    };
    final response = await CoreService().apiService(
        endpoint: GlobalKeys.addCard,
        body: data,
        header: {"Authorization": "$token"});

    var result = AddCardModel();
    try {
      result = AddCardModel.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }

  //Fetch Cards
  fetchSavedCards({String? token}) async {
    final response = await CoreService().apiService(
      method: METHOD.GET,
      endpoint: GlobalKeys.fetchSavedCards,
      header: {"Authorization" : "$token"}
    );
    var result = SavedCardModel();
    try{
      result = SavedCardModel.fromJson(response);
    }catch(e){
      log("Error while parsing:$e");
    }
    return result;
  }

  fetchSavedBanks({String? token}) async {
    final response = await CoreService().apiService(
        method: METHOD.GET,
        endpoint: GlobalKeys.fetchSavedBanks,
        header: {"Authorization" : "$token"}
    );
    var result = FetchAllBankModel();
    try{
      result = FetchAllBankModel.fromJson(response);
    }catch(e){
      log("Error while parsing:$e");
    }
    return result;
  }

  //Delete Cards
  deleteSavedCards({String? token,int? index}) async {
    Map data = {
      "card_id" : index
    };
    final response = await CoreService().apiService(
        body: data,
        method: METHOD.POST,
        endpoint: GlobalKeys.deleteCard,
        header: {"Authorization" : "$token"}
    );
    var result = DeleteCardModel();
    try{
      result = DeleteCardModel.fromJson(response);
    }catch(e){
      log("Error while parsing:$e");
    }
    return result;
  }

  allTransactions({String? token}) async{
    final response = await CoreService().apiService(
      method: METHOD.POST,
      endpoint: GlobalKeys.allTransactions,
      header: {"Authorization" : "$token"}
    );
    var result = TransactionHistoryModel();
    try{
      result = TransactionHistoryModel.fromJson(response);
    }catch(e){
      log("Error while parsing:$e");
    }
    return result;
  }

  addBanks({String? token,String? name,String? accountNumber,String? bankName,String? ifscCode,String? accountType}) async {
    Map data = {
      "acc_holder_name": name,
      "acc_number":accountNumber,
      "bank_name": bankName,
      "ifsc_code": ifscCode,
      "type":accountType
    };
    final response = await CoreService().apiService(
        body: data,
        method: METHOD.POST,
        endpoint: GlobalKeys.addBank,
        header: {"Authorization" : "$token"}
    );
    var result = AddBankResponseModel();
    try{
      result = AddBankResponseModel.fromJson(response);
    }catch(e){
      log("Error while parsing:$e");
    }
    return result;
  }
}
