import 'package:e_learn/app/modules/admin_category/views/admin_category_view.dart';
import 'package:e_learn/app/modules/admin_home/views/admin_home_view.dart';
import 'package:e_learn/app/modules/admin_product/views/admin_product_view.dart';
import 'package:e_learn/app/modules/all_users/views/all_users_view.dart';
import 'package:e_learn/app/modules/profile/views/profile_view.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:global_bottom_navigation_bar/widgets/bottom_navigation_item.dart';
import 'package:global_bottom_navigation_bar/widgets/scaffold_bottom_navigation.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:sizer/sizer.dart';

import '../controllers/main_adminhome_controller.dart';

class MainAdminhomeView extends GetView<MainAdminhomeController> {
  const MainAdminhomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return YourCustomBottomNavigation();
  }
}

class YourCustomBottomNavigation extends StatefulWidget {
  @override
  _YourCustomBottomNavigationState createState() =>
      _YourCustomBottomNavigationState();
}

class _YourCustomBottomNavigationState extends State<YourCustomBottomNavigation>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGlobalBottomNavigation(
      listOfChild: const [
        AdminHomeView(),
        AllUsersView(),
        AdminCategoryView(),
        AdminProductView(),
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
        BottomNavigationItem(
          activeIcon: Icon(
            FontAwesome.users,
            color: bottomnavigationBarColor,
            size: 23.sp,
          ),
          inActiveIcon: Icon(
            FontAwesome.users,
            color: Colors.grey,
            size: 20.sp,
          ),
          title: 'Users',
          color: Colors.white,
          vSync: this,
        ),
        BottomNavigationItem(
          activeIcon: Icon(
            Icons.category_rounded,
            color: bottomnavigationBarColor,
            size: 23.sp,
          ),
          inActiveIcon: Icon(
            Icons.category_outlined,
            color: Colors.grey,
            size: 20.sp,
          ),
          title: 'Category',
          color: Colors.white,
          vSync: this,
        ),
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
