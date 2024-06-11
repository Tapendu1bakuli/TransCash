import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/app/modules/home/controller/home_controller.dart';

import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/strings.dart';
import '../../../../common/device_manager/text_styles.dart';

class AvailibilityHoursOptionsPopupMenuWidget extends StatelessWidget {
  int? index;
   AvailibilityHoursOptionsPopupMenuWidget({super.key,this.index
  });
HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Theme.of(context).canvasColor,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onSelected: (item) {
        switch (item) {
          case "update":
            {
              Get.back();
            }
            break;
          case "delete":
            {
              _showDeleteDialog(context);
            }
            break;
          // case "view":
          //   {
          //     Get.toNamed(Routes.E_SERVICE, arguments: {'eService': _eService, 'heroTag': 'e_provider_services_list_item'});
          //   }
          //   break;
        }
      },
      itemBuilder: (context) {
        var list = <PopupMenuEntry<Object>>[];
        // list.add(
        //   PopupMenuItem(
        //     value: "view",
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Icon(Icons.water_damage_outlined, color: Get.theme.hintColor),
        //         SizedBox(width: 10),
        //         Text(
        //           "Service Details".tr,
        //           style: TextStyle(color: Get.theme.hintColor),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
        // list.add(PopupMenuDivider(height: 10));
        // list.add(
        //   PopupMenuItem(
        //     value: "update",
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Icon(Icons.edit_outlined, color: Get.theme.hintColor),
        //         SizedBox(width: 10),
        //         Text(
        //           "Edit Availibility Hours".tr,
        //           style: TextStyle(color: Get.theme.hintColor),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
        list.add(
          PopupMenuItem(
            value: "delete",
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.delete_outline, color: Colors.redAccent),
                SizedBox(width: 10),
                Text(
                  AppLabels.deleteThisNotification.tr,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12.fss),
                ),
              ],
            ),
          ),
        );
        return list;
      },
      child: Icon(
        Icons.more_vert,
        color: Theme.of(context).indicatorColor,size: 18,
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).canvasColor,
          title: Text(
            AppLabels.deleteThisNotification.tr,
            style: TextStyle(color: Colors.redAccent),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                    "This notification will removed from your account.".tr,
                    style: Theme.of(context).textTheme!.displaySmall!.copyWith(fontSize: 12.fss)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel".tr, style: Theme.of(context).textTheme!.displaySmall!.copyWith(fontSize: 12.fss)),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text(
                "Confirm".tr,
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                Get.back();
                homeController.deleteNotification(index);
              },
            ),
          ],
        );
      },
    );
  }
}
