import 'dart:async';

//import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
import 'package:batatis/Customer_Widgets/Link.dart';
import 'package:batatis/RestaurantBranch_Screens/forgot_password.dart';
import 'package:batatis/RestaurantBranch_Widgets/PasswordTextFileds.dart';
import 'package:batatis/main.dart';
import 'package:batatis/utils/utils.dart';
import 'package:batatis/moudles/RB.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../moudles/Orders.dart';
import '../moudles/memberItems.dart';
import '/RestaurantBranch_Widgets/All_RB_Widgets.dart';
import '/RegExp.dart';
import '/Controller.dart';
import 'package:batatis/Views/RestaurantBranch_view.dart';
import 'All_RestaurantBranch_Screens.dart';
import 'sharedPref.dart';
//////////////////sadeem//////////////
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String errorMsg = '';

//////////////////sadeem//////////////
  final FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;


 void checkLoggedin() async {
    RSharedPref.printPrefrenses();
    await RSharedPref.SetSharedPrefer();
    print("hohohohho ");
    RSharedPref.printPrefrenses();
    if ((RSharedPref.Islogin!)) {
      print("checking if the user is loged in he is loged in ");
        Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => RBHomePage(body: const RBmainpage())),
            );
    } else {
      print("checking if the user is loged in he is not  loged in ");
    }
  }
  // void signInWithEmailAndPassword() async {
  //   try {
  //     final UserCredential userCredential =
  //         await _auth.signInWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );
  //     final User? user = userCredential.user;
  //
  //     if (user != null) {
  //
  //       // ignore: use_build_context_synchronously
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(
  //         builder: (context) => WelcomePage(),
  //       ));
  //     }
  //   } catch (error) {
  //     setState(() {
  //       errorMsg = 'Error signing in: ${error.toString()}';
  //     });
  //   }
  // }

  //SIGNIN with verification code

  void signInWithEmailAndPassword() async {
    //SharedPreferences sh = SharedPreferences() ;
    // Check if the email address exists in the database.
    Future<bool> isEmailExist = RB.doesEmailExist(emailController.text);

    if (await isEmailExist) {
      // Check if the password is correct.
      Future<bool> isPasswordCorrect =
          RB.isPasswordCorrect(emailController.text, passwordController.text);

      if (await isPasswordCorrect) {
        // The user has successfully logged in.
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => RBHomePage(body: viewMenu()),
        // ));
      } else {
        // The password wrong.
        //setState(() {
        //  errorMsg = 'The password is incorrect.';
        //  });
        //  Global.snackBar( msg : "The password is incorrect." ,
        //                context : context ,
        //                color: Colors.red, // Customize the Snackbar's appearance.
        //               ),
       // showSnackBar(context, "The password is incorrect.");
          ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                    content: Text(
                        "The password is incorrect."),
                    backgroundColor:red,
                  ),
                );
      }
    } else {
      // The email address does not exist.
      // setState(() {
      // errorMsg = 'The email address does not exist.';
      //});
        ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                    content: Text(
                       "The email address does not exist."),
                    backgroundColor:red,
                  ),
                );
      //showSnackBar(context, "The email address does not exist.",);
      // Global.snackBar(
      //                 content: Text("The email address does not exist."),
      //                backgroundColor: Colors.red, // Customize the Snackbar's appearance.
      //               ),
    }
    bool canSendVerificationEmail = true;
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((response) async {
        //print(      response.additionalUserInfo) ;
        if (response.user != null) {
          //print(response);
          if (response.user!.emailVerified) {
            print("108 okay") ; 
            Controller.setUid(response.user!.uid);
            Controller.setRBUid(response.user!.uid);
           print("111 okay") ; 
           
            print("116 okay${response.user!.uid}") ; 
            await RSharedPref.SetLogin(response.user!.uid, emailController.text.trim()).then((value) => print("logged oin for real ${response.user!.uid}"));
            ////////////////////////////////sadeem///////////////////////////////////////////
           Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => RBHomePage(body: const RBmainpage())),
            );
            var fcmToken = await FirebaseMessaging.instance.getToken(
              vapidKey:
                  "BH_CeruiJmsen8Z_WdLXSLisE_xq7jKj8W7HJ1jCcNbzy9IEWczzPYtkqDjSupOiAUjDvxCZ5Z9DYKpfrBLnYRo",
            ).then((value) => {print("saveed token")});
            print("122 okay") ; 
            await _firebasefirestore
                .collection("Restaurants")
                .doc(response.user!.uid)
                .update({'Token': fcmToken});
             print("127 okay") ;    
            await RSharedPref.SetToken(fcmToken);
            print("token weeeeebbbbb:");
            print(fcmToken);

///////////////////////////////////////////////////////////////////////////////////////////

            sharedPref.setUserLoggedIn(true);
          } else {
            try {
              if (canSendVerificationEmail) {
                await response.user!.sendEmailVerification();
                canSendVerificationEmail = false;
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                    content: Text(
                        "Verification email sent. Please check your email."),
                    backgroundColor:green,
                  ),
                );
                Timer(const Duration(minutes: 2), () async {
                  try {
                    canSendVerificationEmail = true;
                  } catch (error) {
                    print("Error sending email verification: $error");
                  }
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                    content:
                        Text("Please wait for 2 min to recive the next email"),
                    backgroundColor:red,
                  ),
                );
              }
            } catch (error) {
              print("Error sending email verification: $error");
            }
          }
        }
      });
    } catch (error) {
      setState(() {
        errorMsg = 'Error signing in: ${error.toString()}';
      });
    }
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("we in weeb");
    double Swidth = MediaQuery.of(context).size.width;
    double Sheight = MediaQuery.of(context).size.height;
      
    if (Batatis.istesting) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: "mmmm4aa@gmail.com", password: "12345678")
          .then((response) async {
        //print(      response.additionalUserInfo) ;
        if (response.user != null) {
          //print(response);
          if (response.user!.emailVerified) {
            Controller.setUid(response.user!.uid);
            Controller.setRBUid(response.user!.uid);
            
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => RBHomePage(body: const RBmainpage())),
            );
            sharedPref.setUserLoggedIn(true);
          }
        }
      });
    }      
    // emailController.text = "d" ; 
    return Scaffold(
      // appBar: AppBar(actions: [
      //   IconButton(onPressed: () async {  
      //     MemberItems tottalitems = await  Orders.getAllItems("Poargfd6GkxlCAT10mty");
      //     print(tottalitems.prices ); print("\n ${tottalitems.items} \n${tottalitems.quantitys} ");}, icon: Icon(Icons.abc))
      // ],),

        body: Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            mainAxisAlignment:
                MainAxisAlignment.start, // You can adjust this as needed
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Expanded(
            child: Image.asset(
              'assets/Images/Batatis_logo.jpeg',
              width: Swidth * 0.9,
              height: Sheight * 0.6,
              alignment: Alignment.centerLeft,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(0.0),
              child: Form(
                key: _key,
                // child: Center(
                child:
                    //Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //  child:
                    SingleChildScrollView(
                        child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Image.asset('assets/Images/Batatis_logo.jpeg', width: Swidth * 0.7, height: Sheight * 0.4,),
                    CustomText(text: "Sign In ", type: "heading"),
                    
                    CustomTextFiled(
                     value: null,
                      text: "  E-mail",
                      maxLen: 50,
                      controller: emailController,
                      isvalid: Controller.EmailValidation,
                      allowed: r'[a-zA-Z0-9@._-]',
                      onLostFocus: (text) {
                        // Add your code here to handle the message when the field loses focus
                        print("Field lost focus: $text");
                      },
                    ),
                    PasswordTextFiled(
                      text: "  Password",
                      controller: passwordController,
                      isvaild: Controller.EmptyValidation1,
                      allowed: regeverything,
                      isPassword: true,
                      onLostFocus: (text) {
                        // Add your code here to handle the message when the field loses focus
                        print("Field lost focus: $text");
                      },
                    ),
                    //  const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .28,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ForgotPassword()),
                              );
                            },
                            child: Text("Forgot Password?",
                                style: TextStyle(color: Batatis_Dark,decoration: TextDecoration.underline , decorationColor:  Batatis_Dark,)),
                          ),
                        ),
                      ],
                    ),
                    //  const SizedBox(height: 10.0),
                    Text(
                      errorMsg,
                      style: const TextStyle(color: Colors.red),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // CustomButton(
                        //   text: "Back",
                        //   onPressed: () {
                        //     moveRoute(context, "/RBWelcomePage");
                        //   },
                        //   type: "confirm",
                        //   width: 0.1,
                        // ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * .25,
                        // ),
                        CustomButton(
                          text: "Sign In",
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              signInWithEmailAndPassword();
                            }
                          },
                          type: "add",
                          width: 0.3,
                        ),
                         ],
                    ),

//  Center(
//  child :  Row(
//   crossAxisAlignment : CrossAxisAlignment.center,
//   mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Text( 'New to BATATIS?   ' , style: TextStyle(color: Batatis_Dark)),
                    TextButton(
                      child: Text(
                        'New to BATATIS? Sign up now',
                        style: TextStyle(
                            color: Batatis_Dark,
                            decoration: TextDecoration.underline,
                            decorationColor: Batatis_Dark),
                        textAlign: TextAlign.left,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const RBRegisterFirst()));
                      },
                    ),
                    //   ],
                    // ),)
                  ],
                )),
              ),
            ),
            //   )),
          )
        ]));
  }
}

class Global {
  static snackBar(String msg, color, context) {
    final SnackBar snackBar = SnackBar(
      backgroundColor: color,
      content: Text(msg),
      elevation: 1000,
      behavior: SnackBarBehavior.fixed,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static User? user;
}
