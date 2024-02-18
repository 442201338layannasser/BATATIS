import 'package:batatis/Controller.dart';
import 'package:batatis/RestaurantBranch_Screens/RBRegisterFirst.dart';
import 'package:batatis/RestaurantBranch_Screens/RestaurantBranch_SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/RestaurantBranch_Widgets/All_RB_Widgets.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final TextEditingController emailController = TextEditingController();
  final _key = GlobalKey<FormState>();

  void resetPassword() async {
    String email = emailController.text.trim();

    if (email != '') {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {

            //    showDialog<String>(
            //                             context: context1,
            //                             builder: (BuildContext context) =>
            // showdialog(context,"link has been sent to your email for password reset","OK"));
        Global.snackBar(
            'link has been sent to your email for password reset',green, context);
      }).catchError((e) {
        Global.snackBar(e.toString(), red, context );
      });
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      print("Please enter E-mail Id");
      Global.snackBar("Please enter E-mail Id",red , context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Batatis_Dark,
        title: Image.asset(
          'assets/Images/Batatis_logo.jpeg',
          width: 200,
          height: 100,
        ),),
      body: Form(
        key: _key,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 // Add the title
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: black,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Enter your email, we'll send you a link to reset your password.",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.0),
                CustomTextFiled(
                  text: "E-mail",
                  controller:emailController,
                  isvalid: Controller.EmailValidation,
                  allowed: '[a-zA-Z0-9.@]',
                  onLostFocus: (text) {
                    // Add your code here to handle the message when the field loses focus
                    print("Field lost focus: $text");
                  },
                ),

                const SizedBox(height: 10.0),
                CustomButton(
                  text: "Send",
                  onPressed: () {
                    if(_key.currentState!.validate()){
                      resetPassword();
                    }
                  },
                  type: "add",
                  width: 0.1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

Widget showdialog(context , msg,action ){

                                         return   AlertDialog(
                                          title: const Text('Confirmation'),
                                          content:  Text( msg ),
                                          actions: <Widget>[
                                            // TextButton(
                                            //   //cancel
                                            //   onPressed: () => Navigator.pop(
                                            //     context,
                                            //   ),
                                            //   child: const Text('Cancel'),
                                            // ),
                                            TextButton(
                                              onPressed: () {
                                            
                                                Navigator.pop(
                                                  context,
                                                );
                                              },
                                              child:  Text(action),
                                            ),
                                          ],
                                        );
                                      }
}