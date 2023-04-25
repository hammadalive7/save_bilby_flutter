import 'package:flutter/material.dart';
import 'package:save_the_bilby_fund/constants/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../features/user/controllers/category_cntroller.dart';
import '../features/user/controllers/data_controller.dart';
import '../features/user/controllers/session_controller.dart';
import '../utils/utils.dart';

class CategoryCard extends StatefulWidget {
  late final String category_name;
  late final String image_url;

  // this is URL for send email function

  final String URL_Image;

  CategoryCard(
      {super.key,
      required this.category_name,
      required this.image_url,
      required this.URL_Image});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

//Email service

class _CategoryCardState extends State<CategoryCard> {
  bool isCritical = false;
  int clickednum = 1;

  final DateTime now = DateTime.now();
  final DateFormat formater = DateFormat('dd-MM-yyyy');

  final DatabaseReference ref = FirebaseDatabase.instance.ref('Users');

  //REFERENCE TO USERS
  final DatabaseReference reference =
      FirebaseDatabase.instance.ref('Categorized_images');

  //EMAIL SERVICE FUNCTION

  Future sendCriticalEmail(String ImageURL, String UserEmail,String animalName) async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const serviceId = "service_zlcbq3h";
    const templateId = "template_ars5g2u";
    const userId = "3OstZ3o-MZkiyPCwd";

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "service_id": serviceId,
          "template_id": templateId,
          "user_id": userId,
          "template_params": {
            "name": "${UserEmail}",
            "subject": "${animalName} Detected",
            "message":
                "Critical Image URL= ${ImageURL}\nAnimal Detected= ${animalName}\nDate of Detection= ${formater.format(now)}\nEmail of Detector= ${UserEmail}",
            "user_email": UserEmail.toString(),
          }
        }));

    if (response.statusCode == 200) {
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 100.0),
        content: Text(
          "Email Sent",
          style: TextStyle(color: Colors.green),
        ),
      );
    } else {
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 100.0),
        content: Text(response.body),
      );
    }

    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: ref.child(SessionController().userid.toString()).onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

            int rewardP = map['RewardPoints'];
            int Cateimg = map['ImageCategorized'];
            String mail = map['email'];

            return InkWell(
              onTapDown: ((details) {
                setState(() {
                  // this.widget.rewardpoints = this.widget.rewardpoints++;
                  // this.widget.ImageCategorized++;
                });
              }),
              splashColor: Color(0xff455A64),
              onTap: (() async {
                if (clickednum == 1) {
                  clickednum = 0;
                  if (ImageController().imageleft == true) {
                    DataController().clicked = true;
                    if (this.widget.category_name == 'Cat'||this.widget.category_name == 'Dog'||this.widget.category_name == 'Fox') {
                      isCritical = true;
                      await sendCriticalEmail(this.widget.URL_Image, mail,this.widget.category_name);
                    }
                    debugPrint("Clicked");
                    ref.child(SessionController().userid.toString()).update({
                      'RewardPoints': rewardP + 10,
                      'ImageCategorized': Cateimg + 1,
                    });
                    debugPrint(this.widget.URL_Image);
                    reference
                        .child(DateTime.now().microsecondsSinceEpoch.toString())
                        .set({
                      'Category  : ': this.widget.category_name,
                      'Critical': isCritical,
                      'Date Categorized': formater.format(now),
                      'Image Url': this.widget.URL_Image,
                      'User email': mail,
                    }).whenComplete(() => {
                              Utils.toastMessageS(
                                  "Image Categorized as \"${this.widget.category_name}\"")
                            });
                  } else {
                    Utils.toastMessageF("Cannot Categorize more images");
                  }
                } else {
                  Utils.toastMessageF("Already Categorized this image");
                }
              }),
              child: Ink(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    shadowColor: Colors.black,
                    elevation: 25.0,
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(image: AssetImage(this.widget.image_url)),
                        Text(
                          this.widget.category_name,
                          style: TextStyle(
                              color: tPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          return Center(child: CircularProgressIndicator());
        });
  }
}
