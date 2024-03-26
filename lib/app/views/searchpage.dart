import 'package:e_learn/app/models/courses.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/views/myCourses.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

HomepageController controller = Get.find();

class SearchButtonFunction extends SearchDelegate {
  // const SearchpageView({Key? key}) : super(key: key);
  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('SearchpageView'),
  //       centerTitle: true,
  //     ),
  //     body: const Center(
  //       child: Text(
  //         'SearchpageView is working',
  //         style: TextStyle(fontSize: 20),
  //       ),
  //     ),
  //   );
  // }
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // throw UnimplementedError();
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<Courses> coursesSuggestions = [];
    coursesSuggestions = query.length == 0
        ? []
        : controller.courses
                ?.where((element) =>
                    element.courseName
                        ?.toLowerCase()
                        .contains(query.toLowerCase()) ??
                    false)
                .toList() ??
            [];
    if (query.length == 0) {
      return const Center(
          child: Text(
        'Search your fav courses',
        style: TextStyle(fontSize: 17),
      ));
    } else if (query.length > 0 && coursesSuggestions.isEmpty) {
      return const Center(
        child: Text(
          "No results found",
          style: TextStyle(fontSize: 17),
        ),
      );
    }

    return ListView.builder(
      itemCount: coursesSuggestions.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: MyCourses(
          course: coursesSuggestions[index],
          isSearch: true,
        ),
      ),
    );
  }
}
