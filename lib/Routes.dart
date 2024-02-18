
import 'package:batatis/RestaurantBranch_Screens/RestaurantBranch_SignIn.dart';
import 'package:flutter/material.dart';
import 'Costomer_Screens/All_Costomer_Screens.dart';

import 'RestaurantBranch_Screens/All_RestaurantBranch_Screens.dart';
import 'Views/RestaurantBranch_view.dart';
import 'Views/Customer_View.dart';


var customRoutes = <String, WidgetBuilder>{
  //'/CSignUp': (context) => CSignUp(),
  '/CSignIn': (context) => CSignIn(),
  '/CHomePage': (context) => CHomePage(),
  '/RBWelcomePage': (context) => RBWelcomePage(),
  '/RBRegisterFirst': (context) => RBRegisterFirst(),
  '/RBRegisterSecond': (context) => RBRegisterSecond(),
  '/RBRegisterThird': (context) => RBRegisterThird(),
  '/RBRegisterForth': (context) => RBRegisterForth(),
  '/SignInPage': (context) => SignInPage(),

  '/RBHomePage': (context) => RBHomePage(body : RBmainpage() ),
  '/RBHomePageM': (context) => RBHomePage(body : viewMenu()),
  '/RBHomePageAdd': (context) => RBHomePage(body : addItem()),
      '/viewMenu': (context) => viewMenu(),
 // '/ResturantBranch_view' : (context) => RBHomePage(body : Text("this feature will be in the next version")),//
//'/WelcomePage': (context) => WelcomePage(),
        '/addItem': (context) => addItem(),
        '/ViewMenuToCustomer': (context) => ViewMenuToCustomer(),
//'/RecievePage': (context) =>RecievePage() ,

      
};


void moveRoute(context, Route) {
    Navigator.pushNamed(context, Route);
}


void deleteRoute(context) {
  Navigator.pop(context);
}
