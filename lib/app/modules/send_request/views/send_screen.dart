import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_like_css/gradient_like_css.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/app/modules/home/controller/home_controller.dart';
import 'package:trans_cash_solution/app/modules/send_request/widgets/amount_builder.dart';
import 'package:trans_cash_solution/common/device_manager/text_styles.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/ui.dart';
import '../controller/send_request_controller.dart';
import '../widgets/chat_builder.dart';

class SendScreen extends GetView<SendRequestController> {
  String? name;
  int? userId;

  SendScreen({
    this.name,
    this.userId,
    super.key,
  });

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetX<HomeController>(initState: (state) {
      Future.delayed(const Duration(milliseconds: 100), () {
        controller.fetchUserTransactionDetails(userId.toString());
      });
    }, builder: (_) {
      debugPrint("${controller.transactionList.length}");
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Theme.of(context).indicatorColor,),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            "Send to $name",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.ss),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFA7A7A7), width: 1.0),
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "You receive",
                        style: TextStyle(
                          fontSize: FontSize.s16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "You send",
                        style: TextStyle(
                          fontSize: FontSize.s16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ]),
              )),
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0.0,
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenConstant.defaultWidthTwenty,
                        horizontal: ScreenConstant.defaultWidthThirty),
                    child: Column(
                      children: [
                        Row(
                          children:  [
                            AmountBuilder(
                              amount: controller.theyReceived.value,
                            ),
                            Spacer(),
                            AmountBuilder(
                              amount: controller.youSend.value,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                   Divider(
                    color: Theme.of(context).indicatorColor,
                  ),
                ],
              ),
            ),
            Positioned(
                top: 120,
                bottom: 90,
                left: 0.0,
                right: 0.0,
                child: ListView.builder(
                  reverse: true,
                    itemCount: controller.transactionList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ChatBuilder(
                        amount: controller.transactionList[index].amount.toString(),
                        name: controller.transactionList[index].status=="Paid"?controller.transactionList[index].receiverDetails!.name:controller.transactionList[index].senderDetails!.name,
                        isSending: controller.transactionList[index].status=="Paid"?true:false,
                        date: controller.transactionList[index].date,
                      );
                    })),
            Positioned(
              bottom: 10.ss,
              left: 15.ss,
              right: 15.ss,
              child: Container(
                height: .15.sh,
                width: .9.sw,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.ss),
                        child: TextFormField(
                          style: Theme.of(context).textTheme.displaySmall,
                          keyboardType: TextInputType.number,
                          controller: controller.amountTextController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color(0xFFE4E4E4),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color(0xFFE4E4E4),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color(0xFFE4E4E4),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color(0xFFE4E4E4),
                              ),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.all(10),
                            hintStyle: Theme.of(context).textTheme.displaySmall,
                            hintText: "Insert an amount",
                            fillColor:Theme.of(context).canvasColor,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (controller.amountTextController.text.isNotEmpty) {
                          if (double.parse(
                                  controller.amountTextController.text) <=
                              double.parse(
                                  homeController.totalWalletMoney.value)) {
                            showAlertDialog(context, name,
                                controller.amountTextController.text);
                          } else {
                            Get.showSnackbar(Ui.ErrorSnackBar(
                                message:
                                    "No sufficient money in your wallet."));
                          }
                        } else {
                          Get.showSnackbar(
                              Ui.ErrorSnackBar(message: "Amount is required"));
                        }
                      },
                      child: Container(
                        width: .3.sw,
                        height: 40.ss,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: linearGradient(90, ['#31AD00', '#13DA02']),
                        ),
                        child: Center(
                          child: Text(
                            "Next",
                            style: TextStyles.buttonTitle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  showAlertDialog(BuildContext context, String? name, String? amount) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 14.fss)
      ),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Confirm",
        style: TextStyle(
          color: AppColors.appPrimaryColor,
          fontSize: 14.fss,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () async {
        Get.back();
        controller.sendMoney(
            controller.amountTextController.text, userId.toString(), name);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Theme.of(context).canvasColor,
      title: Text(
        "Send \$$amount to $name",
        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 14.fss),
      ),
      content: Text(
        "Are you sure you want to send money to $name?",
        style: Theme.of(context).textTheme.displayMedium!.copyWith( fontSize: 12.fss),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
