import 'package:get/get.dart';

import '../controllers/menupict_controller.dart';

class MenupictBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenupictController>(
      () => MenupictController(),
    );
  }
}
