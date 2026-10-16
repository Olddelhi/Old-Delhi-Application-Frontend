import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:old_delhi_food/app/ui/dashboard/dashboard_controller.dart';
import 'package:old_delhi_food/app/utils/app_assets.dart';
import 'package:old_delhi_food/app/utils/app_size.dart';

import '../Home/home_screen.dart';
import '../cart_screen/cart_controller.dart';
import '../cart_screen/cart_screen.dart';
import '../profile/profile_screen.dart';

class DashboardScreen extends GetView<DashboardController> {
  DashboardScreen({super.key});

  @override
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _getTabScreen(controller.currentIndex.value)),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.currentIndex.value = index;
            if (index == 1) {
              var cartController = Get.put(CartController());
              cartController.getCartItems();
            }
          },
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(AppAssets.homeIcon,
                    color: Colors.grey, height: AppSize.height25),
                label: '',
                activeIcon:
                    Image.asset(AppAssets.homeIcon, height: AppSize.height25)),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.cartIcon,
                color: Colors.grey,
                height: AppSize.height25,
              ),
              label: '',
              activeIcon:
                  Image.asset(AppAssets.cartIcon, height: AppSize.height25),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(AppAssets.profileIcon,
                  color: Colors.grey, height: AppSize.height25),
              label: '',
              activeIcon:
                  Image.asset(AppAssets.profileIcon, height: AppSize.height25),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getTabScreen(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return const CartScreen(
          isNav: true,
        );
      case 2:
        return ProfileScreen();
      default:
        return Container();
    }
  }
}
