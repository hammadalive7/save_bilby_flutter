import 'package:flutter/material.dart';
import 'package:save_the_bilby_fund/constants/text_strings.dart';

import '../../../../common_widgets/form/form_footer.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../custom_appbar.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(tForgetPassword, Icons.arrow_back),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, size: 100,),
                  Text("If the details match to our record, you will get an email",textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  Icon(Icons.cached, size: 100,),
                  Text("Make sure to change your password after loging",textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),

                ],
              ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: tPrimaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    onPressed: () {},
                    child: Text("Continue".toUpperCase()),

                  ),
                ),
                FooterWidget(Texts: tDontHaveAnAccount,Title: tSignup),

              ],

            ),

          ),

        ),
      ),
    );
  }
}