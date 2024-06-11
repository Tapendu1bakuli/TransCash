import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gradient_like_css/gradient_like_css.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/app/modules/send_request/controller/send_request_controller.dart';
import 'package:trans_cash_solution/common/device_manager/assets.dart';

import '../../../../common/device_manager/colors.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/text_styles.dart';

class SendSuccessScreen extends GetView<SendRequestController> {
  String? name;
  String? amount;
  String? userReceiverId;
  SendSuccessScreen({
    this.name,
    this.amount,
    this.userReceiverId,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: AppColors.appAccentColor),
        leading: IconButton(onPressed: (){Get.back();controller.fetchUserTransactionDetails(userReceiverId);controller.amountTextController.text = "";}, icon: Icon(Icons.arrow_back_ios,color: Theme.of(context).indicatorColor,),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.successIcon),
            Container(
              height: 15.ss,
            ),
            Text("You have successfully sent",
                style: TextStyle(
                  color: AppColors.primaryColorDashHash,
                  fontSize: FontSize.s16,
                )),
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: "\$$amount to ",
                    style: TextStyle(
                      color: AppColors.primaryColorDashHash,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  TextSpan(
                      text: name, style: TextStyles.walletText),
                ],
              ),
            ),
            Container(
              height: 65.ss,
            ),
            SvgPicture.asset(Assets.successProfileIcon),
            Container(
              height: .2.sh,
            ),
            InkWell(
              onTap: (){
                showAlertDialog(context, name, amount, userReceiverId);
              },
              child: Container(
                width: .9.sw,
                height: 60.ss,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: linearGradient(90, ['#31AD00', '#13DA02']),
                ),
                child: Center(
                  child: Text(
                    "Send Again",
                    style: TextStyles.buttonTitle,
                  ),
                ),
              ),
            ),
            Container(
              height: 25.ss,
            ),
            InkWell(
              onTap: (){
                Get.back();
                controller.fetchUserTransactionDetails(userReceiverId);
                controller.amountTextController.text = "";
              },
              child: Container(
                width: .9.sw,
                height: 60.ss,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF31AD00), width: 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Color(0xFF31AD00),
                      fontSize: FontSize.s20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  showAlertDialog(BuildContext context, String? name, String? amount,String? receiverId) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 14.fss),
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
        controller.sendMoneyAgain(
            amount, receiverId.toString(), name);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Theme.of(context).canvasColor,
      title: Text(
        "Send \$$amount to $name",
        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 14.fss)
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
