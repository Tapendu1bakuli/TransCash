import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trans_cash_solution/app/modules/home/controller/home_controller.dart';

import '../../../../common/device_manager/assets.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/widgets/frame.dart';
import '../../global_widgets/camera_gallery_pop_up_widget.dart';
import '../../global_widgets/profile_icon.dart';

class ImagePreview extends GetView<HomeController> {
  const ImagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Frame(
      topLeadingIconColor: Colors.white,
      onTap: (){
        Get.back();
        controller.onlyPreview.value = false;
      },
      topWidget: true,
      color: Colors.white12,
      padding: ScreenConstant.spacingAllXL,
      content: Obx(()=>Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: ScreenConstant.screenHeightFifth,
            ),
            controller.temporaryProfileImageForUpload.value.isEmpty?
            ProfileIcon(
              borderRadious: 15,
              height: ScreenConstant.defaultSizeTwoFifty,
              width: ScreenConstant.defaultSizeTwoFifty,
              image:
              controller.profileImage.value,
            ):Container(
                height: ScreenConstant.defaultSizeTwoFifty,
                width: ScreenConstant.defaultSizeTwoFifty,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.file(fit: BoxFit.contain,File(controller
                    .temporaryProfileImageForUpload.value))
            ),
            Container(
              height: ScreenConstant.screenHeightNineteen,
            ),
             controller.onlyPreview.value?const Offstage():
            CameraOrGalleryPopUpMenu(icon: Assets.imagePreviewEditIcon,height: ScreenConstant.sizeMidLarge,)
          ],
        ),
      ),
    );
  }
}
