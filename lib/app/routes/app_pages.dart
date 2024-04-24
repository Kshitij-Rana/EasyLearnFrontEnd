import 'package:get/get.dart';

import '../modules/OTP/bindings/otp_binding.dart';
import '../modules/OTP/views/otp_view.dart';
import '../modules/addCourseContent/bindings/add_course_content_binding.dart';
import '../modules/addCourseContent/views/add_course_content_view.dart';
import '../modules/addProduct/bindings/add_product_binding.dart';
import '../modules/addProduct/views/add_product_view.dart';
import '../modules/addQuiz/bindings/add_quiz_binding.dart';
import '../modules/addQuiz/views/add_quiz_view.dart';
import '../modules/admin_category/bindings/admin_category_binding.dart';
import '../modules/admin_category/views/admin_category_view.dart';
import '../modules/admin_home/bindings/admin_home_binding.dart';
import '../modules/admin_home/views/admin_home_view.dart';
import '../modules/admin_main/bindings/admin_main_binding.dart';
import '../modules/admin_main/views/admin_main_view.dart';
import '../modules/admin_product/bindings/admin_product_binding.dart';
import '../modules/admin_product/views/admin_product_view.dart';
import '../modules/all_users/bindings/all_users_binding.dart';
import '../modules/all_users/views/all_users_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/changePassword/bindings/change_password_binding.dart';
import '../modules/changePassword/views/change_password_view.dart';
import '../modules/coursecontent/bindings/coursecontent_binding.dart';
import '../modules/coursecontent/views/coursecontent_view.dart';
import '../modules/detailedCategoryCourses/bindings/detailed_category_courses_binding.dart';
import '../modules/detailedCategoryCourses/views/detailed_category_courses_view.dart';
import '../modules/editCourseContent/bindings/edit_course_content_binding.dart';
import '../modules/editCourseContent/views/edit_course_content_view.dart';
import '../modules/editCoursesAdmin/bindings/edit_courses_admin_binding.dart';
import '../modules/editCoursesAdmin/views/edit_courses_admin_view.dart';
import '../modules/edit_category/bindings/edit_category_binding.dart';
import '../modules/edit_category/views/edit_category_view.dart';
import '../modules/forgetPassword/bindings/forget_password_binding.dart';
import '../modules/forgetPassword/views/forget_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/homepage/bindings/homepage_binding.dart';
import '../modules/homepage/views/homepage_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mainAdminhome/bindings/main_adminhome_binding.dart';
import '../modules/mainAdminhome/views/main_adminhome_view.dart';
import '../modules/myLearning/bindings/my_learning_binding.dart';
import '../modules/myLearning/views/my_learning_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/paicourseContent/bindings/paicourse_content_binding.dart';
import '../modules/paicourseContent/views/paicourse_content_view.dart';
import '../modules/personalInformation/bindings/personal_information_binding.dart';
import '../modules/personalInformation/views/personal_information_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/quiz/bindings/quiz_binding.dart';
import '../modules/quiz/views/quiz_view.dart';
import '../modules/quizDetails/bindings/quiz_details_binding.dart';
import '../modules/quizDetails/views/quiz_details_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/searchpage/bindings/searchpage_binding.dart';
import '../modules/searchpage/views/searchpage_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/userDetail/bindings/user_detail_binding.dart';
import '../modules/userDetail/views/user_detail_view.dart';

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
      children: [
        GetPage(
          name: _Paths.CART,
          page: () => const CartView(),
          binding: CartBinding(),
        ),
      ],
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
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => const AddProductView(),
      binding: AddProductBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 700),
    ),
    GetPage(
      name: _Paths.ADD_COURSE_CONTENT,
      page: () => const AddCourseContentView(),
      binding: AddCourseContentBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 700),
      children: [
        GetPage(
          name: _Paths.ADD_COURSE_CONTENT,
          page: () => const AddCourseContentView(),
          binding: AddCourseContentBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.COURSECONTENT,
      page: () => CoursecontentView(),
      binding: CoursecontentBinding(),
    ),
    GetPage(
      name: _Paths.COURSECONTENTFORADMIN,
      page: () => CoursecontentView(isAdmin: true),
      binding: CoursecontentBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_CATEGORY,
      page: () => const EditCategoryView(),
      binding: EditCategoryBinding(),
    ),
    GetPage(
      name: _Paths.PAICOURSE_CONTENT,
      page: () => const PaicourseContentView(),
      binding: PaicourseContentBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_COURSES_ADMIN,
      page: () => const EditCoursesAdminView(),
      binding: EditCoursesAdminBinding(),
    ),
    GetPage(
      name: _Paths.QUIZ,
      page: () => const QuizView(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: _Paths.ADD_QUIZ,
      page: () => const AddQuizView(),
      binding: AddQuizBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_COURSE_CONTENT,
      page: () => const EditCourseContentView(),
      binding: EditCourseContentBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.USER_DETAIL,
      page: () => const UserDetailView(),
      binding: UserDetailBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_ADMINHOME,
      page: () => const MainAdminhomeView(),
      binding: MainAdminhomeBinding(),
    ),
    GetPage(
      name: _Paths.QUIZ_DETAILS,
      page: () => const QuizDetailsView(),
      binding: QuizDetailsBinding(),
    ),
    GetPage(
      name: _Paths.ALL_USERS,
      page: () => const AllUsersView(),
      binding: AllUsersBinding(),
    ),
    GetPage(
      name: _Paths.DETAILED_CATEGORY_COURSES,
      page: () => const DetailedCategoryCoursesView(),
      binding: DetailedCategoryCoursesBinding(),
    ),
  ];
}
