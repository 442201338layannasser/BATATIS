import 'dart:convert';

import 'package:batatis/Costomer_Screens/All_Costomer_Screens.dart';
import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
import 'package:batatis/RestaurantBranch_Screens/All_RestaurantBranch_Screens.dart';
import 'package:batatis/Views/driverView.dart';
import 'package:batatis/moudles/Orders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../Costomer_Screens/RecievePage.dart';
import '../moudles/Orders.dart';

class Link {
  static Future<void> createDynamicLink(ResturantId, orderid) async {
    print("createing Dynamic Link $orderid restid $ResturantId");
    String link =
        'https://batatisapp.page.link/OrderId=${SharedPrefer.CurrentOrderId}/ResturantId=${SharedPrefer.CurrentOrderResturantId}';

    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(link),
      uriPrefix: 'https://batatisapp.page.link',
      androidParameters: AndroidParameters(
          packageName: 'com.example.batatis',
          fallbackUrl: Uri.parse('https://androidapp.link')), //live url
    );
    print("long link : " + Uri.parse(link).toString());
    var shortlink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    Clipboard.setData(ClipboardData(text: shortlink.shortUrl.toString()));
    _launchWhatsApp(shortlink.shortUrl);
    print(" Link Genrated : ${shortlink.shortUrl}");
    print(" Link Genrated : ${link}");
  }

  static var OrderId = "";
  static var RestId = "";
  static var OrderNumMember;
  static var preLink = null;
  static Future<void> handleDynamicLinks(c) async {
    bool isfirst = true;

    await FirebaseDynamicLinks.instance.onLink.listen(
      (PendingDynamicLinkData? dynamicLink) async {
        final Uri? deepLink = dynamicLink?.link;

        String deepLinkStr = deepLink.toString();

        // OrderId = deepLinkStr.substring(deepLinkStr.indexOf('=')+1);
        print("revcived link OrderId ${OrderId}");
        print("revcived link ${deepLink}");
        if (deepLink != null) {
          print("notnull");
          if (isfirst) {
            print("first");
            isfirst = false;
             RestId = deepLinkStr.substring(
                  deepLinkStr.indexOf('=', deepLinkStr.indexOf('=') + 1) + 1);
                  OrderId = deepLinkStr.substring(deepLinkStr.indexOf('=') + 1,
                  deepLinkStr.indexOf('/', deepLinkStr.indexOf('=')));
              var isDriver = (RestId == "" || RestId == null ) ? true :false ;
              if(isDriver){Navigator.push(c, MaterialPageRoute(builder: (c) => DriverPage(orderid: OrderId,))); return; } 
            if (SharedPrefer.Islogin!) {
              OrderId = deepLinkStr.substring(deepLinkStr.indexOf('=') + 1,
                  deepLinkStr.indexOf('/', deepLinkStr.indexOf('=')));
              FirebaseFirestore _firestore = FirebaseFirestore.instance;
              var Mmebernum =
                  await _firestore.collection('Orders/$OrderId/Member').get();
              OrderNumMember = Mmebernum.size;
              RestId = deepLinkStr.substring(
                  deepLinkStr.indexOf('=', deepLinkStr.indexOf('=') + 1) + 1);
              
              print("entered this thing $OrderId   rest $RestId isdriver$isDriver");
              print("if");
              if (OrderNumMember <= 20) {
                showDialog(context: c, builder: (c) => JoinGroupDialog(c));
              } else {
                showDialog(
                    context: c,
                    builder: (c) {
                      return CustomDialog(
                        text:
                            "the order reached the maxiumim number of members.",
                        action: null,
                        onPressed: null,
                        title: "max number",
                        type: "reject",
                      );

                      //  AlertDialog(
                      //   title : Text("max number"),
                      //   content: Text ("the order reached the maxiumim number of members."),
                      //   actions: [
                      //     TextButton(onPressed: (){Navigator.pop(c);}, child: Text("ok"))
                      //   ],
                      // );
                    });
              } //else{print("else");}
            } else {
              showDialog(
                  context: c, builder: (context) => SignInDialog(context));
            }
          }
          //Handle the deep link based on your app's logic
        }
      },
      onDone: () {
        print("donee");
      },
      onError: (e) async {
        // Handle errors related to dynamic links here
        // setState(() {
        //   dynamicLinkResult = 'Error handling dynamic link: ${e.message}';
        // });
      },
    );
  }

  static Widget JoinGroupDialog(context) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    var Mmebernum = _firestore.collection('Orders/$OrderId/Member').get();
    // Mmebernum.
    // print("bulding a dilog");
    if (SharedPrefer.CurrentOrderId == null ||
        SharedPrefer.CurrentOrderId == "") {
      return CustomDialog(
        text: "Hurry up! Join the group now",
        action: null,
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
          ViewMenuToCustomerState.RestaurantId = RestId;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewMenuToCustomer(),
            ),
          );
          //Navigator.push(context, MaterialPageRoute(builder: ((context) => )))
          Orders.addMemberToOrder(
              OrderId, SharedPrefer.UserId, SharedPrefer.UserName, RestId , SharedPrefer.UserToken );
              
          print("confirm");
        },
        title: "Join The Group",
        type: "customized",
        MainButton: "Join",
      );

      // AlertDialog(
      //   title: const Text('Confirm join'),
      //   content: const Text('Are you sure you want to Join the group order'),
      //   actions: <Widget>[
      //     TextButton(
      //       onPressed: () => Navigator.pop(
      //         context,
      //       ),
      //       child: const Text(
      //         'cancel',
      //       ),
      //     ),
      //     TextButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //         ViewMenuToCustomerState.RestaurantId = RestId;
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => ViewMenuToCustomer(),
      //           ),
      //         );
      //         //Navigator.push(context, MaterialPageRoute(builder: ((context) => )))
      //         Orders.addMemberToOrder(
      //             OrderId, SharedPrefer.UserId, SharedPrefer.UserName , RestId);
      //         print("confirm");
      //       },
      //       child: Text('confirm'),
      //     ),
      //   ],
      // );
    } else {
      return CustomDialog(
          title: "sorry",
          text:
              'Please complete or cancel your existing order before joining the group order. ',
          action:

              // AlertDialog(
              //   title: Text('sorry'),
              //   content: SingleChildScrollView(
              //     child: ListBody(
              //       children: <Widget>[
              //         Text(
              //             'Please complete or cancel your existing order before joining the group order. '),
              //       ],
              //     ),
              //   ),
              <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                ViewMenuToCustomerState.RestaurantId =
                    SharedPrefer.CurrentOrderResturantId;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewMenuToCustomer(),
                  ),
                );
              },
              child: Text('OK'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (SharedPrefer.CurrentOrderId != null) {
                  FirebaseFirestore.instance
                      .collection("Orders")
                      .doc(SharedPrefer.CurrentOrderId)
                      .delete();
                  SharedPrefer.DeleteCurrentOrder();
                } // Close the dialog
              },
              child: Text("cancel order", style: TextStyle(color: white)),
              style: ElevatedButton.styleFrom(backgroundColor: Batatis_Dark),
            ),
          ],
          onPressed: null);
    }
  }

  static Widget SignInDialog(context) {
    return CustomDialog(
      title: 'Sign in requiered',
      text: 'You are not signed in plese sign in and try again',
      action: null,
      onPressed: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => CSignIn()),
            (route) => false);
      },
      type: "reject",
    );

    // AlertDialog(
    //   title: const Text('Sign in requiered'),
    //   content: const Text('You are not signed in plese sign in and try again'),
    //   actions: <Widget>[
    //     TextButton(
    //       onPressed: () => Navigator.pushAndRemoveUntil(
    //           context,
    //           MaterialPageRoute(builder: (context) => CSignIn()),
    //           (route) => false),
    //       child: const Text(
    //         'Ok',
    //       ),
    //     ),
    //   ],
    // );
  }





 static Future<String> createDynamicLinkfordriver(orderid) async {
    print("createing Dynamic Link $orderid restid ");
    String link =
        'https://batatisapp.page.link/OrderId=${orderid}/ResturantId=';

    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(link),
      uriPrefix: 'https://batatisapp.page.link',
      androidParameters: AndroidParameters(
          packageName: 'com.example.batatis',
          fallbackUrl: Uri.parse('https://androidapp.link')), //live url
    );
    print("long link : " + Uri.parse(link).toString());
    var shortlink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    Clipboard.setData(ClipboardData(text: shortlink.shortUrl.toString()));
   // _launchWhatsApp(shortlink.shortUrl);
    print(" Link Genrated : ${shortlink.shortUrl}");
    print(" Link Genrated : ${link}");
    return shortlink.shortUrl.toString() ; 
  }
  
  static Future<void> sendToDriver(msg) async {
    var link = "There is new order to be delieverd ! $msg ";

  String url = "https://wa.me/?text=$link";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
   // _launchURL();
  }
  }} 


  void _launchWhatsApp(msg) async {
  var link = "Let's order together in BATATIS! $msg ";

  String url = "https://wa.me/?text=$link";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    _launchURL();
  }
}
void _launchURL() async {
  const url = 'https://play.google.com/store/apps/details?id=com.whatsapp';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }}
