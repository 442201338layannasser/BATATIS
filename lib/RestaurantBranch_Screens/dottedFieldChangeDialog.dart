import 'package:batatis/Controller.dart';
import 'package:batatis/Customer_Widgets/colors.dart';
import 'package:batatis/RestaurantBranch_Screens/All_RestaurantBranch_Screens.dart';
import 'package:batatis/RestaurantBranch_Screens/EditBankInfoDialog.dart';
import 'package:batatis/RestaurantBranch_Screens/RBAccount.dart';
import 'package:batatis/Routes.dart';
import 'package:batatis/moudles/RB.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class dottedFieldChangeDialog extends StatefulWidget {
  final Function(String)? updatePassword;
  String filedType="";
     dottedFieldChangeDialog({this.updatePassword, required this.filedType});

  @override
  _dottedFieldChangeDialogState createState() => _dottedFieldChangeDialogState();
  
}

class _dottedFieldChangeDialogState extends State<dottedFieldChangeDialog> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  TextEditingController newBankNameController = RBAccountState.myRBControllerForEdit[4];
  TextEditingController newIBANController = RBAccountState.myRBControllerForEdit[5];
  TextEditingController newBeneficiaryNameController = RBAccountState.myRBControllerForEdit[6];

  

  String errorMessage = '';
  String errorMessageTwo='';

  //Future<String?> resturantid =  Controller.getUid();
 
   String resturantid=RSharedPref.RestId.toString();
  
  
  void setErrorMessage(String message) {
    setState(() {
      errorMessage = message;
    });
  }

  
void setErrorMessageTwo(String message) {
    setState(() {
      errorMessageTwo = message;
    });
  }

  @override
  Widget build(BuildContext context) {
if (widget.filedType == "Pass") {
      return changePasswordDialog();
    }

    if (widget.filedType == "bankInfo") {
      return changeBankInfo();
    }

    return AlertDialog();
  }
   

  AlertDialog changePasswordDialog() {
    return AlertDialog(
      title: Text('Change Password'),
      content: Column(
        children: [
          TextField(
            controller: currentPasswordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Current Password'),
          ),
          TextField(
            controller: newPasswordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'New Password'),
          ),
          TextField(
            controller: confirmNewPasswordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Confirm New Password'),
          ),
            if (errorMessage.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
          //  if (errorMessage!='')
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            // Validate passwords and update the Firestore password if needed
            String currentPassword = currentPasswordController.text;
            String newPassword = newPasswordController.text;
            String confirmNewPassword = confirmNewPasswordController.text;
            bool isCurrentPasswordCorrect = await isCurrentPassCorrect(currentPassword);

            if ( isCurrentPasswordCorrect &&
                newPassword == confirmNewPassword) {
                  if (newPassword!= ""){
                    if(newPassword.length>7){

            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Change the Password'),
                content: const Text(
                    'Are you sure you want to save the new password?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                                      
               widget.updatePassword!(newPassword);
               print("ready to update");
               RB.setPassword(resturantid, newPassword, context);
               moveRoute(context, '/RBHomePageM');
              ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password changed successfully'),
              backgroundColor: Colors.green,
            ),
          );
                    },
                    
                    child: const Text('Save'),
                  ),
                  TextButton(
                    onPressed: () {
                      //moveRoute(context, '/RBeditprofile');
                       Navigator.of(context).pop(); // Close the current dialog
                       Navigator.of(context).pop(); // Close the main dialog
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: red),
                    ),
                  ),
                ],
              ),
            );
                    }
                   else
                  setErrorMessage("New password must be at least 8 characters"); 
                  }
                  else
                  setErrorMessage("New password can not be empty"); 
            } else {
            if (!isCurrentPasswordCorrect) {
                // Show an error message for incorrect current password
                setErrorMessage("Incorrect current password");
                print("wrong current pass");
              }

                else
              {
                // Show an error message for mismatched new passwords
                setErrorMessage("New passwords do not match");
                 print("not matdhing ");
              }

             
            }
          },
          child: Text('Change Password'),
        ),
      ],
    );
     }
  AlertDialog changeBankNameDialog() {
      return AlertDialog(
      title: Text('Change Bank Name'),
      content: Column(
        children: [
          TextField(
            controller: currentPasswordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Current Password'),
          ),
          TextField(
            controller: newBankNameController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'New Bank Name'),
          ),
            if (errorMessage.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            //if (errorMessage!='')
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            // Validate passwords and update the Firestore password if needed
            String currentPassword = currentPasswordController.text;
           // String newBankName = newPasswordController.text;
            bool isCurrentPasswordCorrect = await isCurrentPassCorrect(currentPassword);

           if (isCurrentPasswordCorrect) {
  // Check additional conditions before closing the dialog
  if (newBankNameController.text == null ||
      newBankNameController.text.isEmpty ||
      newBankNameController.text.trim().isEmpty) {
    setErrorMessage("IBAN is required");
  } else if (newBankNameController.text.startsWith(' ')) {
    setErrorMessage("Cannot start with space");
  } else {
    // Check if there is more than one space between words
    List<String> words = newBankNameController.text
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList();

    if (words.length > 1) {
      print(words.length);
      setErrorMessage("Cannot have more than one space between words");
    } else {
      // Reset the error message and close the dialog
      setErrorMessage('');
        RBAccountState.myRBControllerForEdit[4].text =
            newBankNameController.text;
      print("fron the account controller the bank name is ");
      print(RBAccountState.myRBControllerForEdit[4].text);
      Navigator.of(context).pop();
    }
  }
} else {
  if (!isCurrentPasswordCorrect) {
    // Show an error message for incorrect current password
    setErrorMessage("Incorrect current password");
    print("wrong current pass");
  }
}

          },
          child: Text('Change Bank Name'),
        ),
      ],
    );
     }
  AlertDialog changeIBANDialog() {
    return AlertDialog(
      title: Text('Change IBAN'),
      content: Column(
        children: [
          TextField(
            controller: currentPasswordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Current Password'),
          ),
          TextField(
            controller: newIBANController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'New IBAN'),
          ),
            if (errorMessage.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
          //  if (errorMessage!='')
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            // Validate passwords and update the Firestore password if needed
            //String newIBAN= newPasswordController.text;
            String currentPassword = currentPasswordController.text;
            bool isCurrentPasswordCorrect = await isCurrentPassCorrect(currentPassword);

            if ( isCurrentPasswordCorrect) {
              // set the iban
              Navigator.of(context).pop();
            } else {
            if (!isCurrentPasswordCorrect) {
                // Show an error message for incorrect current password
                setErrorMessage("Incorrect current password");
                print("wrong current pass");
              }              
            }
          },
          child: Text('Change IBAN'),
        ),
      ],
    );
}
  AlertDialog changeBeneficiaryNameDialog() {
     return AlertDialog(
      title: Text('Change Beneficiary Name'),
      content: Column(
        children: [
          TextField(
            controller: currentPasswordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Current Password'),
          ),
          TextField(
            controller: newBeneficiaryNameController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'New Beneficiary Name'),
          ),
            if (errorMessage.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
           // if (errorMessage!='')
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            // Validate passwords and update the Firestore password if needed
            //String newIBAN= newPasswordController.text;
            String currentPassword = currentPasswordController.text;
            bool isCurrentPasswordCorrect = await isCurrentPassCorrect(currentPassword);

                   if (isCurrentPasswordCorrect) {
  // Check additional conditions before closing the dialog
  if (newBeneficiaryNameController.text == null ||
      newBeneficiaryNameController.text.isEmpty ||
      newBeneficiaryNameController.text.trim().isEmpty) {
    setErrorMessage("Beneficiary name is required");
  } else if (newBeneficiaryNameController.text.startsWith(' ')) {
    setErrorMessage("Cannot start with space");
  } else {
    // Check if there is more than one space between words
    List<String> words = newBeneficiaryNameController.text
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList();

    if (words.length > 1) {
      print(words.length);
      setErrorMessage("Cannot have more than one space between words");
    } else {
      // Reset the error message and close the dialog
      setErrorMessage('');
        RBAccountState.myRBControllerForEdit[6].text =
            newBeneficiaryNameController.text;
      print("fron the account controller the Beneficiary name is ");
      print(RBAccountState.myRBControllerForEdit[6].text);
      Navigator.of(context).pop();
    }
  }
} else {
            if (!isCurrentPasswordCorrect) {
                // Show an error message for incorrect current password
                setErrorMessage("Incorrect current password");
                print("wrong current pass");
              }              
            }
          },
          child: Text('Change Beneficiary Name'),
        ),
      ],
    );
    }


// AlertDialog changeBankInfo() {
//      return AlertDialog(
//       title: Text('Change Bank Info'),
//       content: Column(
//         children: [
//           TextField(
//             controller: currentPasswordController,
//             obscureText: true,
//             decoration: InputDecoration(labelText: 'Current Password'),
//           ),
          
//             if (errorMessage.isNotEmpty)
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 8),
//               child: Text(
//                 errorMessage,
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//            // if (errorMessage!='')
//             Navigator.of(context).pop(); // Close the dialog
//           },
//           child: Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () async {
//             // Validate passwords and update the Firestore password if needed
//             //String newIBAN= newPasswordController.text;
//             String currentPassword = currentPasswordController.text;
//             bool isCurrentPasswordCorrect = await isCurrentPassCorrect(currentPassword);

                   
//                    if (isCurrentPasswordCorrect) {
//    //Navigator.of(context).pop(); // Close the dialog
//    errorMessage='';
// print("before edit bank");
//  EditBankInfoDialog();


// } else {
//                 // Show an error message for incorrect current password
//                 setErrorMessage("Incorrect current password");
//                 print("wrong current pass");            
//             }
//           },
//           child: Text('Change Bank info'),
//         ),
//       ],
//     );
//     }


Future<bool> isCurrentPassCorrect(String currentPass) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("user is null ");
      print(user == null);
      // User is not authenticated
      return false;
    }

    // Sign in with the current user's email and password
    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPass,
    );

    // Attempt to reauthenticate the user with the entered password
    await user.reauthenticateWithCredential(credential);

    // If reauthentication is successful, the entered password is correct
    print("pass is correct");
    return true;
  } catch (e) {
    // Handle any errors that might occur during the reauthentication process
    print('Error in isCurrentPassCorrect: $e');
    print("pass is incorrect");
    return false;
  }
}


AlertDialog changeBankInfo() {
     return AlertDialog(
      title: Text('Change Bank Info'),
      content: Column(
        children: [
          TextField(
            controller: currentPasswordController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Current Password'),
          ),
          
            if (errorMessage.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
           // if (errorMessage!='')
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            // Validate passwords and update the Firestore password if needed
            //String newIBAN= newPasswordController.text;
            String currentPassword = currentPasswordController.text;
            bool isCurrentPasswordCorrect = await isCurrentPassCorrect(currentPassword);

                   
                   if (isCurrentPasswordCorrect) {
   Navigator.of(context).pop(); // Close the dialog
  //  errorMessage='';

 showDialog(
            context: context,
            builder: (BuildContext context) {
return EditBankInfoDialog();

            }
 );


//  return AlertDialog(
//       title: Text('Change Bank Info'),
//       content: Column(
//         children: [
//           TextField(
//             controller: newBankNameController,
//             obscureText: false,
//             decoration: InputDecoration(labelText: 'Current Bank Name'),
//           ),
//              TextField(
//             controller: newIBANController,
//             obscureText: false,
//             decoration: InputDecoration(labelText: 'Current Iban'),
//           ),
//           TextField(
//             controller: newBeneficiaryNameController,
//             obscureText: false,
//             decoration: InputDecoration(labelText: 'Benefic Name'),
//           ),
          
//             if (errorMessageTwo.isNotEmpty)
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 8),
//               child: Text(
//                 errorMessageTwo,
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//            // if (errorMessage!='')
//             Navigator.of(context).pop(); // Close the dialog
//           },
//           child: Text('Cancel'),
//         ),
//      TextButton(
//         onPressed: () {
//           if (newBeneficiaryNameController.text == null ||
//               newBeneficiaryNameController.text.isEmpty ||
//               newBeneficiaryNameController.text.trim().isEmpty ||
//               newBankNameController.text == null ||
//               newBankNameController.text.isEmpty ||
//               newBankNameController.text.trim().isEmpty) {
//             setErrorMessageTwo("Bank/Beneficiary name is required");
//           } else if (newBankNameController.text.startsWith(' ')) {
//             setErrorMessageTwo("Cannot start with space");
//           } else {
//             // Check if there is more than one space between words
//             List<String> words = newBankNameController.text
//                 .split(' ')
//                 .where((word) => word.isNotEmpty)
//                 .toList();

//             if (words.length > 1) {
//               print(words.length);
//               setErrorMessageTwo("Cannot have more than one space between words");
//             } else {
//               // Reset the error message and close the dialog
//               setErrorMessageTwo('');
//               RBAccountState.myRBControllerForEdit[4].text =newBankNameController.text;
//               RBAccountState.myRBControllerForEdit[6].text =newBeneficiaryNameController.text;

//               print("From the account controller, the bank name is ${RBAccountState.myRBControllerForEdit[4].text}");

//               // Add logic for saving the data or updating the UI
//               // ...

//               Navigator.of(context).pop(); // Close the dialog
//             }
//           }
//         },
//         child: Text('Save'),
//       ),
//       ],
//     );
//             }
//  );

}
 else {
                // Show an error message for incorrect current password
                setErrorMessage("Incorrect current password");
                print("wrong current pass");            
            }
          },
          child: Text('Change Bank info'),
        ),
      ],
    );
    }





// AlertDialog changeBankInfo() {
//      return AlertDialog(
//       title: Text('Change Bank Info'),
//       content: Column(
//         children: [
//           TextField(
//             controller: currentPasswordController,
//             obscureText: true,
//             decoration: InputDecoration(labelText: 'Current Password'),
//           ),
          
//             if (errorMessage.isNotEmpty)
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 8),
//               child: Text(
//                 errorMessage,
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//            // if (errorMessage!='')
//             Navigator.of(context).pop(); // Close the dialog
//           },
//           child: Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: () async {
//             // Validate passwords and update the Firestore password if needed
//             //String newIBAN= newPasswordController.text;
//             String currentPassword = currentPasswordController.text;
//             bool isCurrentPasswordCorrect = await isCurrentPassCorrect(currentPassword);

                   
//                    if (isCurrentPasswordCorrect) {
//   //  Navigator.of(context).pop(); // Close the dialog
//     setErrorMessage('');

//  showDialog(
//             context: context,
//             builder: (BuildContext context) {
//  return AlertDialog(
//       title: Text('Change Bank Info'),
//       content: Column(
//         children: [
//           TextField(
//             controller: newBankNameController,
//             obscureText: false,
//             decoration: InputDecoration(labelText: 'Current Bank Name'),
//           ),
//              TextField(
//             controller: newIBANController,
//             obscureText: false,
//             decoration: InputDecoration(labelText: 'Current Iban'),
//           ),
//           TextField(
//             controller: newBeneficiaryNameController,
//             obscureText: false,
//             decoration: InputDecoration(labelText: 'Benefic Name'),
//           ),
          
//             if (errorMessageTwo.isNotEmpty)
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 8),
//               child: Text(
//                 errorMessageTwo,
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//         ],
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//            // if (errorMessage!='')
//             Navigator.of(context).pop(); // Close the dialog
//           },
//           child: Text('Cancel'),
//         ),
//         TextButton(
//           onPressed: ()  {


//  if (newBeneficiaryNameController.text == null ||
//       newBeneficiaryNameController.text.isEmpty ||
//       newBeneficiaryNameController.text.trim().isEmpty || 
//       newBankNameController.text == null ||
//       newBankNameController.text.isEmpty ||
//       newBankNameController.text.trim().isEmpty) {
//     setErrorMessageTwo("Bank/Beneficiary name is required");
//   }
//            else  if (newBankNameController.text.startsWith(' ')) {
//     setErrorMessageTwo("Cannot start with space");
//   } else {
//     // Check if there is more than one space between words
//     List<String> words = newBankNameController.text
//         .split(' ')
//         .where((word) => word.isNotEmpty)
//         .toList();

//     if (words.length > 1) {
//       print(words.length);
//       setErrorMessageTwo("Cannot have more than one space between words");
//     } else {
//       // Reset the error message and close the dialog
//       setErrorMessageTwo('');
//         RBAccountState.myRBControllerForEdit[4].text = newBankNameController.text;
//         RBAccountState.myRBControllerForEdit[6].text = newBeneficiaryNameController.text;

//       print("fron the account controller the bank name is ");
//       print(RBAccountState.myRBControllerForEdit[4].text);

//       //Navigator.of(context).pop();
//     }
//   }

//           },
//           child: Text('Save'),
//         ),
//       ],
//     );
//             }
//  );

// } else {
//                 // Show an error message for incorrect current password
//                 setErrorMessage("Incorrect current password");
//                 print("wrong current pass");            
//             }
//           },
//           child: Text('Change Bank info'),
//         ),
//       ],
//     );
//     }



// Future<bool> isCurrentPassCorrect(String currentPass) async {
//   try {
//     // Get the current user
//     User? user = FirebaseAuth.instance.currentUser;

//     if (user == null) {
//       print("user is null ");
//       print(user == null);
//       // User is not authenticated
//       return false;
//     }

//     // Sign in with the current user's email and password
//     AuthCredential credential = EmailAuthProvider.credential(
//       email: user.email!,
//       password: currentPass,
//     );

//     // Attempt to reauthenticate the user with the entered password
//     await user.reauthenticateWithCredential(credential);

//     // If reauthentication is successful, the entered password is correct
//     print("pass is correct");
//     return true;
//   } catch (e) {
//     // Handle any errors that might occur during the reauthentication process
//     print('Error in isCurrentPassCorrect: $e');
//     print("pass is incorrect");
//     return false;
//   }
// }

}
