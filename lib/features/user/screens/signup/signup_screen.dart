import 'package:flutter/material.dart';
import 'package:save_the_bilby_fund/constants/sizes.dart';
import 'package:save_the_bilby_fund/constants/text_strings.dart';
import 'package:save_the_bilby_fund/features/user/screens/signup/signup_form_widget.dart';

import '../../../../common_widgets/form/form_footer.dart';
import '../custom_appbar.dart';
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: customAppBar(tSignup, Icons.arrow_back),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: const [
              SignUpFormWidget(),
              FooterWidget(Texts: tAlreadyHaveAnAccount,Title: tLogin),
            ],
          ),
        ),
      ),
    );
  }
}




