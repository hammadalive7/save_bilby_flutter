
import 'package:flutter/material.dart';

import '../../../../common_widgets/form/form_footer.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../custom_appbar.dart';
import 'forgrt_pass_form.dart';


class ForgetPassword extends StatelessWidget  {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Get the size in LoginHeaderWidget()
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: customAppBar(tForgetPassword, Icons.arrow_back),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [

              ForgetFormWidget(),
              FooterWidget(Texts: tDontHaveAnAccount,Title: tSignup),
            ],
          ),
        ),
      ),
    );
  }
}