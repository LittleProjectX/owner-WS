import 'package:get/get.dart';

import '../controllers/addfood_controller.dart';

class AddfoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddfoodController>(
      () => AddfoodController(),
    );
  }
}
