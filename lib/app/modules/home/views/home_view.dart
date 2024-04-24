import 'package:e_learn/app/modules/homepage/views/homepage_view.dart';
import 'package:e_learn/app/modules/myLearning/views/my_learning_view.dart';
import 'package:e_learn/app/modules/profile/views/profile_view.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:global_bottom_navigation_bar/global_bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const YourCustomBottomNavigation();
  }
}

class YourCustomBottomNavigation extends StatefulWidget {
  const YourCustomBottomNavigation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _YourCustomBottomNavigationState createState() =>
      _YourCustomBottomNavigationState();
}

class _YourCustomBottomNavigationState extends State<YourCustomBottomNavigation>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGlobalBottomNavigation(
      listOfChild: const [
        HomepageView(),
        // SearchpageView(),

        MyLearningView(),
        ProfileView(),
      ],
      listOfBottomNavigationItem: buildBottomNavigationItemList(),
    );
  }

  List<BottomNavigationItem> buildBottomNavigationItemList() => [
        BottomNavigationItem(
          activeIcon: Icon(
            Icons.home,
            color: bottomnavigationBarColor,
            size: 23.sp,
          ),
          inActiveIcon: Icon(
            Icons.home_outlined,
            color: Colors.grey,
            size: 20.sp,
          ),
          title: 'Home',
          color: Colors.white,
          vSync: this,
        ),
        // BottomNavigationItem(
        //   activeIcon: Icon(
        //     Icons.search_outlined,
        //     color: bottomnavigationBarColor,
        //     size: 23.sp,
        //   ),
        //   inActiveIcon: Icon(
        //     Icons.search_outlined,
        //     color: Colors.grey,
        //     size: 20.sp,
        //   ),
        //   title: 'Search',
        //   color: Colors.white,
        //   vSync: this,
        // ),
        BottomNavigationItem(
          activeIcon: Icon(
            Icons.menu_book_outlined,
            color: bottomnavigationBarColor,
            size: 23.sp,
          ),
          inActiveIcon: Icon(
            Icons.menu_book_rounded,
            color: Colors.grey,
            size: 20.sp,
          ),
          title: 'Learning',
          color: Colors.white,
          vSync: this,
        ),
        BottomNavigationItem(
          activeIcon: Icon(
            Icons.person_pin,
            color: bottomnavigationBarColor,
            size: 23.sp,
          ),
          inActiveIcon: Icon(
            Icons.person_outline,
            color: Colors.grey,
            size: 20.sp,
          ),
          title: 'Profile',
          color: Colors.white,
          vSync: this,
        ),
      ];
}
