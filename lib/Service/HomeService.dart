import 'dart:developer';
import 'package:trans_cash_solution/model/all_notification_model.dart';
import 'package:trans_cash_solution/model/delete_notification_model.dart';
import 'package:trans_cash_solution/model/profile_update_model.dart';
import 'package:trans_cash_solution/model/user_model.dart';
import 'CoreService.dart';
import 'GlobalKeys.dart';

class HomeServices {
  getUserDetails(String? token) async {
    final response = await CoreService().apiService(
        method: METHOD.GET,
        endpoint: GlobalKeys.userDetails,
        header: {"Authorization": "$token"});

    var result = UserModel();
    try {
      result = UserModel.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }

  deleteNotification(int? index,String? token) async {
    Map data = {
      "notification_id" : index
    };
    final response = await CoreService().apiService(
      method: METHOD.POST,
      body: data,
      endpoint: GlobalKeys.deleteNotification,

      header: {"Authorization": "$token"}
    );
    var result = DeleteNotificationModel();
    try {
      result = DeleteNotificationModel.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }

  getAllNotification(String? token) async {
    final response = await CoreService().apiService(
        method: METHOD.POST,
        endpoint: GlobalKeys.fetchAllNotification,
        header: {"Authorization": "$token"});

    var result = AllNotificationModel();
    try {
      result = AllNotificationModel.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }

  updateProfile({
    String? token,
    String? name,
    String? profileImage,
  }) async {
    Map<String, String> data = {
      "name": name!,
    };
    final response = profileImage != ""
        ? await CoreService().apiService(
            endpoint: GlobalKeys.profileUpdate,
            method: METHOD.MULTIPART,
            filePath: profileImage,
            fileKey: "profile_image",
            body: data,
            header: {"Authorization": "$token"})
        : await CoreService().apiService(
            endpoint: GlobalKeys.profileUpdate,
            method: METHOD.POST,
            body: data,
            header: {"Authorization": "$token"});

    var result = UpdateProfileModel();
    try {
      result = UpdateProfileModel.fromJson(response);
    } catch (e) {
      log("Error while parsing:$e");
    }
    return result;
  }
}
