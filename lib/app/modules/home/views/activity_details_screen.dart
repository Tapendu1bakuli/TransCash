import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizing/sizing.dart';
import '../../../modules/home/controller/activity_controller.dart';
import '../../../../common/device_manager/strings.dart';
import '../../../../common/device_manager/assets.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/text_styles.dart';
import '../../../../common/widgets/frame.dart';

class ActivityDetailsScreen extends GetView<ActivityController> {
  String? id;
  String? name;
  String? date;
  String? countryCode;
  String? contactNumber;
  String? amount;
  String? status;

  ActivityDetailsScreen(
      {super.key,
      this.status,
      this.name,
      this.countryCode,
      this.contactNumber,
      this.id,
      this.date,
      this.amount});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Screenshot(
      controller: controller.screenshotController,
      child: Frame(
        color: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
            child: Icon(Icons.arrow_back_ios_new),
            onTap: () {
              Get.back();
            },
          ),
          backgroundColor: AppColors.activityDetailsAppBarColor,
          elevation: 0,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status == "Withdraw Pending"
                    ? AppLabels.withdrawPending :status == "Withdraw Complete"?AppLabels.withdrawSuccessful
                    : AppLabels.transactionSuccessful,
                style: TextStyles.activityDetailsAppBarTitle,
              ),
              Container(
                height: ScreenConstant.sizeExtraSmall,
              ),
              Text(
                date!,
                style: TextStyles.activityDetailsAppBarSubTitle,
              )
            ],
          ),
        ),
        content: ListView.builder(
            padding: ScreenConstant.spacingAllDefault,
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return activityDetailsCard(
                  controller.screenshotController, context);
            }),
      ),
    );
  }

  Card activityDetailsCard(controller, context) {
    return Card(
      color: Theme.of(context).canvasColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: ScreenConstant.spacingAllLarge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              status == "Paid"
                  ? AppLabels.sendTo
                  : status == "Withdraw Pending"
                      ? AppLabels.withdrawFromYourWallet
                      : AppLabels.receivedFrom,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Container(
              height: ScreenConstant.defaultHeightFifteen,
            ),
            Row(
              children: [
                Container(
                  height: ScreenConstant.defaultWidthFifty,
                  width: ScreenConstant.defaultWidthFifty,
                  decoration: const BoxDecoration(
                      color: AppColors.appPrimaryColor, shape: BoxShape.circle),
                  child: Padding(
                    padding: ScreenConstant.spacingAllDefault,
                    child: SvgPicture.asset(
                      Assets.rightArrowIcon,
                    ),
                  ),
                ),
                Container(
                  width: ScreenConstant.defaultWidthTwenty,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    name != null
                        ? Text(
                            name!,
                            style: Theme.of(context).textTheme.displayMedium,
                          )
                        : Text(
                            "Unable to Process",
                            style: TextStyle(
                              color: AppColors.baseBlack,
                              fontSize: FontSize.s18,
                            ),
                          ),
                    Container(height: ScreenConstant.defaultHeightTen),
                    Text(
                      "$countryCode $contactNumber",
                      style: TextStyle(
                        color: AppColors.appPrimaryColor,
                        fontSize: FontSize.s12,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    width: ScreenConstant.defaultWidthTwenty,
                  ),
                ),
                Text(amount!, style: Theme.of(context).textTheme.displayMedium),
              ],
            ),
            Container(height: ScreenConstant.defaultHeightFifteen),
            const Divider(
              thickness: .5,
              color: AppColors.activityDetailsDividerColor,
            ),
            Container(height: ScreenConstant.defaultHeightFifteen),
            Text(
              "Banking Name     :   $name",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12.fss),
            ),
            Container(height: ScreenConstant.defaultHeightFifteen),
            const Divider(
              thickness: .5,
              color: AppColors.activityDetailsDividerColor,
            ),
            Container(height: ScreenConstant.defaultHeightFifteen),
            Row(
              children: [
                SvgPicture.asset(
                  Assets.transferIcon,
                  color: Theme.of(context).indicatorColor,
                ),
                Container(width: ScreenConstant.defaultWidthTen),
                Text(
                  AppLabels.transferDetails,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Expanded(
                  child: Container(width: ScreenConstant.defaultWidthTen),
                ),
                // const Icon(Icons.keyboard_arrow_up_outlined)
              ],
            ),
            Container(height: ScreenConstant.defaultWidthTwenty),
            Text(
              AppLabels.transactionId,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 10.fss),
            ),
            Container(height: ScreenConstant.defaultWidthTen),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  id!,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: id??"")).then((_) {
                      return null;
                    });
                  },
                  child: SvgPicture.asset(
                    Assets.copyIcon,
                  ),
                ),
              ],
            ),
            // Container(height: ScreenConstant.defaultWidthTwenty),
            // Text(
            //   AppLabels.creditedTo,
            //   style: TextStyle(
            //     color: AppColors.baseBlack,
            //     fontSize: FontSize.s10,
            //   ),
            // ),
            // Container(height: ScreenConstant.defaultWidthTen),
            // Row(
            //   children: [
            //     Container(
            //       height: ScreenConstant.defaultWidthTwenty,
            //       width: ScreenConstant.defaultWidthTwenty,
            //       decoration: const BoxDecoration(
            //           color: AppColors.appPrimaryColor, shape: BoxShape.circle),
            //       child: Padding(
            //         padding: const EdgeInsets.all(6.0),
            //         child: SvgPicture.asset(
            //           Assets.backIcon,
            //         ),
            //       ),
            //     ),
            //     // Container(
            //     //   width: ScreenConstant.defaultWidthTwenty,
            //     // ),
            //     // Column(
            //     //   crossAxisAlignment: CrossAxisAlignment.start,
            //     //   children: [
            //     //     Text(
            //     //       "*******7546",
            //     //       style: TextStyle(
            //     //         color: AppColors.baseBlack,
            //     //         fontSize: FontSize.s18,
            //     //       ),
            //     //     ),
            //     //     Container(
            //     //       height: ScreenConstant.defaultHeightTen,
            //     //     ),
            //     //     Text(
            //     //       "UTR: 5263374647464",
            //     //       style: TextStyle(
            //     //         color: AppColors.baseBlack,
            //     //         fontSize: FontSize.s12,
            //     //       ),
            //     //     ),
            //     //   ],
            //     // ),
            //     // Expanded(
            //     //   child: Container(width: ScreenConstant.defaultWidthTwenty),
            //     // ),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.end,
            //       children: [
            //         Text(
            //           "+\$.50",
            //           style: TextStyle(
            //             color: AppColors.baseBlack,
            //             fontSize: FontSize.s18,
            //           ),
            //         ),
            //         Container(
            //           height: ScreenConstant.defaultHeightTen,
            //         ),
            //         SvgPicture.asset(
            //           Assets.copyIcon,
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            Container(height: ScreenConstant.defaultWidthTen),
            const Divider(
              thickness: .5,
              color: AppColors.activityDetailsDividerColor,
            ),
            Container(
              height: ScreenConstant.defaultHeightFifteen,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  final image =
                      controller.capture().then((capturedImage) async {
                    ShowCapturedWidget(context, capturedImage!);
                  }).catchError((onError) {
                    print(onError);
                  });
                  debugPrint("abcd$image");
                  // if(image == null) return;
                  // await saveImage(image);
                },
                child: Container(
                  height: ScreenConstant.defaultWidthThirty,
                  width: ScreenConstant.defaultWidthThirty,
                  decoration: const BoxDecoration(
                      color: AppColors.activityDetailsShareDesignColor,
                      shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: SvgPicture.asset(
                      Assets.shareIcon,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: ScreenConstant.defaultHeightTen,
            ),
            Center(
              child: Text("Share Receipt",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 10.fss)),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        floatingActionButton: SizedBox(
          height: 40.ss,
          width: 40.ss,
          child: FloatingActionButton(
            backgroundColor: AppColors.activityDetailsAppBarColor,
            child: const Icon(Icons.share),
            onPressed: () async {
              saveAndShare(capturedImage);
            },
          ),
        ),
        appBar: AppBar(
          backgroundColor: AppColors.activityDetailsAppBarColor,
          title: const Text("Share Details"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = '${directory.path}/image.jpg';
    File(image).writeAsBytes(bytes);
    await Share.shareFiles([image]);
  }
}
