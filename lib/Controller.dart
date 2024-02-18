//import 'dart:html';

import 'package:batatis/RestaurantBranch_Screens/RBAccount.dart';
import 'package:batatis/RestaurantBranch_Widgets/All_RB_Widgets.dart';
import 'package:batatis/Routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'RegExp.dart';
import 'Costomer_Screens/All_Costomer_Screens.dart';
import 'RestaurantBranch_Screens/All_RestaurantBranch_Screens.dart';
import 'package:iban/iban.dart';
import 'RestaurantBranch_Screens/RestaurantBranch_SignIn.dart';
import 'moudles/RB.dart';

class Controller {
  static String? EmailValidationForEdit(String? input, String? filed) {
    RegExp Emailformat = RegExp(regemail);
    if (input == null || input.isEmpty) {
      return ("Email is required");
    } else if (!Emailformat.hasMatch(input)) {
      return "Please write a correct email";
    }

    testEmail(RBAccountState.myRBControllerForEdit[0].text);

    if (isEmailExist) {
      return "Email already exists, please choose another one";
    }
  
    return null;
  }

  static String? ibanValidationForEdit(String? input) {
    if (input == null || input.isEmpty || input.trim().isEmpty) {
      return ("iban is required");
    }
    if (!isValid(input)) return ("invalid iban");
  }

  static String? ibanValidation(String? input, String? filed) {
    if (input == null || input.isEmpty || input.trim().isEmpty) {
      return ("iban is required");
    }
    if (!isValid(input)) return ("invalid iban");
  }

  static void RBEditProfile(_RBEditProfile1,
      List<TextEditingController> myRBControllerForEdit, context, flag) async {
    if (_RBEditProfile1.currentState!.validate() && flag) {
      //set profile info
      //  RestaurantId = (await Controller.getUid())!;
      // RestaurantId="sfmQfzVm3DUlrvIwl04HaPCbsW63";
      print("end time is");
      print(myRBControllerForEdit[8].text);
      if (myRBControllerForEdit[2].text != "")
        RB.setRestaurantName(
            RSharedPref.RestId.toString(), myRBControllerForEdit[2].text);
      if (myRBControllerForEdit[3].text != "")
        RB.setFee(RSharedPref.RestId.toString(),
            myRBControllerForEdit[3].text); //RB.setFee(RestaurantId!, newFee);

      //if (myRBControllerForEdit[4].text != "")
      //   RB.setBankName(
      //       RSharedPref.RestId.toString(), myRBControllerForEdit[4].text);
      // if (myRBControllerForEdit[5].text != "")
      //   RB.setIban(
      //       RSharedPref.RestId.toString(), myRBControllerForEdit[5].text);
      // if (myRBControllerForEdit[6].text != "")
      //   RB.setBeneficiaryName(
      //       RSharedPref.RestId.toString(), myRBControllerForEdit[6].text);
      
      if (myRBControllerForEdit[7].text != "")
        RB.setStartTime(
            RSharedPref.RestId.toString(), myRBControllerForEdit[7].text);
      if (myRBControllerForEdit[8].text != "")
        RB.setEndTime(
            RSharedPref.RestId.toString(), myRBControllerForEdit[8].text);
      if (myRBControllerForEdit[9].text != "")
        RB.setcr(RSharedPref.RestId.toString(), myRBControllerForEdit[9].text);
      if (myRBControllerForEdit[10].text != "")
        RB.settype(
            RSharedPref.RestId.toString(), myRBControllerForEdit[10].text);
      moveRoute(context, "/RBHomePage");
    }
  }

  static String? EmptyValidation(String? input, String? filed) {
    RegExp nameformat = RegExp(regonlynumber);
    //RegExp nameformat_ = RegExp(regSpasenumber);
    RegExp nameformatS = RegExp(regonlychar);

    if (input == null || input.isEmpty || input.trim().isEmpty) {
      return (filed! + " is required");
    }

    if (nameformat.hasMatch(input) &&
        !(nameformatS.hasMatch(input)) /*||nameformat_.hasMatch(input)*/) {
      return "cannot contain only numbers";
    }

    if (input[0] == ' ' || input[input.length - 1] == ' ') {
      return "cannot start or end with spaces";
    }
    // Check if the input starts with a space
    // List<String> words = input.split(' ').where((word) => word.isNotEmpty).toList();
    // // Check if there is more than one space between words
    // if (words.length > 1) {
    //   return "cannot have more than one space between words."; // There is more than one space between words
    // }

    return null;
  }

  static String? EmptyValidation1(String? input, String? filed) {
    if (input == null || input.isEmpty || input.trim().isEmpty) {
      return (filed! + " is required");
    }
  }

  static String? EmailValidation(String? input, String? filed) {
    RegExp Emailformat = RegExp(regemail);
    if (input == null || input.isEmpty) {
      return ("Email is required");
    } else if (!Emailformat.hasMatch(input)) {
      return "Please write a correct email";
    }

    testEmail(RBFirstSignUpState.myRBController[0].text);

    if (isEmailExist) {
      return "Email already exists, please choose another one";
    }

    return null;
  }

  static bool isEmailExist = false;

  static void testEmail(String em) async {
    isEmailExist = await RB.doesEmailExist(em);
  }

  static String? passValidation(String? input, String? filed) {
    if (input == null || input.isEmpty) {
      return (filed! + " is required");
    }

    if (input.length < 8) {
      // Input length is valid.
      return "Password must be at least 8 characters"; // Return a descriptive error message.
    }
    return null;
  }

  static String? repassValidation(String? input, String? filed) {
    if (input == null || input.isEmpty) {
      return (filed! + " is required");
    }

    if (input.length < 8) {
      // Input length is valid.
      return "Password must be at least 8 characters"; // Return a descriptive error message.
    }

    if (RBFirstSignUpState.myRBController[1].text !=
        RBFirstSignUpState.myRBController[2].text) {
      return "The re-entered password is not matching";
    }
    return null;
  }

  static String? StringValidation(String? input, String? filed) {
    if (input == null || input.isEmpty || input.trim().isEmpty) {
      return (filed! + " is required");
    }
    if (input.startsWith(' ')) {
      return "Can not start with space"; // Input starts with a space
    }
    // Check if the input starts with a space
    List<String> words =
        input.split(' ').where((word) => word.isNotEmpty).toList();
    // Check if there is more than one space between words
    if (words.length > 1) {
      return "Can not have more than one space between words"; // There is more than one space between words
    }
    return null;
  }

  static String? CRnumberlength(String? input, String? filed) {
    if (input == null || input.isEmpty) {
      return (filed! + " is required");
    }
    if (input?.length == 10) {
      return null; // Input length is valid.
    } else {
      return "CR number must be 10 digit"; // Return a descriptive error message.
    }
  }

  static void Csignup(_CsignupKey, values, setState, myController, context) {
    if (_CsignupKey.currentState!.validate()) {
      setState(() {
        CSignUpState.errorMsg = "";
        if (myController[4].text != myController[5].text) {
          print("not matching");
          CSignUpState.errorMsg = "The re-password is not matching";
          return;
        } else {
          CSignUpState.errorMsg = "";
          print("matched");
          values["FirstName"] = myController[0].text;
          values["LastName"] = myController[1].text;
          values["Email"] = myController[2].text;
          values["Phonenumber"] = myController[3].text;
          values["Password"] = myController[4].text;
          //Customer c = Customer(Firstname:  values["FirstName"] , Lastname:values["LastName"] , phonenumber: values["Phonenumber"] );
          //c.addcustomer(setState, context);
        }
      });
    }
  }

  static void RBsignup1(
      _RBsignupKey1, values, setState, myRBController, context) {
    if (_RBsignupKey1.currentState!.validate()) {
      // Clear any previous error messages.
      RBFirstSignUpState.errorMsg = "";
      values["email"] = myRBController[0].text;
      values["password"] = myRBController[1].text;

      moveRoute(context, "/RBRegisterSecond");
    }
  }

  static void RBsignup2(
      _RBsignupKey2, values, setState, myRBController, context) {
    if (_RBsignupKey2.currentState!.validate()) {
      print(values['type']);

      /*  if (values['type'] == " Resturant Category"){
                     ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("please choose a resturant category from the list."),
                     backgroundColor: Colors.red, // Customize the Snackbar's appearance.
                    ),
                  );

                    return;
                   }*/

/*
                  if(!PhotoPicker.Ispicked()){
                   print("no pic"); 
                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                       content: Text("Please pick a pictuer."),
                       backgroundColor: Colors.red, // Customize the Snackbar's appearance.
                       )); return;
                }
                }*/

      RBFirstSignUpState.values["name"] = myRBController[3].text;
      String cr = myRBController[4].text;
      RBFirstSignUpState.values["crnumber"] = myRBController[4].text;
      moveRoute(context, "/RBRegisterThird");
    }
  }

  static void  RBsignup3(
      _RBsignupKey3, values, setState, myRBController, context, flag) {
    if (_RBsignupKey3.currentState!.validate()) {
      print("flag of time in sign3 is $flag");
      if (flag) moveRoute(context, "/RBRegisterForth");
    }
  }

  static void RBsignup4(_RBsignupKey4, values, setState,
      List<TextEditingController> myRBController, context) async {
    print("emaillll");
    print(values["email"]);
    if (_RBsignupKey4.currentState!.validate()) {
      RBFirstSignUpState.values["bankName"] = myRBController[7].text;
      RBFirstSignUpState.values["fee"] = myRBController[13].text;
      String iban = myRBController[8].text;

      
          RBFirstSignUpState.values["iban"] = myRBController[8].text;
          RBFirstSignUpState.values["benefName"] = myRBController[9].text;

//  try {FirebaseAuth.instance.signInWithEmailAndPassword(
//               email:myRBController[0].text,
//               password: myRBController[1].text)
//           .then((response) {
//         if (response.user != null) {
//           if (response.user!.emailVerified) {
//             print("wertyui");
//             // Navigator.of(context).pushReplacement(MaterialPageRoute(
//             //   builder: (context) => RBHomePage(body: viewMenu()),
//  } }
//            else {
//             response.user!.sendEmailVerification();
//             Global.snackBar(
//                 'Verfication email sent, please verify to login', context,
//                 color: Colors.green);
//           }
//         });
//       }
//      catch (error) {
//       setState(() {
//        print('Error signing in: ${error.toString()}');
//       });
//     }
//   }
          void addRB() {
            RB myBranch = RB.basic();

            myBranch.addRestaurantBranch(
              email: values['email'],
              password: values['password'],
              resturantName: values['name'],
              crNumber: values['crnumber'],
              resturantType: values['type'],
              startTime: values['startTime'],
              endTime: values['endTime'],
              fee: values['fee'],
              address: values['address'],
              lat: values['lat'],
              long: values['long'],
              bankName: values['bankName'],
              iban: values['iban'],
              beneficiaryName: values['benefName'],
            );

            for (int i = 0; i < myRBController.length; i++)
              myRBController[i].clear();
            print("cleaned");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignInPage()));
          }

          bool isEmailExist = await RB.doesEmailExist(myRBController[0].text);
          UserCredential userCredential;
          try {
            if (isEmailExist) {
              // Sign in if the email already exists.
              userCredential =
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: myRBController[0].text,
                password: myRBController[1].text,
              );
              print("iffff" + userCredential.toString());
            } else {
              // Create a new user if the email does not exist.
              userCredential =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: myRBController[0].text,
                password: myRBController[1].text,
              );
              print("elseee" + userCredential.toString());
            }
            if (!userCredential.user!.emailVerified) {
              print(userCredential.toString());
              await userCredential.user!.sendEmailVerification();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "We sent you a verfication email please check your email."),
                  backgroundColor: Color.fromARGB(255, 48, 190, 43),
                ),
              );
            } //else{

            userCredential.user!.delete();
            await userCredential.user!.reload();
            addRB();
          } catch (e) {
            print("Error: $e");
          }

          // Check if the restaurant with the given CRN exists
       
    }
  }

  static void itemAdd(RestaurantId, Cval, _addItemKey, values, setState,
      myController, context) {
    if (_addItemKey.currentState!.validate()) {
      setState(() {
        values["Name"] = myController[0].text;
        values["description"] = myController[1].text;
        // values["category"] = myController[2].text ;
        values["price"] = myController[2].text;

        if (!PhotoPicker.Ispicked()) {
          print("in iffffffff");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Please pick a pictuer"),

              backgroundColor:
                  Colors.red, // Customize the Snackbar's appearance.
            ),
          );
          return;
        }

        menu M = menu(
          RestaurantId: RestaurantId,
          Cval: Cval,
          Name: values["Name"],
          description: values["description"],
          /*category: values["category"] ,*/ price: values["price"],
        );
        M.addItem(setState, context);
      });
    }
  }

  static String? deliveryfeeValidation(String? input, String? filed) {
    RegExp priceformat = RegExp(regfee);
    if (input == null || input.isEmpty) {
      return (filed! + " is required");
    } else if (priceformat.hasMatch(input)) {
      print("fee is matched format");
      if (((input[0] == '0' && input[1] == '.') || (input[0] != '0')) &&
          input[input.length - 3] == '.') {
        if (double.parse(input) >= 0.50 && double.parse(input) <= 50) {
          return null;
        } else
          return "Please write a correct fee between 0.50 - 50.00 SR";
      } else
        return "please write a correct fee between 0.50 - 50.00 SR in the format 00.00";
    }
    return "please write a correct fee between 0.50 - 50.00 SR in the format 00.00";
  }

  static String? priceValidation(String? input, String? filed) {
    RegExp priceformat = RegExp(regprice);
    if (input == null || input.isEmpty) {
      return ("Price can not be empty");
    } else if (priceformat.hasMatch(input)) {
      if (((input[0] == '0' && input[1] == '.') || (input[0] != '0')) &&
          input[input.length - 3] == '.') {
        if (double.parse(input) >= 0.50 && double.parse(input) <= 5000)
          return null;
        else
          return "Please write a correct price between 0.50 - 5000.00";
      } else
        return "please write a correct price between 0.50 - 5000.00 in the format 000.00";
    }
    return "please write a correct price between 0.50 - 5000.00 in the format 000.00";
  }

  static Future<bool> setUid(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
//viewMenu.BID = value ;
    return prefs.setString("Uid", value);
  }

  static Future<String?> getUid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("Uid");
  }

  static Future<bool> setRBUid(String uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String parent = await RB.getparent(uid);
    print("parent" + parent);
    return prefs.setString("RBUid", parent);
  }

  static Future<String?> getRBUid(uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("RBUid");
  }
}
