import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardinfoController extends GetxController {
  late TextEditingController number1;
  late TextEditingController number2;
  late TextEditingController name1;
  late TextEditingController name2;

  @override
  void onInit() {
    number1 = TextEditingController();
    number2 = TextEditingController();
    name1 = TextEditingController();
    name2 = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    number1.dispose();
    number2.dispose();
    name1.dispose();
    name2.dispose();
    super.dispose();
  }
}
