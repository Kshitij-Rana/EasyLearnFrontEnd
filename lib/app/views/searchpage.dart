import 'package:e_learn/app/models/courses.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/views/myCourses.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

HomepageController controller = Get.find();

class SearchButtonFunction extends SearchDelegate {
  @override
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
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
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
