// import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
// import 'package:batatis/RestaurantBranch_Screens/All_RestaurantBranch_Screens.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:firebase_core/firebase_core.dart';

// import '../moudles/Orders.dart';
// class RecievePage  extends StatefulWidget{
//    final OrderId ; 
//    const RecievePage ({super.key , this.OrderId});

//    @override
//    State<RecievePage > createState() => RecievePageState();
//  }

//  class RecievePageState extends State<RecievePage >{
//     FirebaseFirestore _firestore = FirebaseFirestore.instance;
//    var OrderId;
//    void initState() {
//     super.initState();  
//     OrderId= widget.OrderId ; 
//      loadData(); 
//   } 
//   Future<void> loadData() async {
//     var Order =_firestore.collection('Orders').doc(OrderId);
//     var Orderqurey  = await Order.get();

//   }

//   @override
//   Widget build(BuildContext context) {
//   showDialog(context: context, builder: (context) => JoinGroupDialog(context));
   
//    return Scaffold(
//     appBar: CustomAppBar(),
//    // body: 
//    ); 
   
   
//   }
  
 




 



// //     String? dynamicLinkResult = 'No dynamic link received yet';

// //   @override
// //   void initState() {
// //     super.initState();
// //     print("inticontext");
// //    //handleDynamicLinks();
// //   }

// //   Future<void> createDynamicLink() async {
// // //       var orderid = "1aScWEtYkThnRLTvCggJihuMkFu1";
// // //     String link='https://batatisapp.page.link/OrderId=${orderid}'; // /group order add any parameters you want ---page.com/latitude=${pinPosition.latitude}&longitude=${pinPosition.longitude} //pinPosition is a variable
// // // //https://batatisapp.page.link/grouporder/H6er7g6MC1a13sx7Ov6s5WJ
// // // print(link);
// // //   final dynamicLinkParams= DynamicLinkParameters(
// // //     link:Uri.parse('https://your_website.com/?OrderId=1aScWEtYkThnRLTvCggJihuMkFu1'), 
// // //     uriPrefix: 'https://batatisapp.page.link', 
// // //     androidParameters: AndroidParameters(
// // //       packageName: 'com.example.batatis',
// // //       fallbackUrl: Uri.parse('https://androidapp.link')), //live url
// // //    );

// // //   var shortlink= await FirebaseDynamicLinks.instance
// // //      .buildShortLink(dynamicLinkParams);

// // //      print(shortlink.shortUrl);

// // // }

// // var orderid = "1aScWEtYkThnRLTvCggJihuMkFu1";
// //     String link='https://batatisapp.page.link/OrderId=${orderid}'; // /group order add any parameters you want ---page.com/latitude=${pinPosition.latitude}&longitude=${pinPosition.longitude} //pinPosition is a variable
// // //https://batatisapp.page.link/grouporder/H6er7g6MC1a13sx7Ov6s5WJ
// // print(link);
// //   final dynamicLinkParams= DynamicLinkParameters(
// //     link: Uri.parse("https://batatisapp.page.link/?OrderId=1aScWEtYkThnRLTvCggJihuMkFu1") ,
// //     uriPrefix: 'https://batatisapp.page.link', 
// //     androidParameters: AndroidParameters(
// //       packageName: 'com.example.batatis',
// //       fallbackUrl: Uri.parse('https://androidapp.link')), //live url
// //    );

// //   var shortlink= await FirebaseDynamicLinks.instance
// //      .buildShortLink(dynamicLinkParams);

// //      print(shortlink.shortUrl);
// //     // Share.share(shortlink.shortUrl.toString());

  
// // //     final dynamicLinkParams = DynamicLinkParameters(
// // //   link: Uri.parse("https://batatisapp.page.link/?page=RecievePage"),//com.example.batatis
// // //   uriPrefix: "https://batatisapp.page.link",
// // //   androidParameters: const AndroidParameters(packageName: "com.example.batatis.android"),
  
// // // );
// // // final dynamicLink = await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
// // // print(dynamicLink);

// //     // final DynamicLinkParameters parameters = DynamicLinkParameters(
// //     //   uriPrefix: 'YOUR_DYNAMIC_LINK_DOMAIN', // Replace with your domain
// //     //   link: Uri.parse('https://example.com/product?id=123'), // Your deep link URL
// //     //   androidParameters: AndroidParameters(
// //     //     packageName: 'com.example.yourapp', // Replace with your Android package name
// //     //   ),
      
// //     // );

// //     // final Uri dynamicUrl = await parameters.buildUrl();
// //     // setState(() {
// //     //   dynamicLinkResult = dynamicUrl.toString();
// //     // });
  
  
// //   // @override
// //   // Widget build(BuildContext context) {
// //   //   // TODO: implement build
    
// //   // }
// //   }
// //  static var GroupOrderId = "";//context static
// //   Future<void> handleDynamicLinks() async {
// // //     final PendingDynamicLinkData? data =
// // //         await FirebaseDynamicLinks.instance.getInitialLink();

// // //     final Uri? deepLink = data?.link;
// // //  print("handleDynamicLinks22222 $deepLink");
// // //     if (deepLink != null) {
// // //       print("showDialog beforerr");
// // //   //    showDialog(context: context, builder: (BuildContext contextt) =>JoinGroupDialog(contextt) );
// // //       // Handle the deep link based on your app's logic
// // //       // setState(() {
// // //       //   dynamicLinkResult = 'Received deep link: $deepLink';
// // //       // });
// // //     }

// //     //Listen for incoming dynamic links while the app is running
// //     FirebaseDynamicLinks.instance.onLink.listen(
// //       (PendingDynamicLinkData? dynamicLink) async {
// //         final Uri? deepLink = dynamicLink?.link;

// //         if (deepLink != null) {
// //           //Handle the deep link based on your app's logic
// //         if(SharedPrefer.Islogin!)
// //          { setState(() {
// //             dynamicLinkResult = 'Received deep link: $deepLink';
// //           });}
// //         }
// //       },
// //       onError: ( e) async {
// //         // Handle errors related to dynamic links here
// //         // setState(() {
// //         //   dynamicLinkResult = 'Error handling dynamic link: ${e.message}';
// //         // });
// //       },
// //    );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Dynamic Link Example'),
// //         ),
// //         body: Center(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               ElevatedButton(
// //                 onPressed: createDynamicLink,
// //                 child: Text('Generate Dynamic Link'),
// //               ),
// //               SizedBox(height: 20),
// //               Text(dynamicLinkResult ?? 'No dynamic link received yet'),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

//  Widget JoinGroupDialog(context){
//     return  AlertDialog(
//                       title: const Text('Confirm join'),
//                       content: const Text(
//                           'Are you sure you want to Join the group order'),
//                       actions: <Widget>[
//                          TextButton(
//                           onPressed: () =>  Navigator.pop(
//                              context,
//                           ),
//                           child: const Text('cancel',),
//                         ),
//                         TextButton(
//                           onPressed: ()  {
//                             Orders.addMemberToOrder(widget.OrderId, SharedPrefer.UserId, SharedPrefer.UserName);
//                             Navigator.pop(context,);
                           
//                           },
//                           child:   Text('confirm'),
//                         ),
//                       ],
                    
//                   );
//   }
// }
// // //   @override
// // // void initState() {
// // //   super.initState();
// // //   _initDynamicLinks();
// // // }

// // // Future<void> _initDynamicLinks() async {
// // //   Stream<PendingDynamicLinkData> pteto  = FirebaseDynamicLinks.instance.onLink ; 
// // //   bool sadeem = await pteto.isEmpty;
// // //   print("sadeem $sadeem");
// // //  await pteto.first.then((value) {
// // //   print(value);

// // //  });
// // //   //print("pteto ${await pteto.first.toString()}");
// // //   // (
// // //   //   onSuccess: (PendingDynamicLinkData? dynamicLink) async {
// // //   //     final Uri? deepLink = dynamicLink?.link;
// // //   //     if (deepLink != null) {
// // //   //       if (deepLink.path == '/product') {
// // //   //         final String productId = deepLink.queryParameters['id'] ?? '';
// // //   //         // Navigate to the ProductPage and pass the product ID as an argument
// // //   //         Navigator.pushNamed(context, '/product', arguments: {'id': productId});
// // //   //       }
// // //   //       // Add handling for other deep links and pages here
// // //   //     }
// // //   //   },
// // //   //   // Handle errors
// // //   //   onError: (e) async {
// // //   //     // Handle error cases here
// // //   //     print('Error: ${e.message}');
// // //   //   },
// // //   // );
// // // }


// // //   @override
// // //   Widget build(BuildContext context) {

 
// // //     // final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
// // //     // final String OrderId = arguments['OrderId'] ?? '';


// // //     // Build the UI for the ProductPage
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('OrderId Details'),
// // //       ),
// // //       body: Center(
// // //         child: Text('OrderId: OrderId'),
// // //       ),
// // //     );
    
    
// // //   }
  
      
// // // }