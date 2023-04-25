import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/user/screens/SplashScreen/splash_screen.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';


//Function to initialize Firebase
Future<void> initializeDefault() async {
  //to Check Platform
  if (Platform.isAndroid) {
// Android-specific code
    debugPrint("Running on Android");
  } else if (Platform.isIOS) {
// iOS-specific code
    debugPrint("Running on iOS");
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  debugPrint("main started");

  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // initializeDefault();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
      // .then((value) => Get.put(AuthenticationRepository()));

  print('Initialized default app');
  //to Check Platform
  if (Platform.isAndroid) {
// Android-specific code
    debugPrint("Running on Android");
  } else if (Platform.isIOS) {
// iOS-specific code
    debugPrint("Running on iOS");
  }  debugPrint("Firebase Initialized");
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: TAppTheme.lightTheme,
      // darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        textTheme: GoogleFonts.amaranthTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Splash(),
    );
  }

}




