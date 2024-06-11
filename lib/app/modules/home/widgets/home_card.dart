import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizing/sizing.dart';

import '../../../../common/device_manager/screen_constants.dart';

class HomeCard extends StatelessWidget {
  String? icon;
  String? lableText;
  Function()? onTap;

  HomeCard({
    super.key,
    this.icon,
    this.lableText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFCFFFBC),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.ss, vertical: 15.ss),
          child: Column(children: [
            SvgPicture.asset(
              icon!,
            ),
            Container(
              height: 10.ss,
            ),
            Text(
              lableText!,
              style:
                  TextStyle(color: Color(0xFF0A0A0A), fontSize: FontSize.s14,fontWeight: FontWeight.w400),
            )
          ]),
        ),
      ),
    );
  }
}
