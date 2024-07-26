import 'package:get/get.dart';

import '../controllers/editfood_controller.dart';

class EditfoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditfoodController>(
      () => EditfoodController(),
    );
  }
}
