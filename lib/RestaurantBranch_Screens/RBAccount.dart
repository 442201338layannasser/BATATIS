import 'dart:async';
import 'package:batatis/RestaurantBranch_Screens/dottedFieldChangeDialog.dart';
import 'package:batatis/RestaurantBranch_Widgets/All_RB_Widgets.dart';
import 'package:batatis/Routes.dart';
import 'package:batatis/moudles/RB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:batatis/RestaurantBranch_Screens/sharedPref.dart';
import 'package:flutter_svg/svg.dart';
import '../Controller.dart';
import 'package:batatis/RegExp.dart';

class RBAccount extends StatefulWidget {
  const RBAccount({super.key});

  @override
  State<RBAccount> createState() => RBAccountState();
}

class RBAccountState extends State<RBAccount> {
  FocusNode _emailFocusNode = FocusNode();
  bool _isEditableEmail = false;

  String newEmail = "";
  static String newPass = "";
  // String? RestaurantId=RSharedPref.RestId;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  void updatePassword(String newPassword) {
    setState(() {
      newPass = newPassword;
    });
  }

  String? resturantid = '';
  Future<void> loadData() async {
    try {
      resturantid = await Controller.getUid();

      // await getemail();

      await islog();
      if (isLoggedIn) {
        resturantid = await Controller.getUid();
        setState(() {});
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> islog() async {
    isLoggedIn = await sharedPref.isUserLoggedIn();
  }

  bool isLoggedIn = false;

  String? email = RSharedPref.RestEmail;
  // String email="3.hind09@gmail.com";
  @override
  void initState() {
    super.initState();
    myRBControllerForEdit[0].text =
        email!; //should be the actual email from the db (RSharedPref.RestEmail)
    //myRBControllerForEdit[1].text ="aaaaaaaaaaaaaa"; //s
  }

  static List<TextEditingController> myRBControllerForEdit =
      List.generate(14, (i) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                CustomTextFiled(
                  value: email,
                  iseditable: _isEditableEmail, // iseditable: true,
                  focusNode: _emailFocusNode,
                  text: "Email",
                  controller: myRBControllerForEdit[0],
                  isvalid: Controller.EmailValidation,
                  allowed: '[a-zA-Z0-9.@]',
                  onLostFocus: (text) {
                    // Add your code here to handle the message when the field loses focus
                    print("Field lost focus: $text");
                  },
                ),
                Positioned(
                  right: 25,
                  top: 22,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isEditableEmail = !_isEditableEmail;

                        if (_isEditableEmail) {
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        } else {
                          // Save the edited value when clicking the image again
                          newEmail = myRBControllerForEdit[0].text;
                          print("editable");
                          print(newEmail);
                        }
                      });
                    },
                    child: Image.asset(
                      'assets/Images/Edit.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ]),
              Stack(
                children: [
                  CustomTextFiled(
                    value: "...........",
                    iseditable: false, //iseditable: _isEditablePass,
                    text: "Password",
                    controller: myRBControllerForEdit[1],
                    isvalid: Controller.passValidation,
                    allowed: regeverything,
                    Ispassword: true,
                    onLostFocus: (text) {
                      // Add your code here to handle the message when the field loses focus
                      print("Field lost focus: $text");
                    },
                  ),
                  Positioned(
                    right: 25,
                    top: 22,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return dottedFieldChangeDialog(
                                updatePassword: updatePassword,
                                filedType: "Pass");
                          },
                        );
                      },
                      child: Image.asset(
                        'assets/Images/Edit.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 34),
            ],
          ),
          CustomButton(
              text: "Save",
              onPressed: () async {
                // RestaurantId = (await Controller.getUid())!;
                // resturantid="sfmQfzVm3DUlrvIwl04HaPCbsW63";
                print(newPass);

               // if (newPass != "") RB.setPassword(resturantid!, newPass);

                print("newwww emaill " + newEmail);
                if (newEmail != "") setEmail(resturantid!, newEmail);

                // RB.setRestaurantName(RestaurantId!, newRestaurantName);
                moveRoute(context, "/RBHomePage");
              })
        ],
      ),
    );
  }

  static Future<void> setEmail(String userId, String newEmail) async {
    try {
      // Ensure that there is a user signed in
      User? user = FirebaseAuth.instance.currentUser;
      print(user == null);

      if (user != null) {
        // Create a temporary user with the new email address
        UserCredential tempUserCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: newEmail,
          password: "123456789", // You may need to set a password
        );

        // Send a verification email to the new email address
        await tempUserCredential.user?.sendEmailVerification();
        print(
            "We sent you a verification email to $newEmail. Please check your email.");
        //   try {
        //   showMySnackBar("We sent you a verification email. Please check your new email.");
        // } catch (e) {
        //   print('Error updating email: $e');
        // }

        // Set a timeout of 1 minute
        const timeoutDuration = Duration(seconds: 20);

        // Use Completer to handle the asynchronous operation with a timeout
        Completer<void> completer = Completer<void>();

        // Wait for the user to verify the email or timeout
        Timer(timeoutDuration, () {
          completer.complete();
        });

        await completer.future;

        // // Check if the email is verified
        // await tempUserCredential.user?.reload();
        tempUserCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: newEmail,
          password:
              "123456789", // Use the same password used during user creation
        );
        print("is new verified?");
        print(tempUserCredential.user?.emailVerified);

        if (tempUserCredential.user!.emailVerified) {
          print("insiide");
          // Email is verified, remove the temporary user
          tempUserCredential.user?.delete();

          // Update the user's email
          user.updateEmail(newEmail);

          // Print a message or perform other actions indicating successful email update
          print('Email updated successfully.');
        } else {
          // Delete the temporary user account if not verified within the timeout
          await tempUserCredential.user?.delete();

          print('Email verification timed out. The email was not updated.');
          // try {
          //   showMySnackBar("Email verification timed out. Try again to update your email.");
          // } catch (e) {
          //   print('Error updating email: $e');
          // }
        }
      } else {
        print('No user currently signed in.');
      }
    } catch (e) {
      print('Error updating email: $e');
      // Handle the error appropriately
    }
  }

// void showMySnackBar(String message) {
//   _scaffoldKey.currentState?.showSnackBar(
//     SnackBar(
//       content: Text(message),
//       backgroundColor: Color.fromARGB(255, 48, 190, 43),
//     ),
//   );
// }
}
