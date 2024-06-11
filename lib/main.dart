import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing_builder.dart';
import 'package:trans_cash_solution/provider/theme_provider.dart';
import 'Store/HiveStore.dart';
import 'app/routes/app_routes.dart';
import 'app/routes/theme1_app_pages.dart';

/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  //'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //  options: DefaultFirebaseOptions.currentPlatform,
  );
  if (!GetPlatform.isWeb) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await HiveStore().initBox();
  //await initServices();
  runApp(const TransCashSolutionApp());
}

// initServices() async {
//   Get.log('starting services ...');
//   await Get.putAsync(() => GlobalService().init());
// }

class TransCashSolutionApp extends StatelessWidget {
  const TransCashSolutionApp({key});

  @override
  Widget build(BuildContext context) {
    return SizingBuilder(
      builder: () => GetMaterialApp(
        themeMode: ThemeMode.system,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        initialRoute: Routes.SPLASH,
        getPages: Theme1AppPages.routes,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
      ),
    );
  }
}
