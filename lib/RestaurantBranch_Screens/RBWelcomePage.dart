import 'package:batatis/Routes.dart';
import 'package:batatis/main.dart';
import 'package:flutter/material.dart';
import '/RestaurantBranch_Widgets/All_RB_Widgets.dart';
import 'package:flutter/foundation.dart'  show  kIsWeb;

import 'All_RestaurantBranch_Screens.dart'; 

class RBWelcomePage extends StatelessWidget {
  
  Widget build(BuildContext context) {
    double Swidth = MediaQuery.of(context).size.width;
    double Sheight = MediaQuery.of(context).size.height;

return Scaffold(
  body: SingleChildScrollView(child: Center(
    child: Container(
      width: 1 * Swidth,
      height:1 * Sheight,
      decoration: BoxDecoration(
        color: Colors.white, // Assuming you want to specify the color as white
        borderRadius: BorderRadius.circular(15),
        boxShadow:[
          BoxShadow(
            blurRadius: 15.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        //  LocationPicker(),
          Image.asset('assets/Images/Batatis_logo.jpeg', width: Swidth * 0.7, height: Sheight * 0.5,),
          CustomButton(text: "Sign in", onPressed: () { moveRoute(context, "/SignInPage"); }, type: "add"),
          CustomButton(text: "Sign up", onPressed: () { moveRoute(context, "/RBRegisterFirst"); }, type: "reject"), // changed it to test viewMenu
         // CustomButton(text: "homepage", onPressed: () { moveRoute(context, "/RBHomePageM"); }, type: "reject"), // changed it to test viewMenu
        
        ],
      ),
    ),
  ),
),
);


  }
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('BATATIS'), 
  //     ),
     

  //   body: Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Container(
  //           width: 398,
  //           height: 188,
  //           decoration: BoxDecoration(
  //             image: DecorationImage(
  //               image: AssetImage('assets/images/Batatis_logo.jpeg'),
  //               fit: BoxFit.fill,
  //             ),
  //           ),
  //         ),
  //         Container(
  //           width: 583,
  //           height: 55,
  //           decoration: ShapeDecoration(
  //             color: Color(0xFFC38A01),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(30),
  //             ),
  //           ),
  //            child: Center(
  //               child: Text(
  //                 'Signin',
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   ),
  //               ),
  //             ),
  //         ),
  //          SizedBox(height: 20), // Add some spacing between the image and the first container
  //         Container(
  //           width: 583,
  //           height: 55,
  //           decoration: ShapeDecoration(
  //             color: Color(0xFFECF0F1),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(30),
  //             ),
  //           ),
  //           child: Center(
  //               child: Text(
  //                 'Signup',
  //                 style: TextStyle(
  //                   color: Colors.white, 
  //                   fontWeight: FontWeight.bold,
  //                   ),
  //               ),
  //             ),
  //         ),
  //       ],
  //     ),
  //   ),
  //   );
  // }

}
