import 'package:flutter/material.dart';
import '/Routes.dart';
import '/Customer_Widgets/All_customer_Widgets.dart';
import '../Costomer_Screens/All_Costomer_Screens.dart';

class CWelcomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    CSignUpState.errorMsg  = "";
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/Images/Batatis_logo.jpeg'),
              CustomButton(
                  text: "Sign in",
                  onPressed: () { moveRoute(context, "/CSignIn");
                  },
                  type: "confirm"),
                  ]),
      ),
    );
  }
}
