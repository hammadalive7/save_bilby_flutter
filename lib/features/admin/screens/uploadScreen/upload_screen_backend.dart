import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebaseCore;
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../utils/utils.dart';
//Controller for upload Screen
class UploadProgressController extends GetxController {
  var imagesUploaded = 0.obs;//to check how many images have been uploaded
  var isUploading = false.obs;//to check either you are uploading images or not
  void increment() => imagesUploaded++;//GetX function to increment imagesUploaded
  var isDoneUploading = false.obs;//Bool to check if uploading is completed or not
  var totalImagesToUpload = 0.obs;//count to get how many images is going to upload in a shot
}
final uploadProgressController = Get.put(UploadProgressController());//crating GetX controller
final ImagePicker imagePicker = ImagePicker();//image picker instance that pick images from gallery
List<XFile>? imageFiles = [];//list of files to be uploaded (XFiles)
final imagesDatabaseRef = FirebaseDatabase.instance.ref().child("images");//images Database reference
final datastoreRef = FirebaseStorage.instance.ref();//firebase datastore reference\
List<String> emailsList = [];//list of Emails of all users present in Users database

//this function get the emails of users from realtime database and save it as CSV file

getUsersEmailSaveAsCSV() async {
  final snapshot = await FirebaseDatabase.instance.ref('Users').get();
  final map = await snapshot.value as Map<dynamic, dynamic>;
  map.forEach((key, value) {
    if(value['newsletterSubscription'].toString()=='true') {
      emailsList.add(value['email'].toString());
    }
  });
  debugPrint(emailsList.toString());//list of all user's emails present in database
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();//getting permission to to write file

  List<List<dynamic>> rows = [];//creating rows for CSV

  List<dynamic> row = [];
  row.add("Emails");//header of rows
  rows.add(row);
  for (int i = 0; i < emailsList.length; i++) {
    List<dynamic> row = [];
    row.add(emailsList[i]);
    rows.add(row);
  }

  String csv = const ListToCsvConverter().convert(rows);//converting data to csv
  var dir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);//storing path at download
  debugPrint("dir $dir");
  String file = "$dir";//

  File f = File(file + "/SaveBilbyUsersEmail.csv");//giving name to File

  f.writeAsString(csv).whenComplete(() {//creating file and show toast on completion
    debugPrint("Done Writing File to Downloads");
    Utils.toastMessageF("File Saved at ${dir}");

  });

}

//function to select images from gallery and upload it to database
Future SelectAndUploadImages() async {
  final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
  //if user have selected images
  if (selectedImages!.isNotEmpty)
  {
    debugPrint("Number of images selected = ${selectedImages.length}");
    //   int latestImageNumber =await getLastImageNumber();
    uploadProgressController.totalImagesToUpload.value = selectedImages.length;
    for (var image in selectedImages) {
      uploadProgressController.isUploading.value = true;
      File imageFileToUpload = await File(image.path); // selectedImages as XFile
      String fileName = await basename(image.path); //getting file name from the path
      fileName = fileName.substring(12, fileName.length - 4); //removing "image_picker" from start and ".jpg" from the end of file name
      fileName=fileName.replaceAll(RegExp('[^A-Za-z0-9]'), '');// removing special characters expect alphabets and numbers
      debugPrint("FILE NAME IS : ${fileName}");

      try {
        await datastoreRef
            .child('images/${fileName}')
            .putFile(imageFileToUpload)
            .whenComplete(() async {
          uploadProgressController.increment();//incrementing when a file is done uploading
          await datastoreRef
          //uploading images data to firebase realtime database
              .child('images/${fileName}')
              .getDownloadURL()
          //getting download URL of uploaded image
              .then((imageURL) async {
                //putting downloadURL to database with name and other attributes
            debugPrint("DOWNLOAD URL: ${imageURL}");
            await imagesDatabaseRef.child("${fileName}").set({
              "imageName": "${fileName}",
              "dateUploaded": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
              "imageURL": "${imageURL}",
              "isCategorized":"false",
              "categoryId":"unknown",
            });
          }).whenComplete(() => () {
//printing image name when done uploading is data to realtime database
                    debugPrint(
                        "Image Data saved to Realtime Database: ${fileName}");
                  });
        });
      } on firebaseCore.FirebaseException catch (e) {
        debugPrint("Error in Uploading File $e");
      }
    }
    //resetting variables
    uploadProgressController.isUploading.value = false;
    uploadProgressController.isDoneUploading.value = true;
    uploadProgressController.imagesUploaded.value=0;
    uploadProgressController.totalImagesToUpload.value=0;
  } else {
    debugPrint("No picture Selected");
  }
}
