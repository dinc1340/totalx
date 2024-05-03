// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:totalx/screens/homepage.dart';
import 'package:totalx/screens/otp.dart';

class OtpProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String verid = "";
  bool otpsend = false;

  void sendOtp(String mob, BuildContext context) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: mob,
        verificationCompleted: (phoneAuthCredential) {},
        verificationFailed: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message ?? "Error"),
            ),
          );
        },
        timeout: const Duration(minutes: 1),
        codeSent: (verificationId, forceResendingToken) {
          verid = verificationId;
          otpsend = true;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpPage(phone: mob),
          ));
    } on FirebaseAuthException catch (e) {
      otpsend = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? "firebase exception errors"),
        ),
      );
    } catch (e) {
      otpsend = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Somthing went wrong"),
        ),
      );
    }
  }

  void verifyOtp(BuildContext context, String otp) async {
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verid, smsCode: otp);
      await auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Success"),
        ),
      );

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool('login', true);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? "firebase exception"),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Somthing Wrong"),
        ),
      );
    }
  }
}
