import 'package:batatis/Costomer_Screens/CGroupOrderCart%20.dart';
import 'package:batatis/Costomer_Screens/Cmainpage.dart';
import 'package:batatis/RestaurantBranch_Screens/All_RestaurantBranch_Screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Customer_Widgets/MemberDialog.dart';
import '../Views/Customer_View.dart';
import '../moudles/Orders.dart';
import '../provider/auth_provider.dart';
import '/Customer_Widgets/All_customer_Widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '/moudles/RB.dart';
import 'package:batatis/Customer_Widgets/CLocationPicker.dart' as cl;
import 'package:badges/badges.dart' as badges;
////////////////////////////////////////
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'lastNoti.dart';
import 'package:http/http.dart' as http;
/////////////////////////////////////////

//    rest = ModalRoute.of(context)!.settings.arguments as String;

//ViewMenuToCustomer
//ViewMenuToCustomerState

Map<DocumentSnapshot, double> listnearby = CmainpageState.listofnearby;

FirebaseFirestore db = FirebaseFirestore.instance;
RB resturantObj = new RB.basic();

String Rid = ' '; //=uid!
String msg = " ";

class ViewMenuToCustomer extends StatefulWidget {
  ViewMenuToCustomer({super.key});
  String? RestaurantId;

  @override
  State<ViewMenuToCustomer> createState() => ViewMenuToCustomerState();
}
 
class ViewMenuToCustomerState extends State<ViewMenuToCustomer> {
  late TabController _tabController;
  static late StateSetter setstate;
  late final ap;
  static  int _newOAmount  = 0 ;
  ////////////////////////////////////////////
  NotificationServices notificationServices = NotificationServices();
////////////////////////////////////////////////////////////////////////


  void initState() {
    super.initState();
   // if(canceldilog){print("canceldilogcanceldilogcanceldilogcanceldilog inti");}
    loadData();
    
     _newOAmount = SharedPrefer.numOfOrders!;
     print("_newOAmount_newOAmount ${_newOAmount}");
    //iscreator = SharedPrefer.iscreator! ;
    ///////////////////////////////
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    // notificationServices.isTokenRefresh();
    print("loaddataaaaaa");
    notificationServices.getDeviceToken().then((value) {
      print('device token yesssss');

      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
    //////////////////////////////////////////
  }

  bool isLoggedIn = false; // Check if the user is logged in



  static String? RestaurantId;
  Map<String, Widget> listOfMenuItemsImages = {};
  List<DocumentSnapshot> listOfMenuItems = [];
  late Widget RestaurantLogo;
  bool iscreator = true;
  Future<void> loadData() async {
    ap = Provider.of<AuthProvider>(context, listen: false);
    print("data loading");
    try {
      isLoggedIn = await ap.issignedin;
      SharedPrefer.SetSharedPrefer();

      if (isLoggedIn) {
        // RestaurantId = widget.RestaurantId;//ModalRoute.of(context)!.settings.arguments as String; ///await Controller.getUid();
        await fetchRestaurantsMenu();
        await loadMenuItemsImages();
        await loadResurantsinfo();
        setState(() {
          // GenrateResturansCards() ;
          // restaurantsMarkers = GenrateMarkers(listOfRestaurants);
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchRestaurantsMenu() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(RestaurantId)
        .collection("menu")
        .get();
    listOfMenuItems = querySnapshot.docs.toList();
  }

  Future<void> loadMenuItemsImages() async {
    for (final doc in listOfMenuItems) {
      final String imagePath = "/Restaurants/$RestaurantId/${doc.id}";
      print("hereee $imagePath");
      await PhotoPicker.getimg(imagePath);
      final String imageUrl = await PhotoPicker.geturl();

      listOfMenuItemsImages[doc.id] = Padding(
        padding: EdgeInsets.all(0),
        child: ClipRRect(
            borderRadius:
                BorderRadius.circular(10), // Set the border radius here
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 87,
              height: 70,
            )),
      );
    }
  }

  Future<void> loadResurantsinfo() async {
    final DocumentSnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('Restaurants')
            .doc(RestaurantId)
            .get();

    ResturantName = querySnapshot.get("Resturant Name");
    ResturantAddress = querySnapshot.get("Address");
    ResturantStartTime = querySnapshot.get("StartTime");
    ResturantEndTime = querySnapshot.get("EndTime");
    ResturantFee = querySnapshot.get("Fee");
    print("lennnnn ${listnearby.length}");
    listnearby.forEach((key, value) {
      print("object keykeyekye");
      if (key.id == RestaurantId) distance = value.toString();
    });
    opened = cl.LocationPickerState.getopenedclosed(
        ResturantStartTime!, ResturantEndTime!);
    if (opened) {
      Resturantstatus = "Opened";
    } else {
      Resturantstatus = "Closed";
    }

    final String imagePath = "/Restaurants/$RestaurantId/Logo";

    await PhotoPicker.getimg(imagePath);
    final String imageUrl = await PhotoPicker.geturl();
    RestaurantLogo = Padding(
      padding: EdgeInsets.all(0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // Set the border radius here
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 150,
          height: 150,
        ),
      ),
    );

    //   CachedNetworkImage(
    //   imageUrl: imageUrl,
    //   width: 150,
    //   height: 150,
    // );
  }

  Set<DocumentSnapshot> mySet = {};
  List<String> urls = [];
  late String resturantLogo = "";
  late String RestLogoURI = "";
  static late String? ResturantName = "";
  late String? ResturantAddress = "";
  late String? ResturantStartTime = "";
  late String? ResturantEndTime = "";
  static late String? ResturantFee = "";
  static late String? distance = "";
  bool opened = true;
  static String Resturantstatus = '';
  String Statues = '';
  @override
  Widget build(BuildContext context) {
    //if(canceldilog){print("canceldilogcanceldilogcanceldilogcanceldilog22222222222");}
     _newOAmount = SharedPrefer.numOfOrders!;

    Link.handleDynamicLinks(context);
    setstate = setState;
    // final resturantID = ModalRoute.of(context)!.settings.arguments as String;
    // print(resturantID);
    List<Widget> cards() {
      List<Widget> cc = [];
      int i = -1;
      listOfMenuItems.forEach((itemData) {
        i = i + 1;
        Widget img = listOfMenuItemsImages[itemData.id]!;
        i = i + 1;

        print("before cc");
        cc.add(
          GestureDetector(
              onTap: () {
                int quantity = 1; // Initial quantity value
                String priceString =
                    itemData.get('price'); // Assuming price is a string
                double rprice = double.parse(priceString);
                double priceChanded = rprice;

                //int quantity = 1; // Initial quantity value
                checkkicked(context);
                if (!iscicked) {
                  showDialog(
                    context: context,
                    builder: (BuildContext Dialogcontext1) {
                      return Center(
                        child: Container(
                            width: 450, // Set the width as desired

                            height: 540, // Set the height as desired

                            child: AlertDialog(
                              title: Text('Item Details'),
                              content: StatefulBuilder(
                                builder: (BuildContext scontext,
                                    StateSetter setState) {
                                  void incrementQuantity() {
                                    setState(() {
                                      print("inc q");
                                      if (quantity < 100) {
                                        // Check if quantity is less than 100 before incrementing
                                        quantity++;
                                        priceChanded = rprice * quantity;
                                        print(quantity);
                                      }
                                    });
                                  }

                                  void decrementQuantity() {
                                    setState(() {
                                      if (quantity > 1) {
                                        print("dec q");

                                        quantity--;
                                        priceChanded = rprice * quantity;
                                        print(quantity);
                                      }
                                    });
                                  }

                                  return Column(
                                    children: [
                                      //container the image

                                      Container(
                                          width:
                                              120, // Set the width of the container

                                          height:
                                              120, // Set the height of the container

                                          child: img //remove the color

                                          // add borderRadius: BorderRadius.circular(10),

                                          //child: //the image

                                          ),

                                      // Add item details here

                                      CustomText(
                                          text: itemData.get('Name'),
                                          type: "Subheading1B"),

                                      Text(
                                        '${itemData.get('description')}',
                                        textAlign: TextAlign.justify,
                                      ),

                                      SizedBox(height: 10.0), //
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('$priceChanded SR'),
                                          SizedBox(
                                              width:
                                                  20.0), // Adjust the width as needed for spacing
                                          Container(
                                            width:
                                                90, // Adjust the width as needed
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Batatis_Dark,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: decrementQuantity,
                                                  child: Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Batatis_Dark,
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10.0),
                                                Text('$quantity'),
                                                SizedBox(width: 10.0),
                                                InkWell(
                                                  onTap: incrementQuantity,
                                                  child: Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Batatis_Dark,
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(Dialogcontext1)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text('Close'),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    // Close the original dialog

                                    Navigator.of(Dialogcontext1).pop();
                                    bool Isadded = false;
                                    bool neworder = true;
                                    bool firsttime = true;
                                    bool confirmed= false;
                                    // Implement your "Add to Cart" logic here
                                    if (SharedPrefer.CurrentOrderId == null ||
                                        SharedPrefer.CurrentOrderId == "") {
                                      print("there is no order yet");
                                      var Orderid = await Orders.addorder(
                                          creatorId:
                                              SharedPrefer.UserId.toString(),
                                              number:   SharedPrefer.UserPhoneNumber.toString(),
                                          name:
                                              SharedPrefer.UserName.toString(),
                                              Token: SharedPrefer.UserToken.toString() ,
                                          deleveryLocation: SharedPrefer
                                              .UserAddress.toString(),
                                          RestaurantID: RestaurantId.toString(),
                                          OrderTime: DateTime.now().toString(),
                                          Total: "0",
                                          status: "ongoing");
                                      Isadded = await Orders.addMemberItems(
                                          Orderid,
                                          SharedPrefer.UserId.toString(),
                                          itemData.get('Name'),
                                          quantity,
                                          double.parse(itemData.get('price')));
                                    } else {
                                      firsttime = false;
                                      print("there is order ");
                                      if (SharedPrefer.status.toString() ==
                                          "ongoing") {
                                        print("ongoing");
                                        if (RestaurantId ==
                                            SharedPrefer
                                                .CurrentOrderResturantId) {
                                          print("same resturant ");
           // sadeem check                               
       var memberRef = await FirebaseFirestore.instance.collection('Orders').doc(SharedPrefer.CurrentOrderId).collection('Member').doc(SharedPrefer.UserId.toString());
      var qurey = await memberRef.get();
       confirmed = qurey.get("confirmed");
                                      if (!confirmed){
      ///
                                          Isadded = await Orders.addMemberItems(
                                              SharedPrefer.CurrentOrderId,
                                              SharedPrefer.UserId.toString(),
                                              itemData.get('Name'),
                                              quantity,
                                              double.parse(
                                                  itemData.get('price')));}
                                        } else {
                                          print("diffrent resturant");
                                          neworder = false;
                                          showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext Dialogcontext2) {
                                              return CustomDialog(
                                                title: "Sorry",
                                                text:
                                                    'Please complete or cancel your existing order before placing a new one. ',
                                                onPressed: () {},
                                                action: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      if (SharedPrefer
                                                              .CurrentOrderId !=
                                                          null) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "Orders")
                                                            .doc(SharedPrefer
                                                                .CurrentOrderId)
                                                            .delete();
                                                        SharedPrefer
                                                            .DeleteCurrentOrder();
                                                      } // Close the dialog
                                                    },
                                                    child:
                                                        Text('cancel order '),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                      ViewMenuToCustomerState
                                                              .RestaurantId =
                                                          SharedPrefer
                                                              .CurrentOrderResturantId;
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ViewMenuToCustomer(),
                                                        ),
                                                      );
                                                    },
                                                    child: Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      } else {
                                        print("no ongoing");
                                      }
                                    }

                                    // You can add the selected item to the cart with the selected quantity.

                                    // Remember to update your state or perform any other necessary actions.

                                    // Show the custom confirmation dialog

                                    //if addTocart(itme, price, quanitity) is true :
                                    ///   Navigator.pop(context);
                                    if (confirmed){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext Dialogcontext2) {
                                          return CustomDialog(
                                               type: "reject",
                                            onPressed: null,
                                            text:
                                                'You can not add an item if the order is confirmed',
                                            action: null,
                                    );},
                                );}
                                    else if (neworder) if (Isadded) {
                                      print("is added true");
                                      // ScaffoldMessenger.of(context).showSnackBar(
                                      //   SnackBar(
                                      //   content: Text("The item has been added to the order succsesfully"),
                                      //   backgroundColor:Colors.green, // Customize the Snackbar's appearance.
                                      //   ),);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext Dialogcontext2) {
                                          return CustomDialog(
                                              text:
                                                  'Item added to cart successfully.',
                                              onPressed: () async {
                                                if (firsttime) {  
                                               
                                                  // here sadeem 
                                                 // counter  = share +
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  // ViewMenuToCustomerState.RestaurantId = RestaurantId;
                                             
                                                    _newOAmount= SharedPrefer.numOfOrders! + 1;
                                                      
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewMenuToCustomer(),
                                                    ),
                                                  );
                                                } else {
                                                 
                                                 setState(() {
                                                 });
                                                 
                                                  
                                                    print("new num of amount $_newOAmount" );
                                                //   await SharedPrefer.SetNumOfOrders( _newOAmount);
                                                  Navigator.pop(context);
                                                }
                                              },
                                              type: "confirm",
                                              action: null);
                                        },
                                      );
                                    } else {
                                      // ScaffoldMessenger.of(context).showSnackBar(
                                      // SnackBar(
                                      // content: Text(" an error occured The item failed to be added the order"),
                                      // backgroundColor: Colors.red, // Customize the Snackbar's appearance.
                                      // ),);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext Dialogcontext3) {
                                          return CustomDialog(
                                            type: "reject",
                                            onPressed: null,
                                            text:
                                                'Item failed to add please try again later .',
                                            action: null,
                                          );
                                        },
                                      );
                                    }

                                    // You can close the dialog if needed

                                    // Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        Batatis_Dark, // Change the button's background color here
                                  ),
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      color: Colors
                                          .white, // Set the text color to white
                                    ),
                                  ),
                                )
                              ],
                            )),
                      );
                    },
                  );
                }
              },
              child: Container(
                width: 180,
                height: 180,
                padding: const EdgeInsets.all(
                    0), // i think between the info of the item and the edges of the card
                margin:
                    const EdgeInsets.all(5), //for the item card with the screen
                child: Column(
                  //معلومات الايتم تحت بعض في الكارد في المينيو
                  children: [
                    img,
                    CustomText(
                        text: itemData.get('Name'), type: "Subheading1B"),

                    Container(
                      child: CustomText(
                          text: itemData.get('description').length > 45
                              ? itemData.get('description').substring(0, 45) +
                                  '...'
                              : itemData.get('description'),
                          type: "paragraph"),
                      height: 40,
                      margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    ),
                    //  SizedBox(height: 7),
                    // Tooltip(
                    //      child:
                    //     CustomText(text: 'more',color:Batatis_Dark ,),
                    //     decoration: BoxDecoration(color: Batatis_Dark),
                    //     richMessage: TextSpan(
                    //       text: itemData.get('description'),
                    //       // textStyle: TextStyle(color: Colors.white),
                    //     ),
                    //   ),

                    //    CustomText(text: itemData.get('price') + ' SR',type: "paragraph"),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: itemData.get('price') + ' SR',
                            type: "Subheading2ResturantMenu",
                          ),

                          SizedBox(
                              width:
                                  70), // Add some space between the price text and the circle

                          Container(
                            width: 28, // Set the width of the circle

                            height: 28, // Set the height of the circle

                            decoration: BoxDecoration(
                              shape: BoxShape.circle,

                              color:
                                  Batatis_Dark, // Set the circle color to red
                            ),

                            child: Center(
                              child: Icon(
                                Icons.add,

                                color: Colors
                                    .white, // Set the plus icon color to white
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      //offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              )),
        );
        print("after cc");
      }); //for each item in the mySet
      // urls.clear();
      // mySet.clear() ;
      return cc;
    } //cards()

    int i = 0;
//Image.asset('assets/Images/Batatis_logo.jpeg');
    var actions = [
      IconButton(
          icon: Icon(
            Icons.groups_2,
            size: 35,
            color: white,
          ), // Replace with your desired icon
          onPressed: () async {
            if (SharedPrefer.CurrentOrderId == null ||
                SharedPrefer.CurrentOrderId == "") {
              print("there is no order yet");
              var Orderid = await Orders.addorder(
                                              number:   SharedPrefer.UserPhoneNumber.toString(),

                  creatorId: SharedPrefer.UserId.toString(),
                  name: SharedPrefer.UserName.toString(),
                              Token: SharedPrefer.UserToken.toString() ,
                  deleveryLocation: SharedPrefer.UserAddress.toString(),
                  RestaurantID: RestaurantId.toString(),
                  OrderTime: DateTime.now().toString(),
                  Total: "0",
                  status: "ongoing");
            }
            checkkicked(context);
            if (!iscicked) {
              print("object");
              showDialog(
                context: context,
                builder: (context) {
                  return MemberListDialog();
                },
              );
            }
          }),
      IconButton(
          onPressed: () async {
            if (SharedPrefer.CurrentOrderId == null ||
                SharedPrefer.CurrentOrderId == "") {
              print("there is no order yet");
              var Orderid = await Orders.addorder(
                  creatorId: SharedPrefer.UserId.toString(),
                                              number:   SharedPrefer.UserPhoneNumber.toString(),

                  name: SharedPrefer.UserName.toString(),
                              Token: SharedPrefer.UserToken.toString() ,
                  deleveryLocation: SharedPrefer.UserAddress.toString(),
                  RestaurantID: RestaurantId.toString(),
                  OrderTime: DateTime.now().toString(),
                  Total: "0",
                  status: "ongoing");
              Link.createDynamicLink(RestaurantId.toString(), Orderid);
            } else {
              checkkicked(context);
              if (!iscicked) {
                print("there is order ");
                Link.createDynamicLink(
                    RestaurantId.toString(), SharedPrefer.CurrentOrderId);
              }
            }
          },
          icon: Icon(
            Icons.ios_share_outlined,
            size: 30,
            color: white,
          )),

//       IconButton(
//           onPressed: () async {
//             //////////////////////////////////////////////////////////////

//             notificationServices.getDeviceToken().then((value) async {
//               var data = {
//                 'to':
//                     'esQxgMzimu8fDt2N3dCta1:APA91bGa-i19DmkY_TxcX0miH1pEOO4R6oIE2jZ8z3ISzq8hNqcf2sxp6mK81DDFCBle2OwLg8N3gvJn7UixOheHNCwaP2DeCJKH7Ny10HhT1UXIVxfCoF6djvqGcAEZ_1MiPe5V7p97',
// //value.toString(),
//                 'notification': {
//                   'title': 'new order',
//                   'body': 'a new order is here! please check it',
//                 },
//                 'android': {
//                   'notification': {
//                     'notification_count': 23,
//                   },
//                 },
//                 'data': {'type': 'msj', 'id': 'sadeem'}
//               };

//               await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
//                   body: jsonEncode(data),
//                   headers: {
//                     'Content-Type': 'application/json; charset=UTF-8',
//                     'Authorization':
//                         'key=AAAAUqI5GM4:APA91bH3bpkC5icX3sgdIjtGj-cbO6wgQBbvZW5nE-N-GBv5OqjCNYqhvvEL6bZYvs6dNtMJFmibFXe2mOF7FLz7P71ddZyuIIZFysr9-qqPp0q8hoZAnXC2t8j6ARltVRHTPnk3szMz'
//                   }).then((value) {
//                 if (kDebugMode) {
//                   print(value.body.toString());
//                 }
//               }).onError((error, stackTrace) {
//                 if (kDebugMode) {
//                   print(error);
//                 }
//               });
//             });
//           },
//           icon: Icon(Icons.abc_outlined))
//  //////////////////////////////////////////////////////////////////////////

      // IconButton(
      //   onPressed: () {
      //     // payment obj = new payment();
      //     // var total = 2378 ;
      //     // obj.makePayment(total);
      //   //   checkkicked(context);
      //   //     if (!iscicked)
      //   //  { Navigator.push(
      //   //     context,
      //   //     MaterialPageRoute(
      //   //       builder: (context) => CCurrentOrder(),
      //   //     ),
      //   //   );}
      //   },
      //   icon: Icon(Icons.shopping_cart_outlined, color: white, size: 30),
      // )
    ];
    print("nummmm " + _newOAmount.toString());
    return Scaffold(
        appBar: CustomAppBar(
          actions: actions,// SharedPrefer.iscreator != null
          wantback:( SharedPrefer.CurrentOrderId == null ||SharedPrefer.CurrentOrderId == "" ) ?  true : SharedPrefer.iscreator ,
        ),
        floatingActionButton: !(SharedPrefer.CurrentOrderId == null ||
                SharedPrefer.CurrentOrderId == "")
            ? FloatingActionButton(
                backgroundColor: Batatis_Dark,
                child: 
                badges.Badge(
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Color.fromARGB(255, 243, 33, 33),
                  ),
                  position: badges.BadgePosition.topEnd(top: -26, end: -20),
                  badgeContent: Text( _newOAmount.toString(),
                    style: TextStyle(color: Colors.white),
                    
                  ),
              child:
                   Icon(Icons.shopping_cart_outlined,color: white, size: 30),
             
                 ),
                onPressed: () {
                //  CCurrentOrderState.getlocation();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CCurrentOrder(),
                    ),
                  );
                },
              )
            : null,
// AppBar(
//     automaticallyImplyLeading: true, // Display the back button
//     backgroundColor: Batatis_Dark,
//     title:// Row(
//       //children: <Widget>[
//         Image.asset(
//           'assets/Images/Batatis_logo.jpeg',
//           width: 140,
//           height: 130,
//         ),

//         /*
//         SizedBox(width: 110.0),
//         Image.asset(
//           'assets/Images/groupOrder.png',
//           width: 70,
//           height: 70,
//         ),
// */

//     //  ],
//     ),

        body:
//        StreamBuilder(

//         stream: FirebaseFirestore.instance
//             .collection('Restaurants')
//             .doc(resturantID)
//             .collection('menu').snapshots(),
//          builder: (BuildContext context, snapshot){
//           if (snapshot.connectionState == ConnectionState.waiting) { // While data is loading, show a loading indicator.
//             print("wait");
//             return CircularProgressIndicator();
//           }
//           else if (snapshot.hasError) {
//             print("eroorrrrr");// If an error occurs, display an error message.
//             return Text('no data');
//           }

// int counter = 0; // Initialize a counter variable

// if (snapshot.hasData!) {
//   msg = "";
//   print("passs");
//   QuerySnapshot querySnapshot = snapshot.data!;
//   int numberOfElements = querySnapshot.docs.length; // Store the length in a variable
//   print("Number of elements: $numberOfElements"); // Print the number of elements

//   if (querySnapshot != null) {
//     querySnapshot.docs.forEach((DocumentSnapshot doc) async {
//       // print("herererererer" + "/Restaurants/$resturantID/${doc.id}.png");
//       // await PhotoPicker.getimg("/Restaurants/$resturantID/${doc.id}");
//       // // "/Restaurants/$Rid/$Iid"
//       // String url = await PhotoPicker.geturl();

//       // mySet.add(doc);
//       // urls.add(url);
//       // print("real url " + url);

//       // // Increment the counter
//       // counter++;

//       // Check if the counter equals the snapshot length
//       if (counter == numberOfElements) {
//         // Set RestLogoURI to the URL of the logo
//         await PhotoPicker.getimg("/Restaurants/$resturantID/Logo");
//         RestLogoURI = await PhotoPicker.geturl();
//         print("RestLogoURI: $RestLogoURI");

//          ResturantName = await resturantObj.getRestaurantName(resturantID) ?? 'Default Restaurant Name';
//          ResturantAddress = await resturantObj.getRestaurantAddress(resturantID) ?? 'Default Restaurant Address';
//          ResturantStartTime = await resturantObj.getRestaurantStartTime(resturantID) ?? 'Default Restaurant Start time';
//          ResturantEndTime = await resturantObj.getRestaurantEndTime(resturantID) ?? 'Default Restaurant End time';
//          print(ResturantName);
//          print(ResturantAddress);
//          print(ResturantStartTime);
//          print(ResturantEndTime);

//          //  print(ResturantName+" "+ResturantAddress);

//       }
//     });
//   }
//    print("RestLogoURI2: $RestLogoURI");
// }

// At this point, RestLogoURI contains the URL of the logo, and you can use it as needed.

// At this point, RestLogoURI contains the URL of the logo, and you can use it as needed.

//sprinh1,2 as 1 doc
//summery link
//

//else msg = 'no item exit';

//ResturantName=await resturantObj.getRestaurantName(RestLogoURI);
//print(ResturantName);

            isLoggedIn
                ? Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.all(
                                      21.0), // Add margin to all sides of the CachedNetworkImage
                                  child: RestaurantLogo
                                  // CachedNetworkImage(
                                  //   imageUrl: RestLogoURI,
                                  //   width: 180,
                                  //   height: 180,
                                  // ),
                                  ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Align children to the left
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      /*  CustomText(
                                        text: ResturantName ??
                                            'Default Restaurant Name',
                                        type: 'heading', 
                                      ),*/

                                      Text(
                                        ' ' +
                                            '${ResturantName ?? 'Default Restaurant Name'}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),

                                      SizedBox(width: 60.0), //

                                      // Image.asset(
                                      //   'assets/Images/groupOrder.png',
                                      //   width: 70,
                                      //   height: 70,
                                      // ),
                                    ],
                                  ),

                                  /*
                                Row(
                            children: [
                              Icon(Icons.location_on, size: 20),
                              Container(
                                width: 170, // Adjust the width as needed
                                child: CustomText(
                                  text: (distance ?? '') + ' km',
                                  type: 'ResturantInfo',
                                ),
                                alignment: Alignment.bottomLeft,
                              ),
                            ],
                          ),*/

                                  Row(
                                    children: [
                                      Icon(Icons.location_on, size: 20),

                                      CustomText(
                                        text: (distance ?? '') + ' km',
                                        type: 'ResturantInfo',
                                      ),
                                      SizedBox(
                                          width:
                                              17), // Add spacing between the two sections
                                      Row(
                                        children: [
                                          Icon(Icons.delivery_dining_sharp,
                                              size: 20),
                                          CustomText(
                                            text: " " +
                                                (ResturantFee ?? ' ') +
                                                ' SR',
                                            type: "ResturantInfo",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                      height:
                                          4), // Add spacing between the two sections

                                  //heading, Subheading1B, Subheading2
                                  Row(
                                    children: [
                                      SizedBox(
                                          height:
                                              10.0), // Add any desired spacing
                                      Icon(Icons.access_time, size: 20),
                                      CustomText(
                                        text: " " +
                                            (ResturantStartTime ??
                                                'Default Restaurant Start time') +
                                            " - " +
                                            (ResturantEndTime ??
                                                'Default Restaurant End time'),
                                        type: 'ResturantInfo',
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),

/*
                  Row(
                    children: [
                      Icon(Icons.delivery_dining_sharp, size: 20),
                      CustomText(
                        text:
                            (ResturantFee ?? 'Default Restaurant Fee') +
                            ' SR',
                        type: "ResturantInfo",
                      ),
                    ],
                  ),*/

                                  CustomText(
                                    text: Resturantstatus,
                                    type: Resturantstatus,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left:
                                  4.0), // Add left padding before "Restaurant Menu" text
                          /*  child: Row(
                            children: <Widget>[
                              CustomText(
                                text: "Restaurant Menu:",
                                type: "heading",
                              ),
                            ],
                          ),*/
                        ),
                        // SizedBox(height: 0), //space btw resturant info and menu
                        Expanded(
                          child: SingleChildScrollView(
                            //scrollDirection: Axis.horizontal,
                            child: Wrap(
                              children: cards(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator()));

/*


          return  SingleChildScrollView(
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                //  child:  Center(
                      child: Container(
                          width: 405, //150 // width of the screen container
                       //   height: 150,
                       margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5), //space from screen to logo and menu cards

                      child: Column(


                          children: [
         Container(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start, // Aligns children to the start of the row
    children: [
      Container(
        child: CachedNetworkImage(
          imageUrl: RestLogoURI,
          width: 150,
          height: 150,
        ),
      ),
      SizedBox(width: 5.0), // Add some space between the logo and resturant info
      Container(
          width: 250,
          height: 150,

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
          children: [       
            SizedBox(height: 60.0), 
            CustomText( text: ResturantName ?? 'Default Restaurant Name', type: 'Subheading2'), // Provide a default value or placeholder
            CustomText( text: ResturantAddress ?? 'Default Restaurant Address', type: "Subheading2"), // Provide a default value or placeholder
             Row(
                children: [
                  CustomText( text: "Opens: ", type: "Subheading2"),
             CustomText( text: ResturantStartTime ?? 'Default Restaurant Start time', type: "Subheading2"), // Provide a default value or placeholder
              CustomText( text: "  Closes: ", type: "Subheading2"),
            CustomText(text: ResturantEndTime ?? 'Default Restaurant End time', type: "Subheading2"), // Provide a default value or placeholder
                ],
             ),

          ],
        ),
      ),
    ],
  ),
),


    Container(
              //margin: EdgeInsets.all(3.4), // Adjust the margin as needed
              child: Column(

                children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomText(
                          text: "Restaurant Menu",
                          type: "heading",
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    children: cards(),
                  ),
                ],
              ),
            ),



              
              ],
                  //  ),
                ),
             ),
            ),
          );

          */
  } //,

  // ),
  static bool iscicked = false;
  static void checkkicked(context) async {
    if (!(SharedPrefer.CurrentOrderId == null ||
            SharedPrefer.CurrentOrderId == "") &&
        !SharedPrefer.iscreator!) {
      var LMembers = await FirebaseFirestore.instance
          .collection("Orders/${SharedPrefer.CurrentOrderId}/Member")
          .get();
      iscicked = LMembers.docs
                  .toList()
                  .indexWhere((element) => element.id == SharedPrefer.UserId) ==
              -1
          ? true
          : false;

      print("this got cicked  $iscicked ");
      if (iscicked) {
        print("you been kicked you been kicked ");
        SharedPrefer.DeleteCurrentOrder();
        showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                type: "reject",
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CHomePage()));
                },
                text: "the creator removed you from the group order ",
                action: null,
              );
            });
      }
    }
  }
  // );
} //build

// //}//ViewMenuToCustomerState with SingleTickerProviderStateMixin

// /*
//     return Scaffold(
//       body: Center(
//         child: CustomText(text: resturantID, type: 'paragraph'),
//       ),
//     );*/
//                 children: [
//                   Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: CustomText(
//                           text: "Restaurant Menu",
//                           type: "heading",
//                         ),
//                       ),
//                     ],
//                   ),
//                   Wrap(
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     children: cards(),
//                   ),
//                 ],
//               ),
//             ),



              
//               ],
//                   //  ),
//                 ),
//              ),
//             ),
//           );

          
//   } //,

//   // ),
//   static bool iscicked = false;
//   static void checkkicked(context) async {
//     if (!(SharedPrefer.CurrentOrderId == null ||
//             SharedPrefer.CurrentOrderId == "") &&
//         !SharedPrefer.iscreator!) {
//       var LMembers = await FirebaseFirestore.instance
//           .collection("Orders/${SharedPrefer.CurrentOrderId}/Member")
//           .get();
//       iscicked = LMembers.docs
//                   .toList()
//                   .indexWhere((element) => element.id == SharedPrefer.UserId) ==
//               -1
//           ? true
//           : false;

//       print("this got cicked  $iscicked ");
//       if (iscicked) {
//         print("you been kicked you been kicked ");
//         SharedPrefer.DeleteCurrentOrder();
//         showDialog(
//             context: context,
//             builder: (context) {
//               return CustomDialog(
//                 type: "reject",
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Navigator.pop(context);
//                   Navigator.pop(context);
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const CHomePage()));
//                 },
//                 text: "the creator removed you from the group order ",
//                 action: null,
//               );
//             });
//       }
//     }
//   }
//   // );
// } //build

// //}//ViewMenuToCustomerState with SingleTickerProviderStateMixin

// /*
//     return Scaffold(
//       body: Center(
//         child: CustomText(text: resturantID, type: 'paragraph'),
//       ),
//     );*/
