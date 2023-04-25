
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:save_the_bilby_fund/features/user/screens/SplashScreen/splash_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();


  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;


  //Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  /// If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
  _setInitialScreen(User? user)  {
    Get.offAll(() => Splash());
    // if(user != null){
    //   SessionController().userid = user!.uid.toString();
    //   Get.offAll(() => const Dash());
    // }else{
    //   Get.offAll(() => const LoginScreen());
    // }

  }

  // Future<String?> createUserWithEmailAndPassword(String email, String password) async {
  //   try {
  //     String UID = await _auth.createUserWithEmailAndPassword(email: email, password: password) as String;
  //     if(firebaseUser.value != null){
  //       Get.offAll(() => const LoginScreen());
  //     }else{
  //       Get.to(() => const SignUpScreen());
  //     }
  //     return UID;
  //   } on FirebaseAuthException catch (e){
  //     final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
  //     return ex.message;
  //   } catch (_) {
  //     const ex = SignUpWithEmailAndPasswordFailure();
  //     return ex.message;
  //   }
  //   return null;
  // }
  //
  //
  // Future<String?> loginWithEmailAndPassword(String email, String password) async {
  //   try {
  //     await _auth.signInWithEmailAndPassword(email: email, password: password);
  //     if(firebaseUser.value != null){
  //
  //       Get.offAll(() => const Dash());
  //     }else{
  //       Get.to(() => const LoginScreen());
  //     }
  //
  //   } on FirebaseAuthException catch (e) {
  //     final ex = LogInWithEmailAndPasswordFailure.code(e.code);
  //     return ex.message;
  //   } catch (_) {
  //     const ex = LogInWithEmailAndPasswordFailure();
  //     return ex.message;
  //   }
  //   return null;
  // }

  Future<void> logout() async => await _auth.signOut();


}