import 'package:get/get.dart';
import 'package:trans_cash_solution/app/modules/auth/views/forgot_password.dart';
import 'package:trans_cash_solution/app/modules/profile/binding/profile_binding.dart';
import 'package:trans_cash_solution/app/modules/profile/views/image_preview.dart';
import 'package:trans_cash_solution/app/modules/send_request/binding/send_request_binding.dart';
import 'package:trans_cash_solution/app/modules/wallet_section/views/wallet_screen.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/new_password.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/otp_verification_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/activity_details_screen.dart';
import '../modules/home/views/home_bottom_navigation_screen.dart';
import '../modules/notification_section.dart/views/notifications_list_screen.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/landing.dart';
import '../modules/send_request/views/contacts_screen.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/splash/views/splash_screen.dart';
import '../modules/wallet_section/binding/wallet_binding.dart';
import 'app_routes.dart';

class Theme1AppPages {
  static final routes = [
    GetPage(
        name: Routes.SPLASH,
        page: () => SplashScreen(),
        binding: RootBinding()),
    GetPage(
        name: Routes.LANDING,
        page: () => LandingView(),
        binding: RootBinding()),
    GetPage(
        name: Routes.LOGIN, page: () => LoginView(), binding: AuthBinding()),
    GetPage(
        name: Routes.NEW_PASSWORD,
        page: () => NewPasswordView(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.REGISTER,
        page: () => RegisterView(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.HOME,
        page: () => HomeBottomNavigationScreen(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.OTPVERIFICATION,
        page: () => OTPVerificationView(),
        binding: AuthBinding()),
    GetPage(
      name: Routes.ACTIVITYDETAILS,
      page: () => ActivityDetailsScreen(),
    ),
    GetPage(
        name: Routes.WALLETSCREEN,
        page: () => WalletScreen(),
        ),
    GetPage(
        name: Routes.FORGOT_PASSWORD,
        page: () => ForgotPasswordView(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.PROFILE,
        page: () => ProfileView(),
        binding: ProfileBinding()),
    GetPage(
      name: Routes.NOTIFICATIONS,
      page: () => NotificationsListScreen(),
    ),
    GetPage(
        name: Routes.CONTACTSCREEN,
        page: () => ContactsScreen(),
        binding: SendRequestBinding()),
    GetPage(
        name: Routes.IMAGEPREVIEWSCREEN,
        page: () => ImagePreview(),
        binding: HomeBinding()),
  ];
}
