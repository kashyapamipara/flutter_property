
import 'package:flutter_property/app/Screens/login_screen/login_binding.dart';
import 'package:flutter_property/app/Screens/login_screen/login_view.dart';
import 'package:flutter_property/app/Screens/property/property_binfing.dart';
import 'package:flutter_property/app/Screens/register_screen/register_binding.dart';
import 'package:flutter_property/app/Screens/register_screen/register_view.dart';

import '../Screens/property/add_property/add_property_binding.dart';
import '../Screens/property/add_property/add_property_virew.dart';
import '../Screens/property/property_view.dart';
import '../Screens/splash_screen/splash_binding.dart';
import '../Screens/splash_screen/splash_view.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

Duration transitionDuration = const Duration(milliseconds: 500);

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => SplashView(),
      binding: SplashBinding(),
      transition: Transition.downToUp,
      // customTransition: CustomAnimationTransition(),
      transitionDuration: const Duration(milliseconds: 2000),
    ),

    GetPage(
      name: Routes.property,
      page: () => const PropertyView(),
      binding: PropertyBinding(),
      transition: Transition.fadeIn,
      transitionDuration: transitionDuration,
    ),
     GetPage(
       binding: AddPropertyBinding(),
       transition: Transition.fadeIn,
       name: Routes.addProperty,
      page: () => const AddPropertyView(),
     transitionDuration: transitionDuration,
    ),
    GetPage(
      binding: LoginBinding(),
      transition: Transition.fadeIn,
      name: Routes.login,
      page: () =>  LoginView(),
      transitionDuration: transitionDuration,
    ),
    GetPage(
      binding: RegisterBinding(),
      transition: Transition.fadeIn,
      name: Routes.register,
      page: () => const RegisterView(),
      transitionDuration: transitionDuration,
    ),
  ];
}
