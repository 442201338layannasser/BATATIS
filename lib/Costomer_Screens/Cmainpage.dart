import 'dart:async';

import 'package:batatis/Costomer_Screens/waitingPage.dart';
import 'package:batatis/main.dart';

import 'package:batatis/provider/auth_provider.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';
//import 'package:shimmer/shimmer.dart';
import '../Views/Customer_View.dart';
import '/Customer_Widgets/All_customer_Widgets.dart';

import 'package:batatis/Costomer_Screens/All_Costomer_Screens.dart';

import '/Routes.dart';

class Cmainpage extends StatefulWidget {
  const Cmainpage({super.key});

  @override
  State<Cmainpage> createState() => CmainpageState();
}

Map<DocumentSnapshot, double> listOfRestaurantsByNearby = {};
List<Widget> listRestaurantCards = [];

class CmainpageState extends State<Cmainpage>
    with SingleTickerProviderStateMixin {
  String selectedCategory = "All"; // Default category

  void changeCategory(String newCategory) {
    setState(() {
      selectedCategory = newCategory;
    });
  }

  //late TabController _tabController= TabController(length: 2, vsync: this);

  late TabController _tabController;

  static late StateSetter state;

  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    loadData(); // Load data when the widget is initialized
// startCount();
  }

  // void startCount() {
  //   Timer.periodic(Duration(seconds: 1), (timer) {
  //     count++;
  //     //print("timer cmainpage $count");
  //     if (count >= 60) {
  //       setState(() {
  //         //update the page every 100 sec
  //         loadData();
  //         print("timerrr orders $count");
  //         count = 0; // await Reset the count after 10 seconds.
  //       });
  //     }
  //   });
  // }

  static var name = "";

  var ap; // Service provider auth with DB info

  bool isLoggedIn = true ;//false; // Check if the user is logged in

  List<DocumentSnapshot> listOfRestaurants = [];

  // Map<DocumentSnapshot, double> listOfRestaurantsByNearby = {};

  static Map<DocumentSnapshot, double> listofnearby = {};

  //List<Widget> listRestaurantCards = [];

  Map<String, Widget> listOfRestaurantImages = {};

  Map<String, BitmapDescriptor> listOfRestaurantBitmaps = {};

  Set<Marker> restaurantsMarkers = {};
  Widget SecondBody = Center(
      child:
          CircularProgressIndicator()); // Variable to change the body accordingly
  static bool isOkay = true; //false;

  double UserLat = 24.7659730389634;

  double UserLong = 46.790996402014;

  Future<void> loadData() async {
    ap = Provider.of<AuthProvider>(context, listen: false);

    print("data loading");

    state = setState;

    try {
      SharedPrefer.SetSharedPrefer();
      isLoggedIn = SharedPrefer.Islogin! ;  //await ap.issignedin;

      if (isLoggedIn) {
        if (SharedPrefer.UserAddress == "" ||
            SharedPrefer.UserAddress == null) {
          print("no location yet");

          isOkay = false;

          setState(() {
            SecondBody = Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Icon(
                    Icons.pin_drop,
                    size: 100,
                    color: grey_Dark,
                  ),
                  Text(
                    "Please select your delivery location ",
                    style: TextStyle(fontSize: 15),
                  ),
                ]));
          });

          print(
              "ssssssssssssseeeeeeeeeeeeeeeeettttttttttttttt iffffffffffffffff");
        } else {
          print("there is location ");

          await fetchRestaurantsData();

          await loadRestaurantImages();

          UserLat = double.parse(SharedPrefer.UserLat.toString());

          UserLong = double.parse(SharedPrefer.UserLong.toString());

          listOfRestaurantsByNearby = await LocationPickerState.getnearby(
              UserLat, UserLong, listOfRestaurants);

          listofnearby = listOfRestaurantsByNearby ; //
          print("listOfRestaurantsByNearbylistOfRestaurantsByNearbylistOfRestaurantsByNearby${listofnearby.keys.toList()}");
          listOfRestaurantsByNearby =await ListOfRestaurantWithMenu(listofnearby);
          print("listnearby ${listofnearby.length}"); 
          listofnearby = listOfRestaurantsByNearby ;
          isOkay = true;

          setState(() {
            GenrateResturansCards();

            print("list of rest");

            print(listOfRestaurants);

            restaurantsMarkers = GenrateMarkers(listOfRestaurantsByNearby.keys.toList());
          });
        }
      } else {print("u not loged in "); }//To-DO handle is user not loged in
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchRestaurantsData() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Restaurants') 
       // .where('menu', isNotEqualTo: null)
        .get();
    
    listOfRestaurants = querySnapshot.docs.toList();
print("boohoo menue " );
    // Additional data processing and calculations can be performed here
  }

  Future<void> loadRestaurantImages() async {
    for (final doc in listOfRestaurants) {
      final String restaurantId = doc.id;

      final String imagePath = "/Restaurants/$restaurantId/Logo";

      await PhotoPicker.getimg(imagePath);

      final String imageUrl = await PhotoPicker.geturl();

      listOfRestaurantImages[restaurantId] = Padding(
        padding: EdgeInsets.all(0),
        child: ClipRRect(
            borderRadius:
                BorderRadius.circular(20), // Set the border radius here

            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 87,
              height: 70,
            )),
      );

      await PhotoPicker.getBytes(imagePath);

      final bytes = await PhotoPicker.getbytes();

      final BitmapDescriptor bitmapPic =
          await convertImageFileToCustomBitmapDescriptor(
        bytes,
        title: doc.get("Resturant Name"),
      );

      listOfRestaurantBitmaps[restaurantId] = bitmapPic;
    }
  }

// SecondBody = Shimmer.fromColors(
//                 baseColor: grey_Dark , // Colors.grey[300],
//                 highlightColor: Colors.white,
//                 period: Duration(milliseconds: timer),
//                 child: Container(),
  @override
  Widget build(BuildContext context) {
    Link.handleDynamicLinks(context);

    List<Widget> AppBarActions = [
      //if u want anaction to be add to the app bar add it here

      IconButton(
        onPressed: () {
          showDialog<String>(
              context: context,
              builder: (context) {
                return UserLocationDialog();
              });
        },
        icon: const Icon(Icons.pin_drop),
      ),  
    ];
    print("is okay $isOkay is logedin $isLoggedIn");
    return Scaffold(
        appBar: CustomAppBar(actions: AppBarActions),
        body: (isOkay && isLoggedIn)
            ? Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    labelColor: Batatis_Dark,
                    unselectedLabelColor: grey_Dark,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.all(5.0),
                    tabs: [
                      Tab(
                        text: "Restaurants List",
                        icon: Icon(Icons.list_alt_outlined),
                      ),
                      Tab(
                        text: "Restaurants Map",
                        icon: Icon(Icons.map_outlined),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        /*

                        SingleChildScrollView(

                            child: Container(

                           

                          child: Column(

                         

                                  listRestaurantCards

                               

                              //   : [Center(child: Text("your location is not supoorted "),)]

                              ),

                        )),*/
       Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 7.0), // Add the desired top padding
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width: 5),
                                    buildCategoryButton("All",
                                        isSelected: selectedCategory == "All"),
                                    SizedBox(
                                        width:
                                            5), // Adjust the width to your desired spacing
                                    buildCategoryButton("Burgers",
                                        isSelected:
                                            selectedCategory == "Burgers"),
                                    SizedBox(width: 5),
                                    buildCategoryButton("Pizza",
                                        isSelected:
                                            selectedCategory == "Pizza"),
                                    SizedBox(width: 5),
                                    buildCategoryButton("Sandwitches",
                                        isSelected:
                                            selectedCategory == "Sandwitches"),
                                    SizedBox(width: 5),
                                    buildCategoryButton("Coffee&Sweets",
                                        isSelected: selectedCategory ==
                                            "Coffee&Sweets"),
                                    SizedBox(width: 5),
                                    buildCategoryButton("Juices",
                                        isSelected:
                                            selectedCategory == "Juices"),
                                    SizedBox(width: 5),
                                    buildCategoryButton("Bakery",
                                        isSelected:
                                            selectedCategory == "Bakery"),
                                    SizedBox(width: 5),
                                    buildCategoryButton("Other",
                                        isSelected:
                                            selectedCategory == "Other"),
                                  ],
                                ),
                              ),
                            ),
                            // Content based on the selected category
                            Expanded(
                              child: buildCategoryContent(selectedCategory),
                            ),
                          ],
                        ),

                        //   ),

                        Center(
                          child: LocationPicker(
                            width: 400.0,
                            height: 575.0,
                            markers: restaurantsMarkers,
                            selfPin: 0.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ) //)
            : SecondBody //Center (child:CircularProgressIndicator() ) ,//secondbody

        );
  }

  // Future<void> islog() async {
  //   isLoggedIn = await ap.issignedin;
  // }

  void GenrateResturansCards() {
    listRestaurantCards = [
      SizedBox(
        height: 20,
      )
    ];
 
    listOfRestaurantsByNearby.forEach((key, value) {
      var Resturantstatus = "";

      var isopened = LocationPickerState.getopenedclosed(
          key.get("StartTime")!, key.get("EndTime")!);

      if (isopened) {
        Resturantstatus = "Opened";
      } else {
        Resturantstatus = "Closed";
      }

      if (selectedCategory == "All") {
        listRestaurantCards.add(
          ResCard(
              RestaurantId: key.id,
              name: key.get("Resturant Name"),
              distence: value.toString(),
              Fee: key.get("Fee"),
              StartTime: key.get("StartTime"),
              EndTime: key.get("EndTime"),
              status: Resturantstatus,
              img: listOfRestaurantImages[key.id]),
        );
      } else {
        if (key.get("Resturant Type") == selectedCategory) {
          listRestaurantCards.add(
            ResCard(
                RestaurantId: key.id,
                name: key.get("Resturant Name"),
                distence: value.toString(),
                Fee: key.get("Fee"),
                StartTime: key.get("StartTime"),
                EndTime: key.get("EndTime"),
                status: Resturantstatus,
                img: listOfRestaurantImages[key.id]),
          );
        }
      }
    });
    print("finshedGenrateResturansCards $isOkay ");
   
  }

  Set<Marker> GenrateMarkers(List<DocumentSnapshot> Resturants) {
    Set<Marker> markers = {};

    print("GenrateMarkers");

    Resturants.forEach((element) {
      print(element.data().toString());

      final double? latitude = double.parse(element.get("Lat"));

      final double? longitude = double.parse(element.get("Long"));

      String ResturantName = element.get("Resturant Name");

      String RestaurantId = element.id;

      markers.add(Marker(
          markerId: MarkerId(RestaurantId),
          position: LatLng(latitude!, longitude!),
          infoWindow: InfoWindow(
            title: "  click to go to $ResturantName ",
            onTap: () {
              print("marker clicked");

              ViewMenuToCustomerState.RestaurantId = RestaurantId;

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewMenuToCustomer(),
                ),
              );
            },
          ),
          icon: listOfRestaurantBitmaps[element.id]!));
    });

    return markers;
  }

  Widget buildCategoryButton(String category, {bool isSelected = false}) {
    String wPath = "$category" + "_w.png";

    String bPath = "$category" + "_b.png";

    return TextButton(
      onPressed: () {
        changeCategory(category);
      },
      child: Row(
        children: <Widget>[
          Text(
            category,
            style: TextStyle(
              color: isSelected ? white : Batatis_light, // Text color
            ),
          ),

          SizedBox(width: 5), // Adjust the spacing between icon and text

          if (category != "All")
            Image.asset(
              isSelected ? 'assets/Images/$wPath' : 'assets/Images/$bPath',

              width: 20, // Adjust the width of the icon as needed

              height: 20, // Adjust the height of the icon as needed
            ),
        ],
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return isSelected ? Batatis_light : white; // Pressed state
          }

          return isSelected ? Batatis_light : white; // Default state
        }),
        side: MaterialStateProperty.all(
          BorderSide(
            color: Batatis_light, // Border color

            width: 1.0, // Border width
          ),
        ),
      ),
    );
  }

  Widget buildCategoryContent(String category) {
    GenrateResturansCards();

    bool onlySizedBoxes = listRestaurantCards
        .every((widget) => widget is SizedBox && widget.height == 20.0);

    if (onlySizedBoxes) {
      return Center(
        child: Text("No available restaurants in this category."),
      );
    }

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: listRestaurantCards,
        ),
      ),
    );
  }
  
  Future<Map<DocumentSnapshot<Object?>, double>> ListOfRestaurantWithMenu(Map<DocumentSnapshot<Object?>, double> listOfRestaurantsByNearby) async {
 print("ListOfRestaurantWithMenu");
    Map<DocumentSnapshot<Object?>, double> ListOfRestaurantWithMenu = {};
 print("ListOfRestaurantWithMenu2");
 print("ListOfRestaurantWithMenu${listofnearby.keys.toList()}");

var i = 0 ;
    for(DocumentSnapshot<Object?> doc in listofnearby.keys.toList() ){
 print("ListOfRestaurantWithMenu3");

      print("ListOfRestaurantWithMenu id ${doc.id}");
     
  // for (QueryDocumentSnapshot restaurantDoc in querySnapshot.docs) {
    // Get the document ID of the restaurant
    String restaurantId = doc.id;

    // Reference to the "menu" subcollection
    CollectionReference menuCollection =
        FirebaseFirestore.instance.collection('Restaurants/$restaurantId/menu');

    // Fetch the documents from the "menu" subcollection
    QuerySnapshot menuSnapshot = await menuCollection.get();

    // Check if the "menu" subcollection exists
    if (menuSnapshot.docs.isNotEmpty) {
      print("id ${doc.id}");
      // The restaurant has a "menu" subcollection, you can use restaurantDoc as needed
      print('Restaurant ${doc.data()} has a "menu" subcollection.');
      ListOfRestaurantWithMenu[doc] = listofnearby.values.toList()[i] ; 
  
    }
    i = i+1 ;
  }
  setState(() {
    listofnearby = ListOfRestaurantWithMenu ; 
  });
  
        return ListOfRestaurantWithMenu ;   
    }


 // }
}
