import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../../constants/colors.dart';
import '../SettingsSecreen/User_Profile.dart';
import '../contachForm/contact_form.dart';
import 'category_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentindex = 1;
  final screens = [
    ProfileScreen(),
    CategoriesScreen(),
    ContactForm(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          index: 1,
          backgroundColor: Colors.blueGrey,
          color: tPrimaryColor,
          animationDuration: Duration(milliseconds: 300),
          height: 55,
           onTap: (index) => setState(() => currentindex = index),
           
          items: [
            Icon(
              Icons.person,
              size: 24,
              color: Colors.white,
            ),
            Icon(
              Icons.app_registration_rounded,
              size: 24,
              color: Colors.white,
            ),

            Icon(
              Icons.message,
              size: 24,
              color: Colors.white,
            )
          ]),
      body: screens[currentindex],
    );
  }
}
// return Scaffold(
//       bottomNavigationBar: GNav(
//         backgroundColor: tPrimaryColor,
//         rippleColor: Color(0xD6EFE8FF),
//         hoverColor: Color(0x046054FF),
//         gap: 10,
//         activeColor: tPrimaryColor,
//         iconSize: 24,
//         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 17),
//         duration: Duration(milliseconds: 400),
//         tabBackgroundColor: Colors.white,
//         color: Colors.white,
//         // animationDuration: Duration(milliseconds: 1000),
//         // labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
//         // // surfaceTintColor: Colors.white,
//         // elevation: 30,
//         // backgroundColor: tPrimaryColor,
//         // selectedIndex: currentindex,
//         selectedIndex: currentindex,
//         onTabChange: (index) => setState(() => currentindex = index),
//         tabs: [
//           GButton(
//             icon: Icons.app_registration_rounded,
//             text: "Survey",
//           ),
//           GButton(
//             icon: Icons.person,
//             text: "Profile",
//           ),
//           GButton(
//             icon: Icons.message,
//             text: "Contact Us",
//           ),
//         ],
//       ),
//       body: screens[currentindex],
//     );