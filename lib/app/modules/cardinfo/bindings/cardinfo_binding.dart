import 'package:get/get.dart';

import '../controllers/cardinfo_controller.dart';

class CardinfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardinfoController>(
      () => CardinfoController(),
    );
  }
}
