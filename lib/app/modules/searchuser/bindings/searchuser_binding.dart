import 'package:get/get.dart';

import '../controllers/searchuser_controller.dart';

class SearchuserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchuserController>(
      () => SearchuserController(),
    );
  }
}
