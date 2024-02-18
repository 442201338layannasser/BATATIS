import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class sharelink //extends StatelessWidget
{
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       body: Center(
  //         child: CustomButton(
  //           onPressed: _launchWhatsApp,
  //           text: 'invite your group via whatsapp!',
  //         ),
  //       ),
  //     ),
  //   );
  // }

  static void _launchWhatsApp() async {
    var link = "msg";
    String url = "https://wa.me/?text=$link";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _launchURL();
    }
  }

  static void _launchURL() async {
    const url = 'https://play.google.com/store/apps/details?id=com.whatsapp';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
