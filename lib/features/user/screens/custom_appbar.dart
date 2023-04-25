
// This is a custom AppBar that we have used in most of the screen except Login and Profile
// It take Text and icon as a parameter


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_the_bilby_fund/constants/colors.dart';


AppBar customAppBar(String tit, IconData? iconi) {

  return AppBar(
    backgroundColor: tPrimaryColor,
    centerTitle: true,
    automaticallyImplyLeading: false,

    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(40),
      ),
    ),

    bottom: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: Container(
          padding: const EdgeInsets.only(bottom: 15),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 15,),
                  Center(
                    child: SizedBox.fromSize(
                      size: Size(56, 56),
                      child: ClipOval(
                        child: Material(
                          color: tPrimaryColor,
                          child: InkWell(
                            splashColor: Colors.white,
                            onTap: () {  Get.back();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 50,),

                  Image(image: AssetImage("assets/images/whitebilby.png"), height: 100),
                ],
              ),

              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    Text(
                      tit,
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),

                  ],
                ),
              )
            ],
          ),
        )),
  );
}