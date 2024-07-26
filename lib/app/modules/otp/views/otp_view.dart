import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ownerwaroengsederhana/app/firebases/auth_service.dart';
import 'package:ownerwaroengsederhana/colors.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  OtpView({super.key});
  final verificationId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    AuthService authC = AuthService();
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: const Text('OtpView'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Kami telah mengirim kode verifikasi, silahkan cek pesan di HP anda',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: size.width * 0.5,
                child: TextField(
                  autocorrect: false,
                  autofocus: false,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 30, letterSpacing: 10),
                  decoration: const InputDecoration(
                      hintText: '------',
                      hintStyle: TextStyle(color: blackColor, fontSize: 30)),
                  controller: controller.otp,
                  onChanged: (value) {
                    if (value.length == 6) {
                      authC.getOTP(verificationId, value);
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
