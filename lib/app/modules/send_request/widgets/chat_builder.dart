import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

import '../../../../common/device_manager/assets.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/text_styles.dart';

class ChatBuilder extends StatelessWidget {
  const ChatBuilder(
      {Key? key,
      this.amount = "0.00",
      this.name = "",
      this.date = "",
      this.isPaid = false,
      this.isSending = false})
      : super(key: key);
  final bool? isSending;
  final String? name;
  final String? amount;
  final bool? isPaid;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isSending!
          ? EdgeInsets.only(
              left: ScreenConstant.screenWidthFifth,
              right: ScreenConstant.sizeXL,
              top: ScreenConstant.sizeLarge,
              bottom: ScreenConstant.sizeLarge,
            )
          : EdgeInsets.only(
        right: ScreenConstant.screenWidthFifth,
        left: ScreenConstant.sizeXL,
        top: ScreenConstant.sizeLarge,
        bottom: ScreenConstant.sizeLarge,
      ),
      child: Card(
        color: Theme.of(context).canvasColor,
        child: Padding(
          padding: ScreenConstant.spacingAllMedium,
          child: Column(
            children: [
              Row(
                children: [
                  isSending!
                      ? Text(
                          "Payment to ",
                          style: Theme.of(context).textTheme.displaySmall,
                        )
                      : Text("Request to ",
                          style: Theme.of(context).textTheme.displaySmall),
                  Text(name!, style: Theme.of(context).textTheme.displaySmall),
                ],
              ),
              Container(height:ScreenConstant.sizeDefault ,),
              Row(
                children: [
                  Text(
                    amount.toString(),
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 28.fss),
                  )
                ],
              ),
              Container(height:ScreenConstant.sizeDefault ,),
              Row(
                children: [
                  Container(decoration: BoxDecoration(color: AppColors.primaryColorDashHash,borderRadius: BorderRadius.circular(20),),child: Image.asset(Assets.success),height: 20,width: 20,),
                  // isPaid!
                  //     ? Image.asset(Assets.paid)
                  //     : Image.asset(Assets.pending),
                  Container(width:ScreenConstant.sizeDefault ,),
                  // isPaid!
                  //     ? Text(
                  //         "Paid",
                  //         style: TextStyles.subTitleBlackLight,
                  //       )
                  //     : Text("Pending", style: TextStyles.subTitleBlackLight),
                  // Text(" - "),
                  Text(
                    date!,
                    style: Theme.of(context).textTheme.displaySmall,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
