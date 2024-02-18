
import 'package:batatis/Controller.dart';
import 'package:batatis/Costomer_Screens/All_Costomer_Screens.dart';
import 'package:batatis/Views/Customer_View.dart';
import 'package:batatis/provider/auth_provider.dart';
import 'package:batatis/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../moudles/Customer.dart';
import '/Customer_Widgets/All_customer_Widgets.dart';
import 'package:batatis/Customer_Widgets/colors.dart';
import 'package:batatis/Customer_Widgets/Customer_buttons.dart';
class name extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _namestate() ; 
}
class _namestate extends State<name> {
  String? otpcode;  
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Link.handleDynamicLinks(context);
    final ap = Provider.of<AuthProvider>(context, listen: false);
    var number = "+966" + phonecont.text.trim();
  
    return Scaffold(resizeToAvoidBottomInset: false,
      appBar: AppBar(automaticallyImplyLeading : false ),
      body: Center(
        child: Column(
          children: [
              const SizedBox(height: 150,),

            Image.asset('assets/Images/Batatis_logo.jpeg'),
          
            
            CustomTextFiled(type: 'large',
              text: 'Enter your name',
              isvaild: Controller.EmptyValidation1,
              Controller: nameController,
            ),
            CustomButton(text: 'Ok',
              onPressed: () async {
                String enteredName = nameController.text;
                if (enteredName.isNotEmpty) {
                  Customer c = Customer(name: nameController.text, phonenumber: number);
                  await c.addcustomer(ap.uid);
                   ap.SetSignedIn(number) ;
                  phonecont.clear();
                  Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CHomePage ()),
                                (route) => false);
                  
                }
              },
              
            type: 'confirm', ),
          ],
        ),
      ),
    );
  }
  
}
