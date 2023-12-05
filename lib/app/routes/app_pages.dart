import 'package:get/get.dart';

import '../modules/OTP/bindings/otp_binding.dart';
import '../modules/OTP/views/otp_view.dart';
import '../modules/admin_category/bindings/admin_category_binding.dart';
import '../modules/admin_category/views/admin_category_view.dart';
import '../modules/admin_home/bindings/admin_home_binding.dart';
import '../modules/admin_home/views/admin_home_view.dart';
import '../modules/admin_main/bindings/admin_main_binding.dart';
import '../modules/admin_main/views/admin_main_view.dart';
import '../modules/admin_product/bindings/admin_product_binding.dart';
import '../modules/admin_product/views/admin_product_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/forgetPassword/bindings/forget_password_binding.dart';
import '../modules/forgetPassword/views/forget_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/homepage/bindings/homepage_binding.dart';
import '../modules/homepage/views/homepage_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/myLearning/bindings/my_learning_binding.dart';
import '../modules/myLearning/views/my_learning_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/personalInformation/bindings/personal_information_binding.dart';
import '../modules/personalInformation/bindings/personal_information_binding.dart';
import '../modules/personalInformation/views/personal_information_view.dart';
import '../modules/personalInformation/views/personal_information_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/searchpage/bindings/searchpage_binding.dart';
import '../modules/searchpage/views/searchpage_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.HOMEPAGE,
      page: () => const HomepageView(),
      binding: HomepageBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_MAIN,
      page: () => const AdminMainView(),
      binding: AdminMainBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.SEARCHPAGE,
      page: () => const SearchpageView(),
      binding: SearchpageBinding(),
    ),
    GetPage(
      name: _Paths.MY_LEARNING,
      page: () => const MyLearningView(),
      binding: MyLearningBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_HOME,
      page: () => const AdminHomeView(),
      binding: AdminHomeBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_CATEGORY,
      page: () => const AdminCategoryView(),
      binding: AdminCategoryBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PRODUCT,
      page: () => const AdminProductView(),
      binding: AdminProductBinding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_INFORMATION,
      page: () => const PersonalInformationView(),
      binding: PersonalInformationBinding(),
      children: [
        GetPage(
          name: _Paths.PERSONAL_INFORMATION,
          page: () => const PersonalInformationView(),
          binding: PersonalInformationBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => const NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
  ];
}
