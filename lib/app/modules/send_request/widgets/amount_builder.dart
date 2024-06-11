import 'package:flutter/material.dart';
import 'package:sizing/sizing.dart';

import '../../../../common/device_manager/assets.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/text_styles.dart';
class AmountBuilder extends StatelessWidget {
  const AmountBuilder({Key? key,this.amount = 0.0,this.logo = false,this.logoName = ""}) : super(key: key);
  final double amount;
  final bool logo;
  final String logoName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              Assets.dollarIcon,
              color: Theme.of(context).indicatorColor,
              height: ScreenConstant.texIconSize,
            ),
            Container(
              width: ScreenConstant.defaultHeightTen,
            ),
            FittedBox(
              child: Text(
                amount.toString(),
                style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 30.fss),
              ),
            ),
          ],
        ),
        Container(
          height: ScreenConstant.sizeDefault,
        ),
        Row(
          children: [
            Container(
              width: ScreenConstant.sizeExtraLarge,
            ),
            Text(
              "USD",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Container(
              width: ScreenConstant.sizeExtraSmall,
            ),
            logo?
            Image.asset(
              Assets.arrowRight,
              height: ScreenConstant.defaultHeightFifteen,
            ):const Offstage()
          ],
        ),
      ],
    );
  }
}

