import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:save_the_bilby_fund/constants/colors.dart';
import 'package:save_the_bilby_fund/features/user/screens/Category/cards_grid_widget.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../utils/utils.dart';
import '../../controllers/category_cntroller.dart';
import '../../controllers/data_controller.dart';
import '../SettingsSecreen/User_Profile.dart';
import '../contachForm/contact_form.dart';
import 'data.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final controller = ScrollController();
  Future WaitFunctionToLoadImageURLInCards() async {
    // await while(ImageURL!=null);
    await Future.delayed(Duration(milliseconds: 2500));

//return your_main_future_code_here;
  }

  final _pageOptions = [
    CategoriesScreen(),
    ContactForm(),
    ProfileScreen(),
  ];

  final DatabaseReference imageref =
      FirebaseDatabase.instance.ref().child('images');

  void Remove() async {
    List<String> imagekeys = [];
    final Mainimageref = FirebaseDatabase.instance.ref("images");
    DatabaseEvent event = await Mainimageref.once();
    Map<String, dynamic> children =
        Map<String, dynamic>.from(event.snapshot.value as Map);

    children.entries.forEach((e) => imagekeys.add(e.key.toString()));
    for (int i = 0; i < 1; i++) {
      final DatabaseReference ref =
          FirebaseDatabase.instance.ref().child('images/${imagekeys[i]}');
      ref.remove();
    }
  }

  int count = 0;
  int counter = 1;
  int datalength = 0;

  bool visible = true;

  List<Data> datalist = [];
  String ImageURL = "0";
  // Future<String> waitTillgetURL()async{
  //   return Future(() async {
  //      while(ImageURL=="0"){
  //        debugPrint("IN WHILE LOOP");
  //     };
  //      return ImageURL;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: tPrimaryColor,
        foregroundColor: Colors.white,
        onPressed: scrollUp,
        shape: StadiumBorder(side: BorderSide(color: Colors.white24, width: 4)),
        child: Icon(Icons.arrow_upward),
      ),
      appBar: AppBar(
        backgroundColor: tPrimaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Container(
              padding: const EdgeInsets.only(bottom: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          image: AssetImage("assets/images/whitebilby.png"),
                          height: 70),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Home",
                          style: TextStyle(
                              fontSize: 25,
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
        controller: controller,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Wrap(
            runSpacing: 5,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "To categorize next image click on :",
                    style: TextStyle(
                      color: tPrimaryColor,
                      fontSize: 17,
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: ElevatedButton(
                      child: Icon(
                        //<-- SEE HERE
                        Icons.navigate_next_rounded,
                        color: Colors.white,
                        size: 31,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tPrimaryColor,
                        shape: CircleBorder(
                            side: BorderSide(color: Colors.white24, width: 4)),
                        padding: EdgeInsets.all(2),
                      ),
                      onPressed: () async {
                        setState(() {
                          if (datalength <= 20) {
                            Utils.toastMessageF("No more images to show");
                            // Remove();
                            ImageController().imageleft = false;
                          } else if (DataController().clicked == true) {
                            DataController().clicked = false;
                            count++;
                          } else {
                            Utils.toastMessageF(
                                "Please categorize this image first");
                          }
                        });
                        if (count == 20) {
                          count = 0;
                          counter = 1;

                          showDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 300,
                                  child: AlertDialog(
                                    backgroundColor: Color(0xff455A64),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    content: Container(
                                      height: 300,
                                      color: Color(0xff455A64),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Dear user you had reached your maximum limit of categorizing images!",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              "\nDo you want to continue categorize more images or quit!",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            )
                                          ]),
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(AlertDialog);
                                            },
                                            child: Text(
                                              "Continue ",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                SystemNavigator.pop();
                                              },
                                              child: Text(
                                                "Quit",
                                                style: TextStyle(fontSize: 20),
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              });
                        } else if (counter == count) {
                          Remove();
                          counter++;
                        }
                      },
                    ),
                  )
                ],
              ),
              Container(
                height: 230,
                child: StreamBuilder(
                  stream: imageref.onValue,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Container(
                          height: MediaQuery.of(context).size.height / 1.25,
                          width: MediaQuery.of(context).size.width / 1.25,
                          child: Center(child: CircularProgressIndicator()));
                    } else if (snapshot.hasData) {
                      datalist.clear();
                      if (snapshot.data.snapshot.value == null) {
                        // visible = false;
                        return Center(
                          child: Text("No more images to show :)\nNew images will be available soon.\nSee you later fella!"),
                        );
                      } else {
                        var keys = snapshot.data.snapshot.value.keys;
                        var values = snapshot.data.snapshot.value;
                        for (var key in keys) {
                          Data data = new Data(values[key]["imageURL"]);
                          datalist.add(data);
                          datalength = datalist.length;
                        }
                        if (count == datalist.length) {
                          count == datalist.length - 1;
                        }
                        try {
                          if (datalist.length <= 20) {
                            ImageController().imageleft = false;

                            return Center(
                              child: Text("No more images to show :)\nNew images will be available soon.\nSee you later fella!"),
                            );
                          } else {
                            ImageURL = datalist[count].imgurl;
                            return Center(
                              child: Image.network(
                                datalist[count].imgurl,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        } on Exception catch (_) {
                          ImageController().imageleft = false;
                          return Center(
                            child: Text("No image to show"),
                          );
                        }

                        // Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

                      }
                    } else
                      return SizedBox(
                          child: Image.asset(
                        'assets/images/bilby.jpg',
                      ));
                  },
                ),
              ),
              Text(
                "Category : ",
                style: TextStyle(
                    color: tPrimaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Please select a category for the image",
                style: TextStyle(
                  color: tPrimaryColor,
                  fontSize: 17,
                ),
              ),
              FutureBuilder(
                future: WaitFunctionToLoadImageURLInCards(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // return CategoryList(
                    //   image_url_: ImageURL,
                    //);
                    //   while(ImageURL=="0")
                    //     {
                    //       debugPrint("in loop");
                    //     }
                    return CategoryList(
                      image_url_: ImageURL,
                      controller: controller,
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),

              // FutureBuilder(
              //   future:waitTillgetURL(), // _futureData is the future that will return the non-null value
              //   builder: (BuildContext context, AsyncSnapshot snapshot) {
              //     if (snapshot.hasData) {
              //       if (snapshot.data != null) {
              //         return CategoryList(
              //                     image_url_: ImageURL,
              //                   ); // non-null value is available, display it
              //       } else {
              //         return Center(child: CircularProgressIndicator()); // non-null value is not yet available, show a loading indicator
              //       }
              //     } else {
              //       return Center(child: CircularProgressIndicator()); // non-null value is not yet available, show a loading indicator
              //     }
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }

  void scrollUp() {
    final double start = 0;
    controller.jumpTo(start);
  }
}
