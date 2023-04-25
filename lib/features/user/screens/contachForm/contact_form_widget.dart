
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../../../utils/utils.dart';

//inheriting a stateful widget
// (a dynamic widget which can change its appearance in response of some event)

class ContactFormWidget extends StatefulWidget {
  const ContactFormWidget({Key? key}) : super(key: key);

  @override
  State<ContactFormWidget> createState() => _ContactFormWidgetState();
}

//creating controllers for controlling desired fields

final nameController=TextEditingController();
final subjectController=TextEditingController();
final emailController=TextEditingController();
final messageController=TextEditingController();


//function for sending mail to adime email address

Future sendEmail() async{

  //credentials for desired email address

  final url=Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  const serviceId = "service_zlcbq3h";
  const templateId = "template_ars5g2u";
  const userId = "3OstZ3o-MZkiyPCwd";
  // const privatekey= "ER6z2jXuigWEFkSaevqUi";

  final response=await http.post(url,
      headers: {'Content-Type':'application/json'},
      body: json.encode({"service_id":serviceId,
        "template_id":templateId,
        "user_id":userId,
        "template_params":{
          "name":nameController.text,
          "subject":subjectController.text,
          "message":messageController.text,
          "user_email":emailController.text,}
      }));


  //showing toast messages in case of email success/failure


  if (response.statusCode == 200) {
    Utils.toastMessageS("Email Sent Successfully");

  }else{
    Utils.toastMessageF("Error! Something wrong try again");
  }

  return response.statusCode;

}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();

    // In this Container we have different TextFormField with validations

    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
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
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: subjectController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required';
                }
                if (value.trim().length < 2) {
                  return 'Subject must be valid';
                }
                // Return null if the entered username is valid
                return null;
              },


              decoration: InputDecoration(
                prefixIcon: Icon(Icons.drive_file_rename_outline),
                labelText: "Subject",
                hintText: "Subject",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),),



            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: emailController,
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
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),),

            const SizedBox(height: tFormHeight - 20),
            Container(

              // padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
                child: TextFormField(
                  controller: messageController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    if (value.trim().length < 5) {
                      return 'message must be valid';
                    }
                    // Return null if the entered username is valid
                    return null;
                  },



                  minLines: 1,
                  maxLines: 100,
                  keyboardType: TextInputType.multiline,

                  decoration: InputDecoration(
                    labelText: "Message",
                    hintText: "Kindly enter your message",
                    contentPadding: EdgeInsets.fromLTRB(15, 90, 10, 0),


                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),

                    ),
                  ),)
            ),

            // Here we have Button with text Send to send filled details to admin Email

            const SizedBox(height: tFormHeight - 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: tPrimaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                onPressed: ()  async {

    if(_formkey.currentState!.validate()){
      int code = await sendEmail();


    }


                },
                child: Text("Send".toUpperCase()),

              ),
            )
          ],
        ),
      ),
    );

  }
}



