import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:save_the_bilby_fund/features/user/controllers/session_controller.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import 'contact_form_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({Key? key}) : super(key: key);
  final urlprivacy = 'https://www.savethebilbyfund.org.au/privacy-policy/';

  //Ui design
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // App bar of contact form
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
                      SizedBox(
                        width: 15,
                      ),
                      Center(
                        child: SizedBox.fromSize(
                          size: Size(56, 56),
                          child: ClipOval(
                            child: Material(
                              color: tPrimaryColor,
                              child: InkWell(
                                splashColor: Colors.white,
                                onTap: () {
                                  Get.back();
                                },
                                child: Visibility(
                                  visible: usercheck(),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Image(
                          image: AssetImage("assets/images/whitebilby.png"),
                          height: 100),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact Form",
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
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContactFormWidget(), // calling contact form Widget class
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("© Save The Bilby Fund 2023. All rights reserved.",
                        style: TextStyle(color: Colors.black, fontSize: 12)),
                    TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      title:
                                          Center(child: Text("Privacy Policy")),
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
                                            "In addition to the contributions you make towards the photo classifications on the Apps, we collect additional data about you to support and improve the operation of the project. This Privacy Policy describes what data we collect, how we use it and how we protect it.We respect the privacy of every individual who participates in this citizen science project. ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Roboto'),
                                          ),
                                          Text(
                                            "Data we collect",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Identifying information: If you register with the App, we ask you to create an account with your full name and supply your e-mail address. None of this information is visible to other users. Notably, your username is associated with any classifications or other contributions you make, including on comments submitted to us.",
                                            strutStyle: StrutStyle(
                                              fontFamily: 'Roboto',
                                              height: 1.5,
                                            ),
                                            style:
                                                TextStyle(fontFamily: 'Roboto'),
                                          ),
                                          Text(
                                            "What is shared with third parties",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "We will never release e-mail addresses to third parties without your express permission. We will also never share data we collect about your use of the App unless (a) it cannot be associated with you or your username, and (b) it is necessary to accomplish our research goals.",
                                            strutStyle: StrutStyle(
                                              fontFamily: 'Roboto',
                                              height: 1.5,
                                            ),
                                            style:
                                                TextStyle(fontFamily: 'Roboto'),
                                          ),
                                          Text(
                                            "Where we store your data ?",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Our App database, which contains a copy of subscribed email addresses and no other personal data, is hosted on a virtual private network.",
                                            strutStyle: StrutStyle(
                                              fontFamily: 'Roboto',
                                              height: 1.5,
                                            ),
                                            style:
                                                TextStyle(fontFamily: 'Roboto'),
                                          ),
                                          Text(
                                            "Security Measures",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Members of the research teams are made aware of our privacy policy and practices by reviewing this statement upon joining the team. We follow industry best practices to secure user data, and access to the database and logs are limited to members of the research group and system administrative staff.",
                                            strutStyle: StrutStyle(
                                              fontFamily: 'Roboto',
                                              height: 1.5,
                                            ),
                                            style:
                                                TextStyle(fontFamily: 'Roboto'),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        Center(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(backgroundColor: tPrimaryColor),
                                              onPressed: (() {
                                               Navigator.of(context)
                                                  .pop(AlertDialog);
                                              }),
                                              child: Text("Agree",style: TextStyle(color: Colors.white),)),
                                        )
                                      ],
                                    );
                                  },
                                );
                              }));
                        },
                        child: Text(
                          "Privacy Policy",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //user status check

  bool usercheck() {
    if (SessionController().userid.toString() == "") {
      return true;
    } else {
      return false;
    }
  }
}
