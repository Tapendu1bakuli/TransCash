import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/app/modules/home/controller/home_controller.dart';
import 'package:trans_cash_solution/model/saved_card_model.dart';
import '../../../../Service/payment_card_service.dart';
import '../../../../common/device_manager/assets.dart';
import '../../../../common/device_manager/colors.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/device_manager/strings.dart';
import '../../../../common/device_manager/text_styles.dart';
import '../../../../common/ui.dart';
import '../../../../common/widgets/app_button.dart';
import '../../home/controller/activity_controller.dart';
import '../controller/wallet_controller.dart';

class BottomSheetOfLists extends GetView<WalletController> {
  ActivityController activityController = Get.put(ActivityController());
  WalletController walletController = Get.put(WalletController());
  HomeController homeController = Get.put(HomeController());


  BottomSheetOfLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.cvvFormKey,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenConstant.sizeExtraLarge - 20,
            vertical: ScreenConstant.sizeMedium),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: ScreenConstant.sizeMedium),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              color:Theme.of(context).canvasColor,
            ),
            height: 1200,
            width: 400,
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 3,
                    width: ScreenConstant.defaultWidthSixty + 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                  ),
                ),
                for (int i = 0; i < activityController.allCards.length; i++)
                  listOfRequest(activityController.allCards[i],context),
                Container(height: ScreenConstant.defaultHeightFifteen,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("---------- "),
                  Text("or"),
                  Text("---------- "),
                ],),
                Container(height: ScreenConstant.defaultHeightFifteen,),
                AppButton(
                  buttonText: AppLabels.payWithPaypal.tr,
                  buttonTextStyle: TextStyles.buttonTitle,
                  iconButton: true,
                  buttonIcon: Icons.arrow_right_alt_outlined,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => UsePaypal(
                            sandboxMode: true,
                            clientId:
                            "ATWSHhVuZjIAWF-W6PH5TXNlBMcs9MRE5qSm5B5_Xvas2f_EN2IVm0YTuw6oUfeJPb7VJ00MjQvMkoXb",
                            secretKey:
                            "EJJOZ0M6Ep2UglUK7qiNv4y5ybB7-et7e3a1qknWsWNlSspv8twKkbcfQImnjVnNqw997Lt47IAr4sFc",
                            returnURL: "https://samplesite.com/return",
                            cancelURL: "https://samplesite.com/cancel",
                            transactions: [
                              {
                                "amount": {
                                  "total": walletController.walletAmount.text,
                                  "currency": "USD",
                                  "details": {
                                    "subtotal": walletController.walletAmount.text,
                                    "shipping": '0',
                                    "shipping_discount": 0
                                  }
                                },
                                "description":
                                "The payment transaction description.",
                                // "payment_options": {
                                //   "allowed_payment_method":
                                //       "INSTANT_FUNDING_SOURCE"
                                // },
                                "item_list": {
                                  "items": [
                                    {
                                      "name": "A demo product",
                                      "quantity": 1,
                                      "price": walletController.walletAmount.text,
                                      "currency": "USD"
                                    }
                                  ],

                                  // shipping address is not required though
                                  // "shipping_address": {
                                  //   "recipient_name": "Jane Foster",
                                  //   "line1": "Travis County",
                                  //   "line2": "",
                                  //   "city": "Austin",
                                  //   "country_code": "US",
                                  //   "postal_code": "73301",
                                  //   "phone": "+00000000",
                                  //   "state": "Texas"
                                  // },
                                }
                              }
                            ],
                            note: "Contact us for any questions on your order.",
                            onSuccess: (Map params) async {
                              Get.back();
                              Get.back();
                              activityController.cvvController.text = "";
                              walletController.addMoneyToWalletUsingPayPal(walletController.walletAmount.text);
                              walletController.walletAmount.text = "";
                               //Get.back();
                              Get.showSnackbar(Ui.SuccessSnackBar(
                                  message: "Money Added Successfully"));
                              print("onSuccess: $params");
                            },
                            onError: (error) {
                              Get.back();
                              Get.back();
                              print("onError: $error");
                            },
                            onCancel: (params) {
                              print('cancelled: $params');
                            }),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  listOfRequest(Data allCard,BuildContext context) {
    return ExpansionTile(
      collapsedIconColor: Theme.of(context).indicatorColor,
      collapsedTextColor: AppColors.blackTextColor,
      textColor: Colors.black,
      iconColor: Theme.of(context).indicatorColor,
      title: Text("**** **** **** ${allCard.numberLast}",style: Theme.of(context).textTheme.displaySmall,),
      subtitle: Text("${allCard.expMonth} / ${allCard.expYear}",style: Theme.of(context).textTheme.displaySmall,),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: TextFormField(
            style: Theme.of(context).textTheme.displaySmall,
            controller: activityController.cvvController,
            keyboardType: TextInputType.number,
            autofocus: false,
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.done,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            validator: (val) => CardUtils.validateCVV(val!),
            obscureText: true,
            decoration: InputDecoration(
              hintStyle:Theme.of(context).textTheme.labelSmall,
              hintText: AppLabels.cvv,
              //filled: true,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset(
                  Assets.cvv,
                  color: AppColors.primaryColorDashHash,
                ),
              ),
              //Image.asset(Assets.cvv),
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
        Container(
          height: 20.ss,
        ),
        InkWell(
          onTap: (){
            debugPrint("de${activityController.cvvController.text.length}");
            if(activityController.cvvController.text.isEmpty || activityController .cvvController.text.length < 3){
              Get.showSnackbar(Ui.ErrorSnackBar(
                  title: "CVV field is empty",
                  message: "Kindly enter valid cvv."));
            }else{
              showAlertDialog(context,allCard.id);
            }
          },
          child: Container(
            height: 40.ss,
            width: 100.ss,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColorDashHash),
            child: Center(
                child: Text(
              AppLabels.verify,
              style: TextStyle(
                color: AppColors.white,
                fontSize: FontSize.s18,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            )),
          ),
        ),
        Container(
          height: 20.ss,
        ),
      ],
    );
  }
  showAlertDialog(BuildContext context,int? id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 14.fss),
      ),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Confirm",
        style: TextStyle(
          color: AppColors.appPrimaryColor,
          fontSize: 14.fss,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () async {
        Get.back();
        controller.addMoneyToWallet(id.toString());
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Theme.of(context).canvasColor,
      title: Text(
        "Add Money!",
        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: 14.fss)
      ),
      content: Text(
        "Are you sure you want to add money to wallet?",
        style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 12.fss),
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
