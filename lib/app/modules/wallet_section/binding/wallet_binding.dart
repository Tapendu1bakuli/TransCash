import 'package:get/get.dart';
import 'package:trans_cash_solution/app/modules/wallet_section/controller/wallet_controller.dart';

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletController>(
          () => WalletController(),
    );
  }
}