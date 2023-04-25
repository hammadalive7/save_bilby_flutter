import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:save_the_bilby_fund/features/user/controllers/signup_controller.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({super.key});

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

bool isChecked = false;
bool newsletterSubscription = false;
bool letterChecked = false;

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formkey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.fullName,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                if (value.trim().length < 2) {
                  return 'Name must be valid';
                }
                // Return null if the entered username is valid
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_rounded),
                labelText: tFullName,
                hintText: tFullName,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.email,
              validator: (value) {
                bool _isEmailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value!);
                if (!_isEmailValid) {
                  return 'Invalid email.';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: tEmail,
                hintText: tEmail,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.phoneNo,
              validator: (value) {
                bool _isEmailValid =
                RegExp(r'^(?:[+0][1-9])?[0-9]{8,15}$').hasMatch(value!);
                if (!_isEmailValid) {
                  return 'Invalid phone number';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: tPhoneNo,
                hintText: tPhoneNo,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: controller.password,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                if (value.trim().length < 6) {
                  return 'Password must be at least 6 characters in length';
                }
                // Return null if the entered password is valid
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: tPassword,
                hintText: tPassword,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            const SizedBox(height: tFormHeight - 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child:

              //SIGN UP BUTTON THAT WILL SHOW A DIALOG BOX FOR USER  FIRST TO AGREE UPON TERMS AND CONDITIONS, THEN WILL REGISTER

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: tPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                                title:
                                Center(child: Text("Terms & Conditions")),
                                insetPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                                titleTextStyle: TextStyle(
                                    color: tPrimaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                scrollable: true,
                                content: Wrap(
                                  runAlignment: WrapAlignment.center,
                                  runSpacing: 10,
                                  children: [
                                    Text(
                                      "User Agreement",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "The Save the Bilby Fund Citizen Science Image identification app is a citizen science project to involve members of the public to categorise field images",
                                      style: TextStyle(
                                          fontSize: 15, fontFamily: 'Roboto'),
                                    ),
                                    Text(
                                      "What you agree if you contribute to the identification",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "We need to run this project to help us cope with a continuous flood of photos from field cameras at Currawinya National Park and on private land in Queensland. At this stage there is no AI that can categorise the photos, so we need human eyes.Not only will this enable us to be alerted to sightings of both bilbies, and feral pests, but it will also add to our knowledge of the species sharing the environment with the bilbies.The major goal for this project is for the analysed data to be available to our researcher for use, modification and redistribution in order to further scientific research. Therefore, if you contribute to the ID App, you grant us and our collaborators permission to use your contributions however we like to further this goal, trusting us to do the right thing with your identification choice.Similarly, by interacting with the app and participating in photo identification, you must promise to do your very best to attribute an identification to a photo. If you are wilfully disruptive and mis-identifying photos on a regular basis you will have your access removed.You must also agree not to copy, use or distribute any of the images that are presented to you outside of the App.",
                                      strutStyle: StrutStyle(
                                        fontFamily: 'Roboto',
                                        height: 1.5,
                                      ),
                                      style: TextStyle(fontFamily: 'Roboto'),
                                    ),
                                  ],
                                ),
                                actions: [
                                  Wrap(
                                    runSpacing: 2,
                                    children: [
                                      Row(
                                        children: [
                                          Checkbox(
                                              activeColor: tPrimaryColor,
                                              checkColor: Colors.white,
                                              value: isChecked,
                                              onChanged: ((bool? value) {
                                                setState(() {
                                                  isChecked = value!;
                                                });
                                              })),
                                          Text(
                                            'I agree with the Terms and Conditions',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                              activeColor: tPrimaryColor,
                                              checkColor: Colors.white,
                                              value: newsletterSubscription,
                                              onChanged: ((bool? value) {
                                                setState(() {
                                                  newsletterSubscription = value!;
                                                });
                                              })),
                                          Text(
                                            'I want to subscribe to newsletters',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: tPrimaryColor),
                                            onPressed: (() {
                                              if (isChecked == true &&newsletterSubscription==true ) {
                                                Navigator.of(context)
                                                    .pop(AlertDialog);
                                                if (_formkey.currentState!.validate()) {
                                                  SignUpController.instance.signUp(
                                                      controller.fullName.text.trim(),
                                                      controller.email.text.trim(),
                                                      controller.password.text.trim(),
                                                      controller.phoneNo.text.trim(),
                                                      "true" //newsLetterSubscription
                                                  );

                                                }

                                              }
                                              else if (isChecked == true &&newsletterSubscription==false ) {
                                                Navigator.of(context)
                                                    .pop(AlertDialog);
                                                if (_formkey.currentState!.validate()) {
                                                  SignUpController.instance.signUp(
                                                      controller.fullName.text.trim(),
                                                      controller.email.text.trim(),
                                                      controller.password.text.trim(),
                                                      controller.phoneNo.text.trim(),
                                                      "false" //newsLetterSubscription
                                                  );

                                                }

                                              }else if(isChecked==false){
                                                //USED PACKAGE TO GENERATE THIS TOAST
                                                Fluttertoast.showToast(
                                                    msg:
                                                    "To Signup, please agree with Terms and Conditions",
                                                    toastLength:
                                                    Toast.LENGTH_SHORT,
                                                    gravity:
                                                    ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                    tPrimaryColor,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              }
                                            }),
                                            child: Text(
                                              "Continue",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                      // CheckboxListTile(
                                      //   title: Text("Do you want to recieve a daily Newsletter ?"),
                                      //     activeColor: tPrimaryColor,
                                      //     checkColor: Colors.white,
                                      //     value: letterChecked,
                                      //     onChanged: ((value) {
                                      //       setState(() {
                                      //         letterChecked = true;
                                      //       });
                                      //     }))
                                    ],
                                  )
                                ]);
                          },
                        );
                      }));

                },
                child: Text(tSignup.toUpperCase()),
              ),
            ),
            // Checkbox(
            //     activeColor: tPrimaryColor,
            //     checkColor: Colors.black,
            //     value: isChecked,
            //     onChanged: ((bool? value) {
            //       setState(() {
            //         isChecked = value!;
            //       });
            //     })),
          ],
        ),
      ),
    );
  }
}