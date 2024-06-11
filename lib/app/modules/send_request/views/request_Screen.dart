import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_like_css/gradient_like_css.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/app/modules/send_request/views/send_success_screen.dart';
import 'package:trans_cash_solution/app/modules/send_request/widgets/chat_builder.dart';
import 'package:trans_cash_solution/common/device_manager/text_styles.dart';
import 'package:trans_cash_solution/common/widgets/required_text_field.dart';
import '../../../../common/device_manager/colors.dart';
import '../controller/send_request_controller.dart';

class RequestScreen extends GetView<SendRequestController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          "Request from Eleanor pena",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      bottomNavigationBar: Container(
        height: .15.sh,
        width: .9.sw,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 8),
                child: RequireTextField(
                  type: Type.message,
                  controller: controller.message,
                  hintText: "Add a message",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(()=>SendSuccessScreen());
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
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 15.ss,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\$",
                style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 25.fss),
              ),
              Container(
                width: 5.ss,
              ),
              Column(
                children: [
                  Text(
                    "0.00",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 40.fss)
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 5.ss,
          ),
          Text(
            "USD",
            style: Theme.of(context).textTheme.displayMedium
          ),
          ChatBuilder(amount: "\$ 50", name: "Tapendu Bakuli",isSending: true,date: "Feb 22",),
          ChatBuilder(amount: "\$ 50", name: "Tapendu Bakuli",isPaid: true,date: "Feb 22")
        ],
      ),
    );
  }
}
