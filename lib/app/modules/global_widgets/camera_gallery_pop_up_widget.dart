import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trans_cash_solution/app/modules/home/controller/home_controller.dart';
import '../../../common/device_manager/assets.dart';
import '../../../common/device_manager/screen_constants.dart';
import '../../../common/device_manager/strings.dart';
import '../../../common/device_manager/text_styles.dart';

class CameraOrGalleryPopUpMenu extends StatelessWidget{
  String? icon;
  double? height;
  final HomeController homeController = Get.find<HomeController>();
   CameraOrGalleryPopUpMenu({ this.icon, this.height,super.key
  });
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onSelected: (item) async{
        switch (item) {
          case "Camera":
            {
              debugPrint("Open Camera");
              _getFromCamera();
            }
            break;
          case "Gallery":
            {
              debugPrint("Open Gallery");
              _getFromGallery();
            }
            break;
        }
      },
      itemBuilder: (context){
        var list = <PopupMenuEntry<Object>>[];
        list.add(
          PopupMenuItem(
            value: "Camera",
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.camera_alt_outlined, color: Colors.redAccent),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLabels.camera.tr,
                      style: TextStyles.subTitleBlackDark,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        list.add(
          PopupMenuItem(
            value: "Gallery",
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.drive_folder_upload, color: Colors.redAccent),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLabels.gallery.tr,
                      style: TextStyles.subTitleBlackDark,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
        return list;
      },
      child: Image.asset(
        icon!,
        height: height!,
        color: Theme.of(context).indicatorColor,
      ),
    );
  }
  _getFromGallery() async {
    XFile? selectedImage;
    selectedImage = (await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    ));
    if (selectedImage != null) {
      homeController.temporaryProfileImageForUpload.value = selectedImage.path;
      debugPrint(homeController.temporaryProfileImageForUpload.value);
      Get.back();
    }
  }
  _getFromCamera() async {
    XFile? selectedImage;
    selectedImage = (await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    ));
    if (selectedImage != null) {
      homeController.temporaryProfileImageForUpload.value = selectedImage.path;
      debugPrint(homeController.temporaryProfileImageForUpload.value);
      Get.back();
    }
  }
}