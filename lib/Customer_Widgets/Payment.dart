import 'package:batatis/Costomer_Screens/All_Costomer_Screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import 'All_customer_Widgets.dart';

Map<String, dynamic>? paymentIntent;

class payment {
  // payment(){
  //   print("new instnce");
  //   paymentIntent![""];
  // }
  var IDorder ; 
  Future<void> makePayment(amount , orderid) async {
    IDorder = orderid ; 
    print("makepayment ${amount  }");

    var x = amount.toString().length  - amount.toString().indexOf('.') - 1 ; 
    if(x==1){
      
      amount = amount.toString() + "0" ; }
    print(x );
    var amount2 = amount.toString().replaceAll('.', "") ;//amount.toString(); //amount.toString().substring(0,amount.toString().indexOf('.')).toString() ;
    print("amount2 $amount2"); 
    try {
      paymentIntent = await createPaymentIntent((amount2).toString(), 'SAR');
      print("object $amount");
      //STEP 2: Initialize Payment Sheet

      print("steppp 2");
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
        billingDetailsCollectionConfiguration:
            BillingDetailsCollectionConfiguration(
                address: AddressCollectionMode.never,
                name: CollectionMode.never,
                email: CollectionMode.never),

        billingDetails: null, //BillingDetails(name:  " ashhhhh ") ,
        paymentIntentClientSecret:
            paymentIntent!['client_secret'], //Gotten from payment intent
        style: ThemeMode.light,
        merchantDisplayName: 'BATATIS',
        appearance: PaymentSheetAppearance(
            primaryButton: PaymentSheetPrimaryButtonAppearance(
                colors: PaymentSheetPrimaryButtonTheme(
                    light: PaymentSheetPrimaryButtonThemeColors(
                        background: Batatis_Dark))),
            colors: PaymentSheetAppearanceColors()),

        //googlePay: gpay
      ))
          .then((value) {
        print("val");
        print(" value valuee          $value");
      });

      //STEP 3: Display Payment sheet
      print("steppp 3");
      displayPaymentSheet();
      print("sucsses");
    } catch (err) {
      print("erorrrrrrr");
      print(err.toString());
    }
  }

  displayPaymentSheet() async {
    print("displaypaymentsheet");
    try {
      var _fireStoreInstance = FirebaseFirestore.instance;

      var s = await Stripe.instance.presentPaymentSheet().then((value) {
        print("hihihihihihihihihihihih");
        print("hosnvpancssssuyu ${paymentIntent!["status"]} hoho ");
        var orderID = IDorder ; //SharedPrefer.CurrentOrderId.toString();
        print("paymentintent status2 ${paymentIntent!["status"]}");
        print("Orders/ $orderID here is the path");
        _fireStoreInstance
            .collection("Orders")
            .doc(orderID)
            .update({'PaymentMethod': 'Paid'});
            SummaryPage.set!((){
              print("set staste summerypage froom payment");
            });
      //  SharedPrefer.SetStatus(orderID, "Preparing");
        //  print("the redult of payment ${value.toString()}");
      });
      ////  print("paymentintent status ${paymentIntent!["status"]}");
    } catch (e) {
      print("object errrorrsss");
      print('error6777 ${e.toString()}');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    print("amount $amount");
    print("createPaymentIntent");

    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };
      print("before response");
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51O1zUECOEKBCIL7IOPdfCposTk5NoLDRJ3q5vhLD9XNQrYMzMGolXZeMb6GQKJix5k1Bwm4bs1lkgBQ3xKE3sqgu00ehbsYuzf',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print(response.body);
      print("after response");
      return json.decode(response.body);
    } catch (err) {
      print("errrr");
      throw Exception(err.toString());
    }
  }
}
