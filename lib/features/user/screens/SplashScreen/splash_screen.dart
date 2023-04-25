import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:save_the_bilby_fund/features/user/controllers/session_controller.dart';
import 'package:save_the_bilby_fund/features/user/screens/login/login_screen.dart';
import 'package:save_the_bilby_fund/constants/colors.dart';
import '../Category/navigation.dart';
import '../signup/verify_email_page.dart';

// In Splash screen we initialized firebase authentication and check if user already loggedin then it will take him to Home screen
class Splash extends StatefulWidget {


  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<Splash> {
  FirebaseAuth auth = FirebaseAuth.instance;



  FirebaseMessaging _messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    getToken();
    initMessaging();
    final user = auth.currentUser;
    // Firebase.initializeApp().then((value) => Get.put(AuthenticationRepository()));
    if(user != null){
      SessionController().userid = user.uid.toString();
      Timer(Duration(seconds: 3), ()=> Get.offAll(() =>  VerifyEmailPage()));

    }else{
      // print("hello");
      Timer(Duration(seconds: 3), ()=> Get.offAll(() =>  LoginScreen()));

    }

  }

  @override
  Widget build(BuildContext context) {

    return Container(
        color: tPrimaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/images/whitebilby.png"), height: 160),

            SizedBox(height: 50,),

            // Text(
            //   "Save the Bilby Funds",
            //   style: TextStyle(
            //       fontSize: 23,
            //       fontWeight: FontWeight.w400,
            //       color: Colors.white),
            // ),
          ],
        ),



    );


  }

  void getToken() {
    _messaging.getToken().then((value){
      String? token = value;
      print(token);
    });
  }

  void initMessaging(){
    var androiInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInit = DarwinInitializationSettings();
    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initSetting);
    var androidDetails = AndroidNotificationDetails('1', 'Default', channelDescription: "Channel Discription", importance: Importance.high, priority: Priority.high);
    var iosDetails = DarwinNotificationDetails();
    var generalNotificationDetails = NotificationDetails(android: androidDetails,iOS: iosDetails);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message!.notification!;
      AndroidNotification android = message.notification!.android!;
      if(notification != null && android != null){
        flutterLocalNotificationsPlugin.show(notification.hashCode, notification.title, notification.body, generalNotificationDetails);
      }

    });

  }


}
