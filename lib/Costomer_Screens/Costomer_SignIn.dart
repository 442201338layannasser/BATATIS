import 'dart:io';
import 'package:batatis/main.dart';
import 'package:batatis/provider/auth_provider.dart' as authp;
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../Views/Customer_View.dart';
import '../Views/driverView.dart';
import '/Customer_Widgets/All_customer_Widgets.dart';

Country country = Country(
  phoneCode: "966",
  countryCode: "SA",
  e164Sc: 0,
  geographic: true,
  level: 1,
  name: "saudi",
  example: "saudi",
  displayName: "saudi",
  displayNameNoCountryCode: "SA",
  e164Key: "",
);
final TextEditingController phonecont = TextEditingController();

class CSignIn extends StatefulWidget {
  CSignIn({super.key});
//static get  cont => _CSignInState.phonecont ;
  @override
  State<CSignIn> createState() => _CSignInState();
}

class _CSignInState extends State<CSignIn> {
  final _CsigninKey = GlobalKey<FormState>();
  String errorMsg = " ";

  List<TextEditingController> myController =
      List.generate(3, (i) => TextEditingController());
  void initState() {
    super.initState();
    checkLoggedin();
  }

  void checkLoggedin() async {
    SharedPrefer.printPrefrenses();
    await SharedPrefer.SetSharedPrefer();
    print("hohohohho ");
    SharedPrefer.printPrefrenses();
    if ((SharedPrefer.Islogin!)) {
      print("checking if the user is loged in he is loged in ");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const CHomePage()),
          (route) => false);
    } else {
      print("checking if the user is loged in he is not  loged in ");
    }
  }

  Widget build(BuildContext context) {
    Link.handleDynamicLinks(context);

    print("checking if the user is loged in  not loged in ");
    phonecont.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phonecont.text.length,
      ),
    );

    // if(Batatis.istesting){
    //    final ap = Provider.of<AuthProvider>(context, listen: false);
    // var number = "+966" +"553132199";
    //    ap.SetSignedIn2(number,"6aE6h2cAGza2p6y7Kw9lHmHNo8p2") ;
    //                         phonecont.clear();
    //                         Navigator.pushAndRemoveUntil(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => const CHomePage ()),
    //                             (route) => false);
    // }
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            //scrollDirection: Axis.vertical,
            child: Form(
                key: _CsigninKey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment :CrossAxisAlignment.end
                    children: [
                      const SizedBox(
                        height: 150,
                      ),
                      // TextButton(onPressed: (){Signoneclick();}, child: Text ("log in with one click")///////////////////////////////////////////
                      // ),
                      Image.asset('assets/Images/Batatis_logo.jpeg'),

                      CustomText(
                        text: "Sign In",
                        type: "heading",
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                          width: 380,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 18),
                            maxLength: 9,
                            inputFormatters: [
                              FilteringTextInputFormatter(RegExp(r'[0-9]'),
                                  allow: true)
                            ],
                            onChanged: (value) {
                              setState(() {
                                phonecont.text = value;
                              });
                            },
                            cursorColor: Batatis_Dark,
                            controller: phonecont,
                            decoration: InputDecoration(
                                hintText: "Enter your phone number",
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                prefixIcon: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    child: Text(
                                      "${country.flagEmoji} + ${country.phoneCode}",
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ),
                                ),
                                suffixIcon: phonecont.text.length > 8
                                    ? Container(
                                        height: 20,
                                        width: 20,
                                        margin: const EdgeInsets.all(10.0),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: const Icon(
                                          Icons.done,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                      )
                                    : null),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 250,
                        height: 60,
                        child: CustomButton(
                          text: "Sign In",
                          onPressed: () => sendphonenumber(),
                          type: "confirm",
                        ),
                      ),
                //    TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DriverPage(orderid: "Poargfd6GkxlCAT10mty")));}, child: Text("hoho"))
                    ],
                  ),
                ))));
  }

  void sendphonenumber() {
    if (phonecont.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please Enter phone number"),

          backgroundColor: Colors.red, // Customize the Snackbar's appearance.
        ),
      );
      exit(0);
    }
    ;
    final ap = Provider.of<authp.AuthProvider>(context, listen: false);
    String phonenumber = phonecont.text.trim();
    ap.signinwithphonenumber(context, "+${country.phoneCode}$phonenumber");
  }

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {}
  }


}
