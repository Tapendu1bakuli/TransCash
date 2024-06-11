import 'dart:convert' as convert;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../common/ui.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper {
  late DateTime currentBackPressTime;

  static Future<dynamic> getJsonFile(String path) async {
    return rootBundle.loadString(path).then(convert.jsonDecode);
  }

  static String toUrl(String path) {
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  static String toApiUrl(String path) {
    path = toUrl(path);
    if (!path.endsWith('/')) {
      path += '/';
    }
    return path;
  }

  Future launchToUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.showSnackbar(Ui.defaultSnackBar(message: "Tap again to leave!".tr));
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }
}
