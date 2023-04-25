import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_the_bilby_fund/features/admin/screens/uploadScreen/upload_screen.dart';
import 'package:save_the_bilby_fund/features/user/controllers/session_controller.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../../../utils/utils.dart';

class ProfileFormWidget extends StatefulWidget {
  ProfileFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileFormWidget> createState() => _ProfileFormWidgetState();
}

class _ProfileFormWidgetState extends State<ProfileFormWidget> {
  DatabaseReference ref = FirebaseDatabase.instance.ref('Users');

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    String userEmail;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      // this function will get current user data form firebase
      child: StreamBuilder(
          stream: ref.child(SessionController().userid.toString()).onValue,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

              final nameController =
                  TextEditingController(text: map['UserName']);
              final phoneController =
                  TextEditingController(text: map['Phone']);
               userEmail=map["email"].toString();
               debugPrint("USER EMAILLL: ${userEmail}");

              return Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User Info",
                      style: TextStyle(
                        color: tPrimaryColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 10),
                    TextFormField(
                      controller: nameController,
                      // initialValue: map['UserName'],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 2) {
                          return 'Name must be valid';
                        }
                        // Return null if the entered username is valid
                        // return null;
                      },

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline_rounded),
                        labelText: tFullName,
                        hintText: tFullName,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      // initialValue: map['Phone'],
                      controller: phoneController,

                      validator: (value) {
                        bool _isEmailValid =
                        RegExp(r'^(?:[+0][1-9])?[0-9]{8,15}$')
                            .hasMatch(value!);
                        if (!_isEmailValid) {
                          return 'Invalid phone number';
                        }
                        // return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: tPhoneNo,
                        hintText: tPhoneNo,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      initialValue: map['email'],
                      enableInteractiveSelection: false,
                      focusNode: new AlwaysDisabledFocusNode(),
                      validator: (value) {
                        bool _isEmailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if (!_isEmailValid) {
                          return 'Invalid email.';
                        }
                        // return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: tEmail,
                        hintText: tEmail,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 20),

                    // TextFormField(
                    //   initialValue: map['password'],
                    //   enableInteractiveSelection: false,
                    //   focusNode: new AlwaysDisabledFocusNode(),
                    //   validator: (value) {
                    //     if (value == null || value.trim().isEmpty) {
                    //       return 'This field is required';
                    //     }
                    //     if (value.trim().length < 6) {
                    //       return 'Password must be at least 6 characters in length';
                    //     }
                    //
                    //     // Return null if the entered password is valid
                    //     // return null;
                    //   },
                    //   decoration: InputDecoration(
                    //     prefixIcon: Icon(Icons.fingerprint),
                    //     labelText: tPassword,
                    //     hintText: tPassword,
                    //     border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(20)),
                    //   ),
                    // ),
                    const SizedBox(height: tFormHeight - 10),
                    Text(
                      "Reward Points",
                      style: TextStyle(
                        color: tPrimaryColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 10),
                    TextFormField(
                      initialValue: map['RewardPoints'].toString(),
                      enableInteractiveSelection: false,
                      focusNode: new AlwaysDisabledFocusNode(),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.diamond_outlined),
                        labelText: "Reward Points",
                        hintText: "Reward Points",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 10),
                    TextFormField(
                      initialValue: map['ImageCategorized'].toString(),
                      enableInteractiveSelection: false,
                      focusNode: new AlwaysDisabledFocusNode(),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.image),
                        labelText: "Images Categorized",
                        hintText: "Images Categorized",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 10),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: tPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () {
                          // ProfileController.instance?.updateprofile(
                          //   nameController.text!.trim(),
                          //   phoneController.text!.trim(),
                          // );





                          if ((_formkey.currentState)!.validate()) {
                            updateprofile(nameController.text!.trim(),
                                phoneController.text!.trim());

                            Utils.toastMessageS("Updated");

                          }
                        },
                        child: Text("Update".toUpperCase()),
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 10),
                    // this button is only visible on admin email
                    Visibility(
                      visible: userEmail.toString()=='savebilby@gmail.com'?true:false,
                      // visible: true,
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: tPrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            Get.to(() => const UploadScreen());

                          },
                          child: Text("admin Screen".toUpperCase()),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  // this function to update user profile
  void updateprofile(String name, String phone) {
    ref.child(SessionController().userid.toString()).update({
      'UserName': name,
      'Phone': phone,
    });
  }
}



class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
