import 'package:get/get.dart';

class AddProductController extends GetxController {
  var isAdded = true.obs;

  final count = 0.obs;

  void increment() => count.value++;
}
