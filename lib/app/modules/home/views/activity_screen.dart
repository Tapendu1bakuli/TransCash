import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizing/sizing.dart';
import 'package:trans_cash_solution/common/device_manager/colors.dart';
import '../../../../common/device_manager/screen_constants.dart';
import '../../../../common/helper.dart';
import '../controller/activity_controller.dart';
import 'activity_list_screen.dart';
import 'manage_Screen.dart';
import 'manage_bank_accounts_screen.dart';

class ActivityScreen extends GetView<ActivityController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor:Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Color(0xFFA7A7A7), width: 1.0),
                    ),
                  ),
                  child: TabBar(
                      isScrollable: true,
                      indicatorColor: AppColors.baseBlack,
                      labelPadding: EdgeInsets.symmetric(
                          horizontal: 20.ss, vertical: 10.ss),
                      labelStyle: TextStyle(
                        fontSize: FontSize.s16,
                        fontWeight: FontWeight.w500,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: FontSize.s16,
                        fontWeight: FontWeight.w500,
                      ),
                      labelColor: const Color(0xFF3A3A3A),
                      tabs: [Text("Activity",style: Theme.of(context).textTheme.displaySmall,), Text("Manage cards",style: Theme.of(context).textTheme.displaySmall),Text("Manage bank accounts",style: Theme.of(context).textTheme.displaySmall)]),
                )),
          ),
          body: TabBarView(children: [
            ActivityListScreen(),
            ManageScreen(),
            ManageBankAccountScreen()
          ]),
        ),
      ),
    );
  }
}
