import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../Store/vm.dart';

class Keys {
  static const String TOKEN = "AUTHORIZATION";
  static const String USERNAME = 'FULL_NAME';
  static const String USERMOBILE = 'MOBILE';
  static const String USEREMAIL = 'EMAIL';
  static const String USEREPROFILEIMAGE = 'PROFILE_IMAGE';
  static const String COUNTRYCODE = 'COUNTRY_CODE';
  static const String FCMTOKEN = 'FCM_TOKEN';
  static const String TOTALAMOUNT = 'TOTAL_AMOUNT';
}

class HiveStore {
  //Singleton Class
  static final HiveStore _default = new HiveStore._internal();
  static Box? defBox;

  factory HiveStore() {
    return _default;
  }

  HiveStore._internal();

  static getInstance() {
    return _default;
  }

  initBox() async {
    defBox = await (openBox());
  }

  //Object Storage
  put(String key, Object value) async {
    defBox?.put(key, value);
    log("HiveStored : Key:$key, Value:$value");
  }

  get(String key) {
    // log("Box is Open? ${defBox.isOpen}");
    log("Hive Retrieve : Key:$key, Value:${defBox?.get(key)}");
    return defBox?.get(key);
  }

  //String Storage
  setString(String key, String value) async {
    defBox?.put(key, value);
    log("HiveStored : Key:$key, Value:$value");
  }

  getString(String key) {
    log("Hive Retrieve : Key:$key, Value:${defBox?.get(key)}");
    return defBox?.get(key);
  }

  //Bool Storage
  setBool(String key, bool value) async {
    defBox?.put(key, value);
    log("HiveStored : Key:$key, Value:$value");
  }

  getBool(String key) {
    log("Hive Retrieve : Key:$key, Value:${defBox?.get(key)}");
    return defBox?.get(key);
  }

  clear() {
    defBox?.clear();
  }

  remove(String key) async {
    defBox?.delete(key);
  }

  Future openBox() async {
    if (!isBrowser) {
      var dir = await getApplicationDocumentsDirectory();
      Hive
        ..init(dir
            .path) /*..registerAdapter(ScheduleReminderAdapter(),override: true,internal: true)*/;
    }
    return await Hive.openBox('Store');
  }
}
