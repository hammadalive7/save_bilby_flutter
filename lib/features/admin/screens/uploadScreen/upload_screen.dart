import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:save_the_bilby_fund/features/admin/screens/uploadScreen/upload_screen_backend.dart';
import 'package:save_the_bilby_fund/features/user/screens/custom_appbar.dart';
import '../../../../constants/colors.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);
  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final progressController = Get.put(UploadProgressController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: customAppBar("Admin Panel", Icons.arrow_back),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: tPrimaryColor,
        onPressed: () {
          progressController.isUploading.isTrue
              ? null
              : SelectAndUploadImages();
        },
        label: Text("Upload Images"),
        icon: Icon(Icons.upload_rounded),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Obx(() {
                  if (progressController.isUploading.isTrue) {
                    return LiquidCircularProgressIndicator(
                      // animation: true,
                      // animationDuration: 1000,
                      direction: Axis.vertical,
                      borderColor: tPrimaryColor,
                      borderWidth: 5.0,
                      backgroundColor: Colors.white38,
                      valueColor: AlwaysStoppedAnimation(tPrimaryColor),
                      center: Center(
                        child: Text(
                          "${((double.parse(progressController.imagesUploaded.toString()) / double.parse(progressController.totalImagesToUpload.toString())) * 100).toInt()}" +
                              "%",
                          style: TextStyle(fontSize: 26, color: footercolor),
                        ),
                      ),
                      value: double.parse(
                              progressController.imagesUploaded.toString()) /
                          double.parse(progressController.totalImagesToUpload
                              .toString()),
                    );
                  } else if (progressController.isDoneUploading.isTrue) {
                    return Center(
                      child: Container(
                          child: Text(
                        "Uploaded Successfully",
                        style: TextStyle(
                            fontSize: 26,
                            color: tPrimaryColor,
                            fontWeight: FontWeight.bold),
                      )),
                    );
                  } else {
                    return Center(
                      child: Container(
                          child: Text(
                        "tap on upload images\nto select & add images\nto database",
                        style: TextStyle(

                            fontSize: 20,
                            color: tPrimaryColor,
                            fontWeight: FontWeight.bold),
                      )),
                    );
                  }
                }),
              ),
              ElevatedButton(onPressed: getUsersEmailSaveAsCSV, child: Text("Download Users Email as CSV"),),
            ],
          ),
        ),
      ),
    ));
  }
}
