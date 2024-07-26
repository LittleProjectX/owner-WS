import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ownerwaroengsederhana/app/routes/app_pages.dart';

class AuthService extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void siginWithPhone(String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {}
          throw Exception(e.message);
        },
        codeSent: (String verificationId, int? resendToken) async {
          Get.toNamed(Routes.otp, arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) async {},
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  void getOTP(String verificationId, userOTP) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      await auth.signInWithCredential(credential);
      Get.offAllNamed(Routes.userinfo);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  void signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
