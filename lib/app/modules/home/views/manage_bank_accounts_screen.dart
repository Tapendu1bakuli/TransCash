import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gradient_like_css/gradient_like_css.dart';
import 'package:sizing/sizing.dart';

import '../../../../Service/input_formatters.dart';
import '../../../../Service/payment_card_service.dart';
import '../../../../common/device_manager/assets.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/strings.dart';
import '../../../../common/device_manager/text_styles.dart';
import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../controller/activity_controller.dart';

class ManageBankAccountScreen extends GetView<ActivityController> {
  final ActivityController activityController = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return GetX<ActivityController>(initState: (state) {
      Future.delayed(const Duration(milliseconds: 100), () {
        controller.allBanks.clear();
        controller.fetchBankDetails();
        controller.isAddBankAccountScreenActivated.value = false;
        controller.accountHolderNameController.text = "";
        controller.accountNumberController.text = "";
        controller.bankNameController.text = "";
        controller.ifscCodeController.text = "";
        controller.selectedDrowpdown = 'Personal'.obs;
        // Get.back();
        // controller.fetchCardDetails();
      });
    }, builder: (_) {
      return WillPopScope(
        onWillPop: Helper().onWillPop,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.ss, vertical: 15.ss),
          child: InkWell(
            focusColor: Theme.of(context).scaffoldBackgroundColor,
            onTap: () {
              controller.isDeleteOptionEnabled.value = false;
            },
            child: Column(
              children: [
                controller.isAddBankAccountScreenActivated.value
                    ? const Offstage()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Manage bank accounts",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Expanded(
                            child: Container(
                              width: 5.ss,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              debugPrint("add card");
                              controller.isAddBankAccountScreenActivated.value =
                                  true;
                              controller.isLoading.value = false;
                              controller.nameInCardController.text = "";
                              controller.cardNumberController.text = "";
                              controller.expiryController.text = "";
                            },
                            child: Container(
                              height: 35.ss,
                              width: 35.ss,
                              decoration: const BoxDecoration(
                                  color: AppColors.plusIconColor,
                                  shape: BoxShape.circle),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  Assets.plusIcon,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: controller.isAddBankAccountScreenActivated.value
                        ? addBankDetails(context)
                        : controller.allBanks.isEmpty ||
                                controller.isLoading.value
                            ? Center(
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(AppLabels.noBanksAvailable)
                                ],
                              ))
                            : bankAccountDesign(),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  addBankDetails(context) {
    return Obx(
      () => Stack(
        children: [
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            children: [
              Form(
                key: controller.formKeyBankAccountCheckout,
                autovalidateMode: controller.validateBankAccountCheckout.value
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenConstant.sizeLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLabels.pleaseInsertBankAccountDetails,
                          style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(height: ScreenConstant.sizeLarge),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(AppLabels.accountHolderName,
                            style: Theme.of(context).textTheme.labelSmall),
                      ),
                      SizedBox(height: ScreenConstant.sizeSmallHighest),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextFormField(
                          controller: controller.accountHolderNameController,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          maxLines: 1,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          style: Theme.of(context).textTheme.labelSmall,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.labelSmall,
                            hintText: AppLabels.nameInBank,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.baseBlack,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.textBoxColorGray,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.cardBackgroundColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenConstant.sizeMidLarge),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(AppLabels.accountNumber,
                            style: Theme.of(context).textTheme.labelSmall),
                      ),
                      SizedBox(height: ScreenConstant.sizeSmallHighest),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextFormField(
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ],
                          controller: controller.accountNumberController,
                          keyboardType: TextInputType.number,
                          autofocus: false,
                          maxLines: 1,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          style: Theme.of(context).textTheme.labelSmall,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.labelSmall,
                            hintText: AppLabels.accountNumberOfBank,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.baseBlack,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.textBoxColorGray,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.cardBackgroundColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenConstant.sizeMidLarge),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(AppLabels.bankName,
                            style: Theme.of(context).textTheme.labelSmall),
                      ),
                      SizedBox(height: ScreenConstant.sizeSmallHighest),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextFormField(
                          controller: controller.bankNameController,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          maxLines: 1,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          style: Theme.of(context).textTheme.labelSmall,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.labelSmall,
                            hintText: AppLabels.bankNames,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.baseBlack,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.textBoxColorGray,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.cardBackgroundColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenConstant.sizeMidLarge),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(AppLabels.bankIFSCCode,
                            style: Theme.of(context).textTheme.labelSmall),
                      ),
                      SizedBox(height: ScreenConstant.sizeMidLarge),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextFormField(
                          controller: controller.ifscCodeController,
                          keyboardType: TextInputType.text,
                          autofocus: false,
                          maxLines: 1,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          style: Theme.of(context).textTheme.labelSmall,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintStyle: Theme.of(context).textTheme.labelSmall,
                            hintText: AppLabels.bankIFSCCodes,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.baseBlack,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.textBoxColorGray,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.cardBackgroundColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppColors.red,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenConstant.sizeMidLarge),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(AppLabels.accountType,
                            style: Theme.of(context).textTheme.labelSmall),
                      ),
                      SizedBox(height: ScreenConstant.sizeMidLarge),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          height: 60,
                          width: 300,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.textBoxColorGray),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  dropdownColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  style: Theme.of(context).textTheme.labelSmall,
                                  items: [
                                    for (var data in controller.dropdownText)
                                      DropdownMenuItem(
                                        value: data,
                                        child: Text(
                                          data,
                                        ),
                                      )
                                  ],
                                  hint: Text(
                                    controller.selectedDrowpdown.value,
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  onChanged: (newValue) {
                                    controller.selectedDrowpdown.value =
                                        newValue!;
                                  }),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 45.ss,
                      ),
                      controller.isLoading.value
                          ? Center(
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(40)),
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    color: AppColors.appPrimaryColor,
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                debugPrint(
                                    "controller.selectedType:${controller.selectedDrowpdown}");
                                controller.selectedDrowpdown == null
                                    ? Get.showSnackbar(Ui.ErrorSnackBar(
                                        title: "Fields are empty",
                                        message: "All fields is required."))
                                    : controller.addBankDetails();
                              },
                              child: Container(
                                width: .9.sw,
                                height: 60.ss,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  gradient: linearGradient(
                                      90, ['#31AD00', '#13DA02']),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.green.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    AppLabels.submit,
                                    style: TextStyles.buttonTitle,
                                  ),
                                ),
                              ),
                            ),
                      Container(
                        height: 25.ss,
                      ),
                      controller.isLoading.value
                          ? const Offstage()
                          : GestureDetector(
                              onTap: () {
                                controller.isAddBankAccountScreenActivated
                                    .value = false;
                              },
                              child: Container(
                                width: .9.sw,
                                height: 60.ss,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFF31AD00), width: 1),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: Center(
                                  child: Text(
                                    AppLabels.cancel,
                                    style: TextStyle(
                                      color: const Color(0xFF31AD00),
                                      fontSize: FontSize.s20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: ScreenConstant.sizeXXL),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ListView bankAccountDesign() {
    return ListView.builder(
        physics: const ScrollPhysics(),
        padding: EdgeInsets.all(5.ss),
        shrinkWrap: true,
        itemCount: controller.allBanks.length,
        itemBuilder: (BuildContext context, int index) {
          return Obx(
            () => InkWell(
              onLongPress: () {
                controller.isDeleteOptionEnabled.value = true;
              },
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  height: 200,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://images.squarespace-cdn.com/content/v1/5a25bdf9f6576e5e2b2c69de/1634718226071-E9SZ3SUZNC0PZ55WGQVE/GettyImages-1173149385.jpg?format=2500w'),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Acc Holder Name: ${controller.allBanks[index].accHolderName}",
                          style: TextStyles.dateExpCard,
                        ),
                        controller.isDeleteOptionEnabled.value
                            ? const Offstage()
                            : Container(
                                height: 10.ss,
                              ),
                        Text(
                          "Acc Number: ${controller.allBanks[index].accNumber}",
                          style: TextStyles.dateExpCard,
                        ),
                        Container(
                          height: 10.ss,
                        ),
                        Text(
                          "IFSC Code: ${controller.allBanks[index].ifscCode}",
                          style: TextStyles.dateExpCard,
                        ),
                        Container(
                          height: 10.ss,
                        ),
                        Text(
                          "Bank Name: ${controller.allBanks[index].bankName}",
                          style: TextStyles.dateExpCard,
                        ),
                        Container(
                          height: 10.ss,
                        ),
                        Row(
                          children: [
                            Text(
                              "Acc Type: ${controller.allBanks[index].type}",
                              style: TextStyles.dateExpCard,
                            ),
                            Expanded(
                              child: Container(
                                width: 10.ss,
                              ),
                            ),
                            controller.isDeleteOptionEnabled.value
                                ? IconButton(
                                    onPressed: () {
                                      showAlertDialog(context,
                                          controller.allBanks[index].id);
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                  )
                                : const Text(
                                    AppLabels.pressAndHoldToDeleteCard,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8),
                                    textAlign: TextAlign.center,
                                  )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  showAlertDialog(BuildContext context, int? index) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel",
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(fontSize: 14.fss)),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Yes",
        style: TextStyle(
          color: AppColors.appPrimaryColor,
          fontSize: 14.fss,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () async {
        Get.back();
        // controller.deleteCard(index);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Theme.of(context).canvasColor,
      title: Text(
        "Delete card!",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14.fss),
      ),
      content: Text(
        "Are you sure you want to delete this card?",
        style: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(fontSize: 12.fss),
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
