import 'package:get/get.dart';
import 'package:trans_cash_solution/app/modules/send_request/controller/send_request_controller.dart';


class SendRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendRequestController>(
          () => SendRequestController(),
    );
  }
}
