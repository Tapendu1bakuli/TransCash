import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/app/modules/send_request/controller/send_request_controller.dart';
import 'package:trans_cash_solution/app/modules/send_request/views/request_Screen.dart';
import 'package:trans_cash_solution/common/device_manager/colors.dart';
import 'package:trans_cash_solution/common/device_manager/strings.dart';
import '../../../../Store/HiveStore.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/text_styles.dart';
import '../../../../common/ui.dart';

class ContactsScreen extends GetView<SendRequestController> {
  const ContactsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leadingWidth: 25,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Theme.of(context).indicatorColor,),
          onPressed: () {
            Get.back();
          },
        ),
        title: Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5),
            child:
            TextFormField(
              style: Theme.of(context).textTheme.displayMedium,
              controller: controller.search,
              onChanged: (String value){
                controller.searchPress();
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(
                    color: AppColors.appPrimaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(
                    color: AppColors.appPrimaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(
                    color: AppColors.appPrimaryColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: const BorderSide(
                    color: AppColors.appPrimaryColor,
                  ),
                ),
                filled: true,
                contentPadding: const EdgeInsets.all(15),
                hintStyle: Theme.of(context).textTheme.displayMedium,
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).indicatorColor,
                  size: ScreenConstant.texIconSize,
                ),
                hintText: AppLabels.search,
                fillColor: Theme.of(context).canvasColor,
              ),
            )
        ),
      ),
      body: Obx(
            () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Your contacts",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Expanded(
              child: controller.isLoading.value
                  ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: AppColors.appPrimaryColor,
                ),
              )
                  : ListView.builder(
                padding: EdgeInsets.all(5.ss),
                shrinkWrap: true,
                itemCount:
                controller.contacts.length,
                itemBuilder: (context, index) {
                  if(controller.contacts[index].phones!.isNotEmpty){
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          maxRadius: 25,
                          backgroundColor: AppColors.plusIconColor,
                          child: Text(
                            controller.contacts[index].givenName!
                                .toString()
                                .substring(0, 1)
                                .toUpperCase(),
                            style: TextStyles.subTitleBlue.copyWith(
                                color: Colors.black, fontSize: 18),
                          ),
                        ),
                        title: Text(
                          controller.contacts[index].displayName! ??
                              "",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        onTap: controller.isSend.value
                            ? () {
                          debugPrint("${controller.contacts[index].phones!}");
                          if (HiveStore().getString(Keys.USERMOBILE) !=
                              controller.contacts[index].phones!.elementAt(
                                  0).value) {
                            controller.validateNumberAsRegistered(
                                controller.contacts[index].phones!
                                    .elementAt(0).value,
                                controller.contacts[index].displayName!);
                          }else{
                            Get.showSnackbar(Ui.ErrorSnackBar(
                                message: "Enter an valid number."));
                          }
                        }
                            : () {
                          Get.to(()=>RequestScreen());
                        },
                      ),
                    );
                  }else{
                    return Offstage();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

