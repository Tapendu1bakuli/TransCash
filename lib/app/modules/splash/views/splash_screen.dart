import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/common/device_manager/colors.dart';
import '../../../../Store/HiveStore.dart';
import '../../../../common/device_manager/assets.dart';
import '../../../../common/device_manager/global_constants.dart';
import '../../../../main.dart';
import '../../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<dynamic> onSelectNotification(String? payload) async {
    /*Do whatever you want to do on notification click. In this case, I'll show an alert dialog*/
    print("payload");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      final HiveStore preferences = HiveStore.getInstance();
      _saveDeviceToken();
      ///flutter local notification package
      var initializationSettingsAndroid =
      new AndroidInitializationSettings('notification_icon');
      var initializationSettingsIOS = new DarwinInitializationSettings();
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {},
      );
      FirebaseMessaging.instance.requestPermission();
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification notification = message.notification!;
        AndroidNotification android;
        AppleNotification ios;
        if (GetPlatform.isIOS) {
          ios = message.notification!.apple!;
          if (notification != null && ios != null) {
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                const NotificationDetails(
                  iOS: DarwinNotificationDetails(),
                ));
          }
        } else {
          android = message.notification!.android!;
          if (notification != null && android != null) {
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    //color: AppColors.primaryColor,
                    icon: 'notification_icon',
                  ),
                ));
          }
        }
        print("Message : ${message.data}");
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
      });
      bool isLoggedIn = preferences.getBool("isLoggedIn") ?? false;
      loggedIn = isLoggedIn;
      String accessToken = preferences.getString(Keys.TOKEN) ?? "";
      if (loggedIn && accessToken.isNotEmpty) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.LANDING);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage(
                Assets.splashLogo,
              ),
              height: .2.sh,
            ),
            Container(
              height: 15.ss,
            ),
            SvgPicture.asset(
              Assets.splashLogoText,
            ),
          ],
        ),
      ),
    );
  }
  _saveDeviceToken() async {
    await HiveStore().initBox();
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM token : $fcmToken");
    if (fcmToken != null) {
      await HiveStore().put(Keys.FCMTOKEN, fcmToken);
      // Hive.box(HiveString.hiveName).put(HiveString.fcmToken,fcmToken);
    }
  }
}
