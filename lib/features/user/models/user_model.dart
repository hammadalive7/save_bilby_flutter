

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{


  final String? Uid;
  final String fullname;
  final String email;
  final String phoneNo;
  final String password;
  final bool activestatus = false;
  final int imageCategorized = 0;
  final int rewardPoints = 0;



  const UserModel({
     this.Uid,
    required this.email,
    required this.fullname,
    required this.phoneNo,
    required this.password,

});

  toJson(){
    return{
      "UID": Uid,
      "FullName": fullname,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,
      "rewardPoints": rewardPoints,
      "imageCategorized": imageCategorized,
      "activeStatus": activestatus,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return UserModel(
      Uid: document.id,
        email: data["Email"],
        fullname: data["FullName"],
        phoneNo: data["Phone"],
        password: data["Password"]);
  }


}