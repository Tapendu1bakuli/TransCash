import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trans_cash_solution/common/device_manager/colors.dart';
import '../../../../common/device_manager/assets.dart';
import '../controller/home_controller.dart';
import 'activity_screen.dart';
import 'home_view.dart';

class HomeBottomNavigationScreen extends GetView<HomeController> {
  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    ActivityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(controller.selectedIndex.value),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 0),
                child: ImageIcon(
                  AssetImage(
                    Assets.d1,
                  ),
                ),
              ),
              label: '',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: ImageIcon(
                  AssetImage(Assets.d2),
                ),
              ),
              label: '',
              backgroundColor: Colors.green,
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: AppColors.primaryColorDash,
          unselectedItemColor: const Color(0xFF6D6D6D),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    controller.selectedIndex.value = index;
  }
}
