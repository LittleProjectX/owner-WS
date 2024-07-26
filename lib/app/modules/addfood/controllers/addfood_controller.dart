import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddfoodController extends GetxController {
  late TextEditingController name;
  late TextEditingController description;
  late TextEditingController price;

  @override
  void onInit() {
    name = TextEditingController();
    description = TextEditingController();
    price = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    price.dispose();
    super.dispose();
  }
}
