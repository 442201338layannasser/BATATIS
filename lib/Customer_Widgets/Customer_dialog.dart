// import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
// import 'package:flutter/material.dart';

// class CustomDialog extends StatelessWidget {
//   final String text;
//   final String type;
//   String? title;
//   List<Widget> action = [];
//   final VoidCallback onPressed;

//   CustomDialog({
//     this.title,
//     required this.text,
//     this.type = "default",
//     this.action = const [Text("")],
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     switch (type) {
//       case "confirm":
//         {
//           return baseDialog(
//             title: "Confirmation",
//             text: text,
//             action: <Widget>[
//               CustomButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 text: "OK",
//                 type: "confirm",
//               ),
//             ],
//           );
//         }
//       case "reject":
//         {
//           return baseDialog(
//             title: "Sorry",
//             text: text,
//             action: <Widget>[
//               CustomButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   text: "OK",
//                   type: "confirm"),
//             ],
//           );
//         }
//         case "reject1":
//         {
//           return baseDialog(
//             title: "Sorry",
//             text: text,
//             action: <Widget>[
//               CustomButton(
//                   onPressed: onPressed,
//                   text: "OK",
//                   type: "confirm"),
//             ],
//           );
//         }
//       case "customized":
//         {
//           return baseDialog(
//             title: title,
//             text: text,
//             action: <Widget>[
//               CustomButton(
//                   onPressed: onPressed, text: "Confirm", type: "confirm"),
//               CustomButton(
//                 text: "Cancel",
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           );
//         }
//       case "customizeddanger":
//         {
//           return baseDialog(
//             title: title,
//             text: text,
//             action: <Widget>[
//               CustomButton(
//                   onPressed: onPressed, text: "Confirm", type: "delete"),
//               CustomButton(
//                 text: "Cancel",
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           );
//         }
//       default:
//         {
//           return baseDialog(title: title, text: text, action: action);
//         }
//     }
//   }

//   Widget baseDialog(
//       {String? title, required String text, required List<Widget> action}) {
//     return AlertDialog(
//       title: Text(title!),
//       content: Text(text),
//       actions: action,
//     );
//   }
// }

import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String text;
  final String type;
  String title ;
  String MainButton;
  dynamic action = [];
  final dynamic onPressed;

  CustomDialog({
    this.title = "",
    required this.text,
    this.type = "default",
    required this.action ,
    required this.onPressed,
    this.MainButton = "OK"
    
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case "confirm":
        {
          return baseDialog(
            title: "Confirmation",
            text: text,
            action: action == null ? <Widget>[
              ElevatedButton(
                      onPressed: onPressed == null ?  (){ Navigator.pop(context);} : onPressed, //onPressed,
                      child: Text("Ok",style: TextStyle(color: white),),
                      style: ElevatedButton.styleFrom(
                            backgroundColor:Batatis_Dark),)
              // CustomButton(
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //     text: "OK",
              //     type: "confirm",
              //     width: 70,
              //     height: 35
              //     ),
            ] : action ,
          );
        }
      case "reject":
        {
          return baseDialog(
            title: title == "" ? "Sorry" : title,
            text: text,
            action: action == null ? <Widget>[

                    ElevatedButton(
                      onPressed: onPressed == null ? (){ Navigator.pop(context);} : onPressed, //onPressed,
                      child: Text("Ok",style: TextStyle(color: white),),
                      style: ElevatedButton.styleFrom(
                            backgroundColor:Batatis_Dark),)
             
            ] : action,
          );
        }
      case "customized":
        {
          return baseDialog(
            title: title,
            text: text,
            action:  action == null ? <Widget>[
               TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('cancel'),
              ),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Batatis_Dark, ), // Change the button's background color here
                child: Text(
                  MainButton,
                  style: TextStyle(
                    color: Colors.white, // Set the text color to white
                  ),
                ),
              ),
             
            ] : action,
          );
        }

      case "customizeddanger":
        {
          return baseDialog(
            title: title,
            text: text,
            action: action == null ? <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancle'),
              ),
              CustomButton(text: MainButton, onPressed: onPressed , type: "delete",width: 0,height: 0,fontSize: 12,)
              // ElevatedButton(
              //   onPressed: onPressed,
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor:
              //         red, ),
              //   child: Text(
              //     title,
              //     style: TextStyle(
              //       color: Colors.white, // Set the text color to white
              //     ),
              //   ),
              // ), 
              
            ] : action ,
          );
        }
      default:
        {
          return baseDialog(title: title, text: text, action: action);
        }
    }
  }

  Widget baseDialog(
      {String? title, required String text, required List<Widget> action}) {
    return AlertDialog(
      title: Text(title!),
      content: Text(text),
      actions:  action,
 );
}
}