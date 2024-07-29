import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ownerwaroengsederhana/app/firebases/auth_service.dart';
import 'package:ownerwaroengsederhana/colors.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginC = Get.put(LoginController());
  AuthService authC = AuthService();
  Country? country;
  String code = '0';
  String negara = 'Pilih Negara';
  bool isVisibility = false;
  final bool _isLoading = false;

  void selectCountry() {
    showCountryPicker(
      countryListTheme: CountryListThemeData(backgroundColor: backgroundColor),
      context: context,
      onSelect: (value) {
        setState(() {
          country = value;
          if (country != null) {
            isVisibility = true;
            code = country!.phoneCode;
            negara = country!.displayName.toString();
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return Scaffold(
      backgroundColor: tabColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: textColor),
        ),
        backgroundColor: tabColor,
        title: const Text('Verifikasi Telepon',
            style: TextStyle(color: textColor)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text('Silahkan memasukkan nomor telepon',
                style: TextStyle(fontSize: 18, color: textColor)),
            const SizedBox(height: 10),
            TextButton(onPressed: selectCountry, child: Text(negara)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Visibility(
                    visible: isVisibility,
                    child: Text('+$code',
                        style: const TextStyle(color: textColor)),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(label: Text('Nomor Telepon')),
                      controller: loginC.phone,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: size.height * 0.5),
            _isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    height: 50,
                    width: size.width * 0.7,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: () {
                        authC.siginWithPhone(code + loginC.phone.text, context);
                      },
                      child: const Text(
                        'VERIFIKASI',
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
