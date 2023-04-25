



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_the_bilby_fund/features/user/controllers/session_controller.dart';
import 'package:save_the_bilby_fund/utils/utils.dart';
import '../screens/Category/navigation.dart';
import '../screens/signup/verify_email_page.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();


  // TextField Controllers to get data from TextFields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  // TextField Validation

  //Call this Function from Design & it will do the rest
  void loginUser(String email, String password) async {

    FirebaseAuth auth = FirebaseAuth.instance;


    // user authentication
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password).then((value){
        SessionController().userid = value.user!.uid.toString();       // this Session will store current user ID that will be useful for showing current user profile info

        Get.offAll(() => const VerifyEmailPage());
        Utils.toastMessageS("Logged in Successfully:)");

      }).onError((error, stackTrace){
        Utils.toastMessageF(error.toString());
      });
      

    }catch(error){

      Utils.toastMessageF(error.toString());

    }


  }
}