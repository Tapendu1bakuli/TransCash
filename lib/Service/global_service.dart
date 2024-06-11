import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../model/global_model.dart';
import '../Store/HiveStore.dart';
import '../app/routes/app_routes.dart';
import '../common/device_manager/global_constants.dart';

class GlobalService extends GetxService {
  final global = Global().obs;

  Future<GlobalService> init() async {
    // var response = await Helper.getJsonFile('config/global.json');
    // global.value = Global.fromJson(response);
    checkLogIn();
    return this;
  }

  String getPlatformVersion() {
    return "7.0";
  }

  String getPlatformCode() {
    return Platform.isAndroid ? "1" : "2";
  }

  checkLogIn() async {
    final HiveStore preferences = HiveStore.getInstance();
    bool isLoggedIn = preferences.getBool("isLoggedIn") ?? false;
    loggedIn = isLoggedIn;
    String accessToken = preferences.getString(Keys.TOKEN) ?? "";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (loggedIn && accessToken.isNotEmpty) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.SPLASH);
      }
    });
  }

  String get baseUrl => global.value.laravelBaseUrl!;
}
