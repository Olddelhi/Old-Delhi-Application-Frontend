import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:old_delhi_food/app/ui/Home/home_binding.dart';
import 'package:old_delhi_food/app/ui/Home/home_screen.dart';
import 'package:old_delhi_food/app/ui/add_card/add_card_binding.dart';
import 'package:old_delhi_food/app/ui/add_card/add_card_screen.dart';
import 'package:old_delhi_food/app/ui/cart_screen/cart_binding.dart';
import 'package:old_delhi_food/app/ui/cart_screen/cart_screen.dart';
import 'package:old_delhi_food/app/ui/checkout/checkout_binding.dart';
import 'package:old_delhi_food/app/ui/checkout/checkout_screen.dart';
import 'package:old_delhi_food/app/ui/dashboard/dashboard_binding.dart';
import 'package:old_delhi_food/app/ui/dashboard/dashboard_screen.dart';
import 'package:old_delhi_food/app/ui/edit_profile/edit_profile_binding.dart';
import 'package:old_delhi_food/app/ui/edit_profile/edit_profile_screen.dart';
import 'package:old_delhi_food/app/ui/food_detail/food_detail_binding.dart';
import 'package:old_delhi_food/app/ui/food_detail/food_detail_screen.dart';
import 'package:old_delhi_food/app/ui/forget_password/forget_password_binding.dart';
import 'package:old_delhi_food/app/ui/forget_password/forget_password_screen.dart';
import 'package:old_delhi_food/app/ui/location_access/location_access_binding.dart';
import 'package:old_delhi_food/app/ui/location_access/location_access_screen.dart';
import 'package:old_delhi_food/app/ui/login_screen/login_binding.dart';
import 'package:old_delhi_food/app/ui/login_screen/login_screen.dart';
import 'package:old_delhi_food/app/ui/maually_detail/manually_detail_screen.dart';
import 'package:old_delhi_food/app/ui/my_addresses/my_addresses_binding.dart';
import 'package:old_delhi_food/app/ui/my_addresses/my_addresses_screen.dart';
import 'package:old_delhi_food/app/ui/new_password/new_password_binding.dart';
import 'package:old_delhi_food/app/ui/otp_verification/opt_verification_binding.dart';
import 'package:old_delhi_food/app/ui/otp_verification/oto_verification_screen.dart';
import 'package:old_delhi_food/app/ui/payment_method/payment_method_binding.dart';
import 'package:old_delhi_food/app/ui/payment_method/payment_method_screen.dart';
import 'package:old_delhi_food/app/ui/payment_successfull/payment_successfull_binding.dart';
import 'package:old_delhi_food/app/ui/payment_successfull/payment_successfull_screen.dart';
import 'package:old_delhi_food/app/ui/personal_info/personal_info_binding.dart';
import 'package:old_delhi_food/app/ui/personal_info/personal_info_screen.dart';
import 'package:old_delhi_food/app/ui/popular_shop/popular_shop_screen.dart';
import 'package:old_delhi_food/app/ui/profile/profile_Binding.dart';
import 'package:old_delhi_food/app/ui/profile/profile_screen.dart';
import 'package:old_delhi_food/app/ui/search_product/search_product_binding.dart';
import 'package:old_delhi_food/app/ui/search_product/search_projuct_screen.dart';
import 'package:old_delhi_food/app/ui/shop_item/shop_item_binding.dart';
import 'package:old_delhi_food/app/ui/shop_item/shop_item_screen.dart';
import 'package:old_delhi_food/app/ui/shop_list/shop_list_binding.dart';
import 'package:old_delhi_food/app/ui/shop_list/shop_list_screen.dart';
import 'package:old_delhi_food/app/ui/signup_screen/signup_binding.dart';
import 'package:old_delhi_food/app/ui/signup_screen/signup_screen.dart';
import 'package:old_delhi_food/app/ui/splash_screen/splash_screen.dart';
import 'package:old_delhi_food/app/ui/splash_screen/splash_screen_binding.dart';
import 'package:old_delhi_food/app/ui/track_order/track_order_binding.dart';
import 'package:old_delhi_food/app/ui/track_order/track_order_screen.dart';
import 'package:old_delhi_food/app/ui/your_favourite/your_favourite_binding.dart';
import 'package:old_delhi_food/app/ui/your_favourite/your_favourite_screen.dart';
import 'package:old_delhi_food/app/ui/your_order/your_order_binding.dart';
import 'package:old_delhi_food/app/ui/your_order/your_order_screen.dart';
import 'package:old_delhi_food/app/utils/app_pages.dart';

import '../ui/maually_detail/manually_detail_binding.dart';
import '../ui/new_password/new_password_screen.dart';

class AppRoutes {
  static final List<GetPage> routes = [
    GetPage(
      name: AppPages.splashScreen,
      page: () => SplashScreen(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: AppPages.loginScreen,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppPages.signUpScreen,
      page: () => SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppPages.forgetPasswordScreen,
      page: () => ForgetPasswordScreen(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: AppPages.otpVerificationScreen,
      page: () => OtpVerificationScreen(),
      binding: OtpVerificationBinding(),
    ),
    GetPage(
      name: AppPages.newPasswordScreen,
      page: () => NewPasswordScreen(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: AppPages.locationAccessScreen,
      page: () => LocationAccesScreen(),
      binding: LocationAccessBinding(),
    ),
    GetPage(
      name: AppPages.dashboard,
      page: () => DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppPages.homeScreen,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppPages.cartScreen,
      page: () => const CartScreen(),
      binding: CartBinding(),
    ),
    GetPage(
      name: AppPages.profileScreen,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppPages.manuallyDetailScreen,
      page: () => ManuallyDetailScreen(),
      binding: ManuallyDetailBinding(),
    ),
    GetPage(
      name: AppPages.searchProductScreen,
      page: () => SearchProductScreen(),
      binding: SearchProductBinding(),
    ),
    GetPage(
      name: AppPages.shopItemScreen,
      page: () => ShopItemScreen(),
      binding: ShopItemBinding(),
    ),
    GetPage(
      name: AppPages.yourOrderScreen,
      page: () => YourOrderScreen(),
      binding: YourOrderBinding(),
    ),
    GetPage(
      name: AppPages.yourFavouriteScreen,
      page: () => YourFavouriteScreen(),
      binding: YourFavouriteBinding(),
    ),
    GetPage(
      name: AppPages.personalInfoScreen,
      page: () => const PersonalInfoScreen(),
      binding: PersonalInfoBinding(),
    ),
    GetPage(
      name: AppPages.checkoutScreen,
      page: () => CheckoutScreen(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: AppPages.paymentMethodScreen,
      page: () => PaymentMethodScreen(),
      binding: PaymentMethodBinding(),
    ),
    GetPage(
      name: AppPages.addCardScreen,
      page: () => AddCardScreen(),
      binding: AddCardBinding(),
    ),
    GetPage(
      name: AppPages.paymentSuccessfulScreen,
      page: () => PaymentSuccessfullScreen(),
      binding: PaymentSuccessfullBinding(),
    ),
    GetPage(
      name: AppPages.paymentUnSuccessfulScreen,
      page: () => PaymentUnSuccessfullScreen(),
      binding: PaymentUnSuccessfullBinding(),
    ),
    GetPage(
      name: AppPages.trackOrderScreen,
      page: () => TrackOrderScreen(),
      binding: TrackOrderBinding(),
    ),
    GetPage(
      name: AppPages.editProfileScreen,
      page: () => EditProfileScreen(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: AppPages.foodDetailScreen,
      page: () => FoodDetailScreen(),
      binding: FoodDetailBinding(),
    ),
    GetPage(
      name: AppPages.myAddressesScreen,
      page: () => MyAddressesScreen(),
      binding: MyAddressesBinding(),
    ),
    GetPage(
      name: AppPages.shopListScreen,
      page: () => ShopListScreen(),
      binding: ShopListBinding(),
    ),
    GetPage(
      name: AppPages.popularShopScreen,
      page: () => PopularShopScreen(),
      binding: ShopListBinding(),
    ),
  ];
}
