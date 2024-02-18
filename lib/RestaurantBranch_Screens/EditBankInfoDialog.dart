import 'package:batatis/Controller.dart';
import 'package:batatis/Customer_Widgets/colors.dart';
import 'package:batatis/RestaurantBranch_Screens/All_RestaurantBranch_Screens.dart';
import 'package:batatis/RestaurantBranch_Screens/RBAccount.dart';
import 'package:batatis/Routes.dart';
import 'package:batatis/moudles/RB.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditBankInfoDialog extends StatefulWidget {

  @override
  _EditBankInfoDialogState createState() => _EditBankInfoDialogState();
  
}

class _EditBankInfoDialogState extends State<EditBankInfoDialog> {

  TextEditingController newBankNameController = RBAccountState.myRBControllerForEdit[4];
  TextEditingController newIBANController = RBAccountState.myRBControllerForEdit[5];
  TextEditingController newBeneficiaryNameController = RBAccountState.myRBControllerForEdit[6];

  String errorMessage = '';
  String? resturantid=RSharedPref.RestId;
  


  void setErrorMessage(String message) {
    setState(() {
      errorMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("enter edit bank");
      return changeBankInfo();
    
  }



AlertDialog changeBankInfo() {
  print("enter edit bank");
  return AlertDialog(
    title: Text('Change Bank Info'),
    content: Column(
      children: [
        TextField(
          controller: newBankNameController,
          obscureText: false,
          decoration: InputDecoration(labelText: 'Bank Name'),
        ),
        TextField(
          controller: newIBANController,
          obscureText: false,
          decoration: InputDecoration(labelText: 'Iban'),
        ),
        TextField(
          controller: newBeneficiaryNameController,
          obscureText: false,
          decoration: InputDecoration(labelText: 'Beneficiary Name'),
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
        onPressed: () {
          if (newBeneficiaryNameController.text == null ||
              newBeneficiaryNameController.text.isEmpty ||
              newBeneficiaryNameController.text.trim().isEmpty ||
              newBankNameController.text == null ||
              newBankNameController.text.isEmpty ||
              newBankNameController.text.trim().isEmpty ||
              newIBANController.text == null ||
              newIBANController.text.isEmpty ||
              newIBANController.text.trim().isEmpty) {
            setErrorMessage("fields are required");
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
            } 
            if (Controller.ibanValidationForEdit(newIBANController.text)!=null) //returned error msg
            setErrorMessage('Invalid iban');
            else {
              // Reset the error message and close the dialog
              setErrorMessage('');

               showDialog<String>(
  context: context,
  builder: (BuildContext context) => AlertDialog(
    title: const Text('Save information'),
    content: const Text('Are you sure you want to save your Edits?'),
    actions: <Widget>[
      TextButton(
        onPressed: () {
              //newBeneficiaryNameController.text=RBAccountState.myRBControllerForEdit[4].text;
              // newIBANController.text=
               newBankNameController.text =RBAccountState.myRBControllerForEdit[4].text;
          

          Navigator.of(context).pop(); // Close the dialog
          Navigator.of(context).pop(); // Close the dialog
        },
        child: Text(
          'Cancel',
          style: TextStyle(
            color: Batatis_Dark,
          ),
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop(); // Close the dialog
          Navigator.of(context).pop(); // Close the dialog

          RBAccountState.myRBControllerForEdit[4].text = newBankNameController.text;
          RBAccountState.myRBControllerForEdit[5].text = newIBANController.text;
          RBAccountState.myRBControllerForEdit[6].text = newBeneficiaryNameController.text;

          print("From the account controller, the bank name is ${RBAccountState.myRBControllerForEdit[4].text}");

          RB.setBankName(resturantid!, RBAccountState.myRBControllerForEdit[4].text);
          RB.setIban(resturantid!, RBAccountState.myRBControllerForEdit[5].text);
          RB.setBeneficiaryName(resturantid!, RBAccountState.myRBControllerForEdit[6].text);
        

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Your bank information has been updated successfully'),
              backgroundColor: Colors.green,
            ),
          );
        },
        child: Text(
          'Save',
          style: TextStyle(
            color: Batatis_Dark,
          ),
        ),
      ),
    ],
  ),
);


              
            }
          }
        },
        child: Text('Save'),
      ),
    ],
  );
}

}
