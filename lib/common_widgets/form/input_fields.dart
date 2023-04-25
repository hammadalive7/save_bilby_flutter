

import 'package:flutter/material.dart';
import 'package:save_the_bilby_fund/constants/sizes.dart';

import '../../constants/text_strings.dart';


// These are the input field we used in our login , signup , contact form, and profile screen

class Input_Field extends StatelessWidget {
  final String LabelText;
  final String HintText;
  final IconData PrefixIcon;
  final IconData? SuffixIcon;
  bool? isIcon;

  Input_Field({Key? key, required this.LabelText, required this.HintText, required this.PrefixIcon,  this.isIcon=false, this.SuffixIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Here we have 2 types of text fields one has suffixione and othere has not

    return Container(
        // padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
        child: isIcon==false? TextFormField(decoration: InputDecoration(
        prefixIcon: Icon(PrefixIcon),
          labelText: LabelText,    // there we use Lebal test that we pass from where we are using the text field
          hintText: HintText,    // there we use hint test that we pass from where we are using the text field
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),): TextFormField(decoration: InputDecoration(
          prefixIcon: Icon(PrefixIcon),
          labelText: LabelText,
          hintText: HintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          suffixIcon: IconButton(
            onPressed: null,
            icon: Icon(SuffixIcon), // here we use SuffixIcon for showing and hiding password
          ),
        ),)
    );
  }
}
