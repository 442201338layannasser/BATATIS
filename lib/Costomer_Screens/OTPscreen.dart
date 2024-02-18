import 'package:batatis/Costomer_Screens/All_Costomer_Screens.dart';
import 'package:batatis/Views/Customer_View.dart';
import 'package:batatis/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '/Customer_Widgets/All_customer_Widgets.dart';

class Otpscreen extends StatefulWidget {
  final String verificationId;
  final int? forceResendingToken;
  Otpscreen(
      {Key? key,
      required this.verificationId,
      required this.forceResendingToken})
      : super(key: key);
  @override
  State<Otpscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends State<Otpscreen> {
  String? otpcode;
  @override
  Widget build(BuildContext context) {
    Link.handleDynamicLinks(context);
    final isloading =
        Provider.of<AuthProvider>(context, listen: true).isloading;
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: SafeArea(
          child: isloading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(212, 156, 43, 1),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 30),
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [ //Image.asset('assets/Images/Batatis_logo.jpeg'),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Image.asset('assets/Images/Batatis_logo.jpeg'),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Verification",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Enter the One-Time password that have been sent to your phone number",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black38,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Pinput(
                                  length: 6,
                                  showCursor: true,
                                  defaultPinTheme: PinTheme(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Batatis_Dark),
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  onCompleted: (value) {
                                    setState(() {
                                      otpcode = value;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 25,
                                ),SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: CustomButton( type: "confirm",
                                    text: "Verify",
                                    onPressed: () {
                                      if (otpcode != null) {
                                        verifyotp(context, otpcode!);
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: CustomButton(
                                    text: "resend otp",
                                    onPressed: () {
                                      ap.resendotp(
                                        context,
                                        "+966" + phonecont.text.trim(),
                                        widget.forceResendingToken,
                                      );
                                    },
                                    type: "confirm",
                                  ),
                                ),
                                
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ));
  }

  void verifyotp(BuildContext context, String userotp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    var number = "+966" + phonecont.text.trim();
    ap.verifyotp(
        context: context,
        verificationid: widget.verificationId,
        userotp: userotp,
        onsuccess: () {
          ap.checkexistinguser(number).then((value) async {
            if (value == true) {
              ap.getdatafromfirestore().then(
                    (value) => 
                    ap.saveuserdatatosp().then(
                          (value) => ap.setsignin().then((value) {
                            ap.SetSignedIn(number) ;
                            phonecont.clear();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CHomePage ()),
                                (route) => false);
                          }),
                      ),
                  );
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => name()))); //need name page}
            }
          });
        });
  }
}
