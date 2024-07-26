import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/addfood/bindings/addfood_binding.dart';
import '../modules/addfood/views/addfood_view.dart';
import '../modules/addimage/bindings/addimage_binding.dart';
import '../modules/addimage/views/addimage_view.dart';
import '../modules/allfoodcategory/bindings/allfoodcategory_binding.dart';
import '../modules/allfoodcategory/views/allfoodcategory_view.dart';
import '../modules/cardinfo/bindings/cardinfo_binding.dart';
import '../modules/cardinfo/views/cardinfo_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/editfood/bindings/editfood_binding.dart';
import '../modules/editfood/views/editfood_view.dart';
import '../modules/edituser/bindings/edituser_binding.dart';
import '../modules/edituser/views/edituser_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/menupict/bindings/menupict_binding.dart';
import '../modules/menupict/views/menupict_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/searchuser/bindings/searchuser_binding.dart';
import '../modules/searchuser/views/searchuser_view.dart';
import '../modules/userinfo/bindings/userinfo_binding.dart';
import '../modules/userinfo/views/userinfo_view.dart';
import '../modules/viewimage/bindings/viewimage_binding.dart';
import '../modules/viewimage/views/viewimage_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.landing,
      page: () => const LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.otp,
      page: () => OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.userinfo,
      page: () => const UserinfoView(),
      binding: UserinfoBinding(),
    ),
    GetPage(
      name: _Paths.addimage,
      page: () => const AddimageView(),
      binding: AddimageBinding(),
    ),
    GetPage(
      name: _Paths.addfood,
      page: () => const AddfoodView(),
      binding: AddfoodBinding(),
    ),
    GetPage(
      name: _Paths.menupict,
      page: () => const MenupictView(),
      binding: MenupictBinding(),
    ),
    GetPage(
      name: _Paths.allfoodcategory,
      page: () => const AllfoodcategoryView(),
      binding: AllfoodcategoryBinding(),
    ),
    GetPage(
      name: _Paths.editfood,
      page: () => const EditfoodView(),
      binding: EditfoodBinding(),
    ),
    GetPage(
      name: _Paths.viewimage,
      page: () => const ViewimageView(),
      binding: ViewimageBinding(),
    ),
    GetPage(
      name: _Paths.chat,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.searchuser,
      page: () => SearchuserView(),
      binding: SearchuserBinding(),
    ),
    GetPage(
      name: _Paths.edituser,
      page: () => const EdituserView(),
      binding: EdituserBinding(),
    ),
    GetPage(
      name: _Paths.about,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.cardinfo,
      page: () => const CardinfoView(),
      binding: CardinfoBinding(),
    ),
  ];
}
