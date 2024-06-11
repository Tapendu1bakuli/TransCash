import 'package:flutter/material.dart';

import '../../common/device_manager/colors.dart';
import '../../common/widgets/app_button.dart';
import '../device_manager/screen_constants.dart';

class CustomDialogBox extends StatefulWidget {
  final String? title, descriptions, text;
  final Image? img;
  final onPressed;

  const CustomDialogBox(
      {Key? key,
      this.title,
      this.descriptions,
      this.text,
      this.img,
      this.onPressed})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ScreenConstant.sizeLarge),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: ScreenConstant.sizeLarge,
              top: ScreenConstant.sizeXXL + ScreenConstant.sizeLarge,
              right: ScreenConstant.sizeLarge,
              bottom: ScreenConstant.sizeLarge),
          margin: EdgeInsets.only(top: ScreenConstant.sizeXXL),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenConstant.sizeLarge),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.descriptions!,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: AppButton(
                    onPressed: widget.onPressed, buttonText: widget.text!),
              ),
            ],
          ),
        ),
        Positioned(
          left: ScreenConstant.sizeLarge,
          right: ScreenConstant.sizeLarge,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: ScreenConstant.sizeXXL,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(ScreenConstant.sizeXXL)),
                child: Icon(
                  Icons.error_outline_outlined,
                  size: 64,
                  color: AppColors.primaryColorDash,
                )),
          ),
        ),
      ],
    );
  }
}
