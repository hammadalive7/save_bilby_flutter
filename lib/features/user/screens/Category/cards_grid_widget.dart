import 'package:flutter/material.dart';
import 'package:save_the_bilby_fund/common_widgets/category_card.dart';
import 'package:save_the_bilby_fund/constants/image_strings.dart';

class CategoryList extends StatelessWidget {
  String image_url_;
  final controller;

   CategoryList({super.key, required this.image_url_,  required this.controller});


  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: MediaQuery.of(context).size.height/2,
      child: GridView.count(
        controller: controller,
        crossAxisCount: 3,
        primary: false,
        children: [
          Container(
            margin: EdgeInsets.all(8),
              child: CategoryCard(category_name: 'No Animal', image_url: other,URL_Image: image_url_)),
          Container(
              margin:EdgeInsets.all(8),child: CategoryCard(category_name: 'Bilby', image_url: bilby,URL_Image: image_url_,)),
          Container(
              margin: EdgeInsets.all(8),
              child: CategoryCard(category_name: 'Cat', image_url: cat,URL_Image: image_url_,)),
          Container(
              margin: EdgeInsets.all(8),
              child: CategoryCard(category_name: 'Dog', image_url: dog,URL_Image: image_url_,)),
          Container(
              margin: EdgeInsets.all(8),
              child: CategoryCard(category_name: 'Fox', image_url: fox,URL_Image: image_url_,)),
          Container(
              margin: EdgeInsets.all(8),
              child: CategoryCard(category_name: 'Pig', image_url: pig,URL_Image: image_url_,)),
          Container(              margin: EdgeInsets.all(8),
              child: CategoryCard(category_name: 'Cattle', image_url: cattle,URL_Image: image_url_,)),
          Container(
              margin: EdgeInsets.all(8),
              child: CategoryCard(category_name: 'others', image_url: NoAnimal,URL_Image: image_url_,)),
        ],
      ),
    );
  }
}
