



import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:save_the_bilby_fund/features/user/controllers/session_controller.dart';
import '../../../utils/utils.dart';

//This controller is used to update user data on profile screen

class ProfileController extends GetxController{

  static ProfileController get instance => Get.find();


  DatabaseReference ref = FirebaseDatabase.instance.ref("Users");

      void updateprofile(String name, String phone){
        
        ref.child(SessionController().userid.toString()).update({
          'UserName': name,
          'Phone': phone,
        }
        ).onError((error, stackTrace){
          Utils.toastMessageF(error.toString());
        });



      }





  // getUserData(){
  //   // final email = _authRepo.firebaseUser.value?.email;
  //   if(email != null){
  //     return _userRepo.getUserDetails(email);
  //   }else{
  //     Get.snackbar("Error!", "Login to continue");
  //   }
  // }

}