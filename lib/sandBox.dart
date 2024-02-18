// // // // // // // // // // // //       import 'package:flutter/material.dart';
// // // // // // // // // // // // import 'package:geolocator/geolocator.dart';
// // // // // // // // // // // //       import 'package:google_maps_flutter/google_maps_flutter.dart';
      
// // // // // // // // // // // //       void main() => runApp( MyApp());
      
// // // // // // // // // // // //       class MyApp extends StatefulWidget {
// // // // // // // // // // // //        LatLng? value; 
// // // // // // // // // // // //         MyApp({Key? key,}) : super(key: key);
          

// // // // // // // // // // // //         //LatLng? value; 
// // // // // // // // // // // //         @override
// // // // // // // // // // // //         State<MyApp> createState() => _MyAppState();
// // // // // // // // // // // //       }
      
// // // // // // // // // // // //       class _MyAppState extends State<MyApp> {
// // // // // // // // // // // //         late GoogleMapController mapController;
      
// // // // // // // // // // // //         //final LatLng _center = const LatLng(-33.86, 151.20);
      
// // // // // // // // // // // //         void _onMapCreated(GoogleMapController controller) {
// // // // // // // // // // // //          print(("creating ")); 
// // // // // // // // // // // //           mapController = controller;
// // // // // // // // // // // //                      //  controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(24.72573904236955, 46.626756471630195),14.5));

// // // // // // // // // // // //         }
     
// // // // // // // // // // // //         @override
// // // // // // // // // // // //         Widget build(BuildContext context) {
// // // // // // // // // // // //           return MaterialApp(
// // // // // // // // // // // //             home: Scaffold(
// // // // // // // // // // // //               appBar: AppBar(
// // // // // // // // // // // //                 title: const Text('Maps Sample App'),
// // // // // // // // // // // //                 backgroundColor: Colors.green[700],
// // // // // // // // // // // //               ),
// // // // // // // // // // // //               body:
// // // // // // // // // // // //                  Center(
// // // // // // // // // // // //       child : Column(children: [ 
       
// // // // // // // // // // // //        SizedBox(
// // // // // // // // // // // //         height: 300,
// // // // // // // // // // // //         width: 250,
// // // // // // // // // // // //         child: LayoutBuilder(
// // // // // // // // // // // //           builder: (context, constraints) {
// // // // // // // // // // // //             var maxWidth = constraints.biggest.width;
// // // // // // // // // // // //             var maxHeight = constraints.biggest.height;

// // // // // // // // // // // //             return Stack(
// // // // // // // // // // // //               children: <Widget>[
              
// // // // // // // // // // // //                 SizedBox(
// // // // // // // // // // // //                   width: maxWidth,
// // // // // // // // // // // //                   child: GoogleMap(
// // // // // // // // // // // //                 //     onTap: (n) {  
// // // // // // // // // // // //                 //       print("on tap");
// // // // // // // // // // // //                 //        con.animateCamera(CameraUpdate.newLatLngZoom(LatLng(24.3212, 46.765434),1));
// // // // // // // // // // // //                 //       print("on tap after ");
                
// // // // // // // // // // // //                 // },
// // // // // // // // // // // //                     initialCameraPosition: CameraPosition(
// // // // // // // // // // // //                       target: LatLng(24.72573904236955, 46.626756471630195),
// // // // // // // // // // // //                       zoom: 14.5,
// // // // // // // // // // // //                     ),
// // // // // // // // // // // //                     onMapCreated: _onMapCreated,
// // // // // // // // // // // //                 //     (controller) {
// // // // // // // // // // // //                 //       // _controller.complete(controller as FutureOr<webGM.GoogleMapController>?);
// // // // // // // // // // // //                 //       // con = controller ; 
// // // // // // // // // // // //                 //       // print("on create " + con.toString() 
// // // // // // // // // // // //                 //       // );
// // // // // // // // // // // //                 // _onMapCreated(); 
// // // // // // // // // // // //                 //     },
// // // // // // // // // // // //                     onCameraMove: (CameraPosition newPosition) {
// // // // // // // // // // // //                     widget.value = newPosition.target;
                 
// // // // // // // // // // // //                   //    bool flag = true ; 
// // // // // // // // // // // //                   //     if(pos !=null)
// // // // // // // // // // // //                   // {  print("pos not null !!!!");
// // // // // // // // // // // //                   // flag = false ; 
// // // // // // // // // // // //                   //   widget.value = LatLng(pos!.latitude , pos!.longitude);
// // // // // // // // // // // //                   //   }
// // // // // // // // // // // //                   // else if( flag) widget.value = newPosition.target;
// // // // // // // // // // // //                   //     print("moving");
// // // // // // // // // // // //                   //     setState(() {
// // // // // // // // // // // //                   //     loc = widget.value!.latitude.toString() +"\n"+ widget.value!.longitude .toString() ; 
                        
// // // // // // // // // // // //                   //     });
                      

// // // // // // // // // // // //                     },
// // // // // // // // // // // //                     mapType: MapType.normal,
// // // // // // // // // // // //                     myLocationButtonEnabled: true,
// // // // // // // // // // // //                     myLocationEnabled: true,
// // // // // // // // // // // //                     zoomGesturesEnabled: true,
// // // // // // // // // // // //                     padding: const EdgeInsets.all(0),
// // // // // // // // // // // //                     buildingsEnabled: true,
// // // // // // // // // // // //                     compassEnabled: true,
// // // // // // // // // // // //                     indoorViewEnabled: false,
// // // // // // // // // // // //                     mapToolbarEnabled: true,
// // // // // // // // // // // //                     minMaxZoomPreference: MinMaxZoomPreference.unbounded,
// // // // // // // // // // // //                     rotateGesturesEnabled: true,
// // // // // // // // // // // //                     scrollGesturesEnabled: true,
// // // // // // // // // // // //                     tiltGesturesEnabled: true,
// // // // // // // // // // // //                     trafficEnabled: false,
// // // // // // // // // // // //                   ),
// // // // // // // // // // // //                 ),
// // // // // // // // // // // //                 Positioned(
// // // // // // // // // // // //                   bottom: maxHeight / 2,
// // // // // // // // // // // //                   right: (maxWidth - 30) / 2,
// // // // // // // // // // // //                   child: const Icon(
// // // // // // // // // // // //                     Icons.person_pin_circle,
// // // // // // // // // // // //                     size: 30,
// // // // // // // // // // // //                     color: Colors.black,
// // // // // // // // // // // //                   ),
// // // // // // // // // // // //                 ),
// // // // // // // // // // // //                 Positioned(
// // // // // // // // // // // //                   bottom: 5,
// // // // // // // // // // // //                   left: 5,
// // // // // // // // // // // //                   child: Container(
// // // // // // // // // // // //                     color: Colors.white,
// // // // // // // // // // // //                     child: IconButton(
// // // // // // // // // // // //                       onPressed: () async {
// // // // // // // // // // // //                         print("pressed");
// // // // // // // // // // // //                         await _determinePosition();
// // // // // // // // // // // //                       print("already back ");
// // // // // // // // // // // //                       },
// // // // // // // // // // // //                       icon: const Icon(Icons.my_location),
// // // // // // // // // // // //                     ),
// // // // // // // // // // // //                   ),
// // // // // // // // // // // //                 ),
// // // // // // // // // // // //               ],
// // // // // // // // // // // //             );
// // // // // // // // // // // //           },
// // // // // // // // // // // //         ),
// // // // // // // // // // // //     )]),
// // // // // // // // // // // //     )));
// // // // // // // // // // // //   }





// // // // // // // // // // // // late Position pos ;
// // // // // // // // // // // //   Future<void> _determinePosition() async {
// // // // // // // // // // // //     print("get my loc ");
// // // // // // // // // // // //     try {
// // // // // // // // // // // //       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
// // // // // // // // // // // //       if (!serviceEnabled) {
// // // // // // // // // // // //         throw 'Location services are disabled.';
// // // // // // // // // // // //       }

// // // // // // // // // // // //       LocationPermission permission = await Geolocator.checkPermission();
// // // // // // // // // // // //       if (permission == LocationPermission.denied) {
// // // // // // // // // // // //         permission = await Geolocator.requestPermission();
// // // // // // // // // // // //         if (permission == LocationPermission.denied) {
// // // // // // // // // // // //           throw 'Location permissions are denied.';
// // // // // // // // // // // //         }
// // // // // // // // // // // //       }

// // // // // // // // // // // //       if (permission == LocationPermission.deniedForever) {
// // // // // // // // // // // //         throw 'Location permissions are permanently denied.';
// // // // // // // // // // // //       }

// // // // // // // // // // // //       pos = await Geolocator.getCurrentPosition();
// // // // // // // // // // // //       if (pos != null) {
// // // // // // // // // // // //           widget.value = LatLng(pos!.latitude, pos!.longitude) ; 
// // // // // // // // // // // //         //final GoogleMapController controller = await mapController;
// // // // // // // // // // // //         mapController.moveCamera(
// // // // // // // // // // // //           CameraUpdate.newCameraPosition(
// // // // // // // // // // // //             CameraPosition(
// // // // // // // // // // // //               target: LatLng(pos!.latitude, pos!.longitude),
// // // // // // // // // // // //               zoom: 14.5,
// // // // // // // // // // // //             ),
// // // // // // // // // // // //           ),
// // // // // // // // // // // //         );
// // // // // // // // // // // //       }
// // // // // // // // // // // //     } catch (e) {
// // // // // // // // // // // //       print('Error obtaining location: $e');
// // // // // // // // // // // //     }
// // // // // // // // // // // //   }}
// // // // // // // // // // // //       //     LayoutBuilder(
// // // // // // // // // // // //       //     builder: (context, constraints) {
// // // // // // // // // // // //       //       var maxWidth = constraints.biggest.width;
// // // // // // // // // // // //       //       var maxHeight = constraints.biggest.height;
// // // // // // // // // // // //       //        return  Stack(
// // // // // // // // // // // //       //           children: <Widget>[
// // // // // // // // // // // //       //         Container(
// // // // // // // // // // // //       //           height: 350 ,
// // // // // // // // // // // //       //           width: 400 ,
// // // // // // // // // // // //       //           child: GoogleMap(
// // // // // // // // // // // //       //           onMapCreated: _onMapCreated,
// // // // // // // // // // // //       //           initialCameraPosition: CameraPosition(
// // // // // // // // // // // //       //             target: LatLng(24.72573904236955, 46.626756471630195),
// // // // // // // // // // // //       //             zoom: 14.5,
// // // // // // // // // // // //       //           ),
              
// // // // // // // // // // // //       //         onCameraMove: (CameraPosition newPosition) {
// // // // // // // // // // // //       //          // widget.value = newPosition.target;
// // // // // // // // // // // //       //         print("moving");
// // // // // // // // // // // //       //         }
              
// // // // // // // // // // // //       //         ),
// // // // // // // // // // // //       //         ),
// // // // // // // // // // // //       //         Positioned(
// // // // // // // // // // // //       //             bottom: maxHeight / 2,
// // // // // // // // // // // //       //             right: (maxWidth - 30) / 2,
// // // // // // // // // // // //       //             child: const Icon(
// // // // // // // // // // // //       //               Icons.person_pin_circle,
// // // // // // // // // // // //       //               size: 300,
// // // // // // // // // // // //       //               color: Colors.black,
// // // // // // // // // // // //       //             ),
// // // // // // // // // // // //       //           ),
              
              
// // // // // // // // // // // //       //         ]);  }),
// // // // // // // // // // // //       //   )); } //);
// // // // // // // // // // // //       //   }
// // // // // // // // // // // //       // //}

// // // // // // // // // // //         import 'package:flutter/material.dart';
// // // // // // // // // // // import 'package:geocoding/geocoding.dart';

// // // // // // // // // // // void main() {
// // // // // // // // // // //   runApp(MyApp());
// // // // // // // // // // // }

// // // // // // // // // // // class MyApp extends StatelessWidget {
// // // // // // // // // // //   @override
// // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // //     return MaterialApp(
// // // // // // // // // // //       home: MyHomePage(),
// // // // // // // // // // //     );
// // // // // // // // // // //   }
// // // // // // // // // // // }

// // // // // // // // // // // class MyHomePage extends StatelessWidget {
// // // // // // // // // // //   @override
// // // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // // //     return Scaffold(
// // // // // // // // // // //       appBar: AppBar(
// // // // // // // // // // //         title: Text('i am pteto ash branch '),
// // // // // // // // // // //       ),
// // // // // // // // // // //       body: Center(
// // // // // // // // // // //         child: ElevatedButton(
// // // // // // // // // // //           onPressed: () async {
// // // // // // // // // // //             await getadd();
// // // // // // // // // // //           },
// // // // // // // // // // //           child: Text('Get Address'),
// // // // // // // // // // //         ),
// // // // // // // // // // //       ),
// // // // // // // // // // //     );
// // // // // // // // // // //   }
// // // // // // // // // // // }

// // // // // // // // // // // Future<void> getadd() async {
// // // // // // // // // // //   try {
// // // // // // // // // // //     List<Placemark> placemarks = await placemarkFromCoordinates(45, 24);
// // // // // // // // // // //     String placename =
// // // // // // // // // // //         placemarks.first.administrativeArea.toString() + ", " + placemarks.first.street.toString();
// // // // // // // // // // //     print("placename: " + placename);
// // // // // // // // // // //   } catch (e) {
// // // // // // // // // // //     print("Error getting address: $e");
// // // // // // // // // // //   }
// // // // // // // // // // // }
// // // // // // // // // // import 'package:batatis/Customer_Widgets/CLocationPicker.dart';
// // // // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // // // import 'package:google_maps_flutter/google_maps_flutter.dart';

// // // // // // // // // // void main() => runApp(const MyApp());

// // // // // // // // // // class MyApp extends StatefulWidget {
// // // // // // // // // //   const MyApp({super.key});

// // // // // // // // // //   @override
// // // // // // // // // //   State<MyApp> createState() => _MyAppState();
// // // // // // // // // // }

// // // // // // // // // // class _MyAppState extends State<MyApp> {
// // // // // // // // // //   late GoogleMapController mapController;

// // // // // // // // // //   final LatLng _center = const LatLng(45.521563, -122.677433);

// // // // // // // // // //   void _onMapCreated(GoogleMapController controller) {
// // // // // // // // // //     mapController = controller;
// // // // // // // // // //   }
// // // // // // // // // // Set<Marker> m = {} ; 
// // // // // // // // // //   @override
// // // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // // //     return MaterialApp(
// // // // // // // // // //       theme: ThemeData(
// // // // // // // // // //         useMaterial3: true,
// // // // // // // // // //         colorSchemeSeed: Colors.green[700],
// // // // // // // // // //       ),
// // // // // // // // // //       home: Scaffold(
// // // // // // // // // //         appBar: AppBar(
// // // // // // // // // //           title: const Text('Maps Sample App'),
// // // // // // // // // //           elevation: 2,
// // // // // // // // // //         ),
// // // // // // // // // //         body: 
// // // // // // // // // //         LocationPicker(width: 300.0,height: 200.0, markers: m,)
// // // // // // // // // //         //GoogleMap(
// // // // // // // // // //         //   onMapCreated: _onMapCreated,
// // // // // // // // // //         //   initialCameraPosition: CameraPosition(
// // // // // // // // // //         //     target: _center,
// // // // // // // // // //         //     zoom: 11.0,
// // // // // // // // // //         //   ),
// // // // // // // // // //         // ),
// // // // // // // // // //       ),
// // // // // // // // // //     );
// // // // // // // // // //   }
// // // // // // // // // // }
// // // // // // // // // import 'package:flutter/material.dart';

// // // // // // // // // void main() => runApp(MyApp());

// // // // // // // // // class MyApp extends StatelessWidget {
// // // // // // // // //   @override
// // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // //     return MaterialApp(
// // // // // // // // //       home: MyHomePage(),
// // // // // // // // //     );
// // // // // // // // //   }
// // // // // // // // // }

// // // // // // // // // class MyHomePage extends StatefulWidget {
// // // // // // // // //   @override
// // // // // // // // //   _MyHomePageState createState() => _MyHomePageState();
// // // // // // // // // }

// // // // // // // // // class _MyHomePageState extends State<MyHomePage> {
// // // // // // // // //   int _selectedIndex = 0;

// // // // // // // // //   void _onItemTapped(int index) {
// // // // // // // // //     setState(() {
// // // // // // // // //       _selectedIndex = index;
// // // // // // // // //     });
// // // // // // // // //   }

// // // // // // // // //   @override
// // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // //     return Scaffold(
// // // // // // // // //       appBar: AppBar(
// // // // // // // // //         title: Text('Bottom Navigation Demo'),
// // // // // // // // //       ),
// // // // // // // // //       body: IndexedStack(
// // // // // // // // //         index: _selectedIndex,
// // // // // // // // //         children: <Widget>[
// // // // // // // // //           // Tab 1 View
// // // // // // // // //           ListView(
// // // // // // // // //             children: <Widget>[
// // // // // // // // //               ListTile(title: Text('Item 1')),
// // // // // // // // //               ListTile(title: Text('Item 2')),
// // // // // // // // //               ListTile(title: Text('Item 3')),
// // // // // // // // //               // Add more widgets as needed
// // // // // // // // //             ],
// // // // // // // // //           ),
// // // // // // // // //           // Tab 2 View
// // // // // // // // //           GridView.count(
// // // // // // // // //             crossAxisCount: 2,
// // // // // // // // //             children: <Widget>[
// // // // // // // // //               Card(
// // // // // // // // //                 child: Center(child: Text('Grid Item 1')),
// // // // // // // // //               ),
// // // // // // // // //               Card(
// // // // // // // // //                 child: Center(child: Text('Grid Item 2')),
// // // // // // // // //               ),
// // // // // // // // //               Card(
// // // // // // // // //                 child: Center(child: Text('Grid Item 3')),
// // // // // // // // //               ),
// // // // // // // // //               // Add more grid items as needed
// // // // // // // // //             ],
// // // // // // // // //           ),
// // // // // // // // //         ],
// // // // // // // // //       ),
// // // // // // // // //       bottomNavigationBar: BottomNavigationBar(
// // // // // // // // //         items: const <BottomNavigationBarItem>[
// // // // // // // // //           BottomNavigationBarItem(
// // // // // // // // //             icon: Icon(Icons.home),
// // // // // // // // //             label: 'Tab 1',
// // // // // // // // //           ),
// // // // // // // // //           BottomNavigationBarItem(
// // // // // // // // //             icon: Icon(Icons.business),
// // // // // // // // //             label: 'Tab 2',
// // // // // // // // //           ),
// // // // // // // // //         ],
// // // // // // // // //         currentIndex: _selectedIndex,
// // // // // // // // //         selectedItemColor: Colors.blue,
// // // // // // // // //         onTap: _onItemTapped,
// // // // // // // // //       ),
// // // // // // // // //     );
// // // // // // // // //   }
// // // // // // // // // }

// // // // // // // // import 'package:flutter/material.dart';

// // // // // // // // void main() => runApp(new MyApp());

// // // // // // // // class MyApp extends StatelessWidget {
// // // // // // // //   // This widget is the root of your application.
// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     return MaterialApp(
// // // // // // // //       title: 'Flutter Demo',
// // // // // // // //       theme: ThemeData(
// // // // // // // //         primarySwatch: Colors.red,
// // // // // // // //       ),
// // // // // // // //       home: App(),
// // // // // // // //     );
// // // // // // // //   }
// // // // // // // // }

// // // // // // // // enum TabItem { red, green, blue }

// // // // // // // // class App extends StatefulWidget {
// // // // // // // //   @override
// // // // // // // //   State<StatefulWidget> createState() => AppState();
// // // // // // // // }

// // // // // // // // class AppState extends State<App> {

// // // // // // // //   TabItem currentTab = TabItem.red;

// // // // // // // //   void _selectTab(TabItem tabItem) {
// // // // // // // //     setState(() {
// // // // // // // //       currentTab = tabItem;
// // // // // // // //     });
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     return Scaffold(
// // // // // // // //       body: _buildBody(),
// // // // // // // //       bottomNavigationBar: BottomNavigation(
// // // // // // // //         currentTab: currentTab,
// // // // // // // //         onSelectTab: _selectTab,
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }
  
// // // // // // // //   Widget _buildBody() {
// // // // // // // //     // return a widget representing a page
// // // // // // // //   }
// // // // // // // // }Widget _buildBody() {
// // // // // // // //   return Container(
// // // // // // // //     color: TabHelper.color(TabItem.red),
// // // // // // // //     alignment: Alignment.center,
// // // // // // // //     child: FlatButton(
// // // // // // // //       child: Text(
// // // // // // // //         'PUSH',
// // // // // // // //         style: TextStyle(fontSize: 32.0, color: Colors.white),
// // // // // // // //       ),
// // // // // // // //       onPressed: _push,
// // // // // // // //     )
// // // // // // // //   );
// // // // // // // // }

// // // // // // // // void _push() {
// // // // // // // //   Navigator.of(context).push(MaterialPageRoute(
// // // // // // // //     // we'll look at ColorDetailPage later
// // // // // // // //     builder: (context) => ColorDetailPage(
// // // // // // // //       color: TabHelper.color(TabItem.red),
// // // // // // // //       title: TabHelper.description(TabItem.red),
// // // // // // // //     ),
// // // // // // // //   ));
// // // // // // // // }

// // // // // // // // class TabNavigatorRoutes {
// // // // // // // //   static const String root = '/';
// // // // // // // //   static const String detail = '/detail';
// // // // // // // // }

// // // // // // // // class TabNavigator extends StatelessWidget {
// // // // // // // //   TabNavigator({this.navigatorKey, this.tabItem});
// // // // // // // //   final GlobalKey<NavigatorState> navigatorKey;
// // // // // // // //   final TabItem tabItem;

// // // // // // // //   void _push(BuildContext context, {int materialIndex: 500}) {
// // // // // // // //     var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

// // // // // // // //     Navigator.push(
// // // // // // // //         context,
// // // // // // // //         MaterialPageRoute(
// // // // // // // //             builder: (context) =>
// // // // // // // //                 routeBuilders[TabNavigatorRoutes.detail](context)));
// // // // // // // //   }

// // // // // // // //   Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
// // // // // // // //       {int materialIndex: 500}) {
// // // // // // // //     return {
// // // // // // // //       TabNavigatorRoutes.root: (context) => ColorsListPage(
// // // // // // // //             color: TabHelper.color(tabItem),
// // // // // // // //             title: TabHelper.description(tabItem),
// // // // // // // //             onPush: (materialIndex) =>
// // // // // // // //                 _push(context, materialIndex: materialIndex),
// // // // // // // //           ),
// // // // // // // //       TabNavigatorRoutes.detail: (context) => ColorDetailPage(
// // // // // // // //             color: TabHelper.color(tabItem),
// // // // // // // //             title: TabHelper.description(tabItem),
// // // // // // // //             materialIndex: materialIndex,
// // // // // // // //           ),
// // // // // // // //     };
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     var routeBuilders = _routeBuilders(context);

// // // // // // // //     return Navigator(
// // // // // // // //         key: navigatorKey,
// // // // // // // //         initialRoute: TabNavigatorRoutes.root,
// // // // // // // //         onGenerateRoute: (routeSettings) {
// // // // // // // //           return MaterialPageRoute(
// // // // // // // //               builder: (context) => routeBuilders[routeSettings.name](context));
// // // // // // // //         });
// // // // // // // //   }
// // // // // // // // }class ColorsListPage extends StatelessWidget {
// // // // // // // //   ColorsListPage({this.color, this.title, this.onPush});
// // // // // // // //   final MaterialColor color;
// // // // // // // //   final String title;
// // // // // // // //   final ValueChanged<int> onPush;

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     return Scaffold(
// // // // // // // //         appBar: AppBar(
// // // // // // // //           title: Text(
// // // // // // // //             title,
// // // // // // // //           ),
// // // // // // // //           backgroundColor: color,
// // // // // // // //         ),
// // // // // // // //         body: Container(
// // // // // // // //           color: Colors.white,
// // // // // // // //           child: _buildList(),
// // // // // // // //         ));
// // // // // // // //   }

// // // // // // // //   final List<int> materialIndices = [900, 800, 700, 600, 500, 400, 300, 200, 100, 50];

// // // // // // // //   Widget _buildList() {
// // // // // // // //     return ListView.builder(
// // // // // // // //         itemCount: materialIndices.length,
// // // // // // // //         itemBuilder: (BuildContext content, int index) {
// // // // // // // //           int materialIndex = materialIndices[index];
// // // // // // // //           return Container(
// // // // // // // //             color: color[materialIndex],
// // // // // // // //             child: ListTile(
// // // // // // // //               title: Text('$materialIndex', style: TextStyle(fontSize: 24.0)),
// // // // // // // //               trailing: Icon(Icons.chevron_right),
// // // // // // // //               onTap: () => onPush(materialIndex),
// // // // // // // //             ),
// // // // // // // //           );
// // // // // // // //         });
// // // // // // // //   }
// // // // // // // // }class ColorDetailPage extends StatelessWidget {
// // // // // // // //   ColorDetailPage({this.color, this.title, this.materialIndex: 500});
// // // // // // // //   final MaterialColor color;
// // // // // // // //   final String title;
// // // // // // // //   final int materialIndex;

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {

// // // // // // // //     return Scaffold(
// // // // // // // //       appBar: AppBar(
// // // // // // // //         backgroundColor: color,
// // // // // // // //         title: Text(
// // // // // // // //           '$title[$materialIndex]',
// // // // // // // //         ),
// // // // // // // //       ),
// // // // // // // //       body: Container(
// // // // // // // //         color: color[materialIndex],
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }
// // // // // // // // }  final navigatorKey = GlobalKey<NavigatorState>();

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     return Scaffold(
// // // // // // // //       body: TabNavigator(
// // // // // // // //         navigatorKey: navigatorKey,
// // // // // // // //         tabItem: currentTab,
// // // // // // // //       ),
// // // // // // // //       bottomNavigationBar: BottomNavigation(
// // // // // // // //         currentTab: currentTab,
// // // // // // // //         onSelectTab: _selectTab,
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }
// // // // // // // //   class App extends StatefulWidget {
// // // // // // // //   @override
// // // // // // // //   State<StatefulWidget> createState() => AppState();
// // // // // // // // }

// // // // // // // // class AppState extends State<App> {

// // // // // // // //   TabItem currentTab = TabItem.red;
// // // // // // // //   Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
// // // // // // // //     TabItem.red: GlobalKey<NavigatorState>(),
// // // // // // // //     TabItem.green: GlobalKey<NavigatorState>(),
// // // // // // // //     TabItem.blue: GlobalKey<NavigatorState>(),
// // // // // // // //   };

// // // // // // // //   void _selectTab(TabItem tabItem) {
// // // // // // // //     setState(() {
// // // // // // // //       currentTab = tabItem;
// // // // // // // //     });
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     return Scaffold(
// // // // // // // //       body: Stack(children: <Widget>[
// // // // // // // //         _buildOffstageNavigator(TabItem.red),
// // // // // // // //         _buildOffstageNavigator(TabItem.green),
// // // // // // // //         _buildOffstageNavigator(TabItem.blue),
// // // // // // // //       ]),
// // // // // // // //       bottomNavigationBar: BottomNavigation(
// // // // // // // //         currentTab: currentTab,
// // // // // // // //         onSelectTab: _selectTab,
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }

// // // // // // // //   Widget _buildOffstageNavigator(TabItem tabItem) {
// // // // // // // //     return Offstage(
// // // // // // // //       offstage: currentTab != tabItem,
// // // // // // // //       child: TabNavigator(
// // // // // // // //         navigatorKey: navigatorKeys[tabItem],
// // // // // // // //         tabItem: tabItem,
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }
// // // // // // // // }

// // // // // // // //  @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     return WillPopScope(
// // // // // // // //       onWillPop: () async =>
// // // // // // // //           !await navigatorKeys[currentTab].currentState.maybePop(),
// // // // // // // //       child: Scaffold(
// // // // // // // //         body: Stack(children: <Widget>[
// // // // // // // //           _buildOffstageNavigator(TabItem.red),
// // // // // // // //           _buildOffstageNavigator(TabItem.green),
// // // // // // // //           _buildOffstageNavigator(TabItem.blue),
// // // // // // // //         ]),
// // // // // // // //         bottomNavigationBar: BottomNavigation(
// // // // // // // //           currentTab: currentTab,
// // // // // // // //           onSelectTab: _selectTab,
// // // // // // // //         ),
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }
// // // // // // // // // vo
// // // // // // // // //id main() => runApp(MyApp());

// // // // // // // // // class MyApp extends StatelessWidget {
// // // // // // // // //   @override
// // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // //     return MaterialApp(
// // // // // // // // //       home: MyHomePage(),
// // // // // // // // //     );
// // // // // // // // //   }
// // // // // // // // // }

// // // // // // // // // class MyHomePage extends StatefulWidget {
// // // // // // // // //   @override
// // // // // // // // //   _MyHomePageState createState() => _MyHomePageState();
// // // // // // // // // }

// // // // // // // // // class _MyHomePageState extends State<MyHomePage> {
// // // // // // // // //   int _selectedIndex = 0;

// // // // // // // // //   void _onItemTapped(int index) {
// // // // // // // // //     setState(() {
// // // // // // // // //       _selectedIndex = index;
// // // // // // // // //     });
// // // // // // // // //   }

// // // // // // // // //   @override
// // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // //     return Scaffold(
// // // // // // // // //       appBar: AppBar(
// // // // // // // // //         title: Text('Bottom Navigation Demo'),
// // // // // // // // //       ),
// // // // // // // // //       body: _buildBody(_selectedIndex),
// // // // // // // // //       bottomNavigationBar: BottomNavigationBar(
// // // // // // // // //         items: const <BottomNavigationBarItem>[
// // // // // // // // //           BottomNavigationBarItem(
// // // // // // // // //             icon: Icon(Icons.home),
// // // // // // // // //             label: 'Tab 1',
// // // // // // // // //           ),
// // // // // // // // //           BottomNavigationBarItem(
// // // // // // // // //             icon: Icon(Icons.business),
// // // // // // // // //             label: 'Tab 2',
// // // // // // // // //           ),
// // // // // // // // //         ],
// // // // // // // // //         currentIndex: _selectedIndex,
// // // // // // // // //         selectedItemColor: Colors.blue,
// // // // // // // // //         onTap: _onItemTapped,
// // // // // // // // //       ),
// // // // // // // // //     );
// // // // // // // // //   }

// // // // // // // // //   // Function to build the body based on the selected index
// // // // // // // // //   Widget _buildBody(int index) {
// // // // // // // // //     switch (index) {
// // // // // // // // //       case 0:
// // // // // // // // //         // Tab 1 View
// // // // // // // // //         return ListView(
// // // // // // // // //           children: <Widget>[
// // // // // // // // //             ListTile(
// // // // // // // // //               title: Text('Item 1'),
// // // // // // // // //               onTap: () {
// // // // // // // // //                 // Navigate to a new page while keeping the app bar and bottom navigation bar
// // // // // // // // //                 Navigator.of(context).push(
// // // // // // // // //                   MaterialPageRoute(
// // // // // // // // //                     builder: (context) => Item1Page(),
// // // // // // // // //                   ),
// // // // // // // // //                 );
// // // // // // // // //               },
// // // // // // // // //             ),
// // // // // // // // //             ListTile(title: Text('Item 2')),
// // // // // // // // //             ListTile(title: Text('Item 3')),
// // // // // // // // //             // Add more widgets as needed
// // // // // // // // //           ],
// // // // // // // // //         );
// // // // // // // // //       case 1:
// // // // // // // // //         // Tab 2 View
// // // // // // // // //         return GridView.count(
// // // // // // // // //           crossAxisCount: 2,
// // // // // // // // //           children: <Widget>[
// // // // // // // // //             Card(
// // // // // // // // //               child: Center(child: Text('Grid Item 1')),
// // // // // // // // //             ),
// // // // // // // // //             Card(
// // // // // // // // //               child: Center(child: Text('Grid Item 2')),
// // // // // // // // //             ),
// // // // // // // // //             Card(
// // // // // // // // //               child: Center(child: Text('Grid Item 3')),
// // // // // // // // //             ),
// // // // // // // // //             // Add more grid items as needed
// // // // // // // // //           ],
// // // // // // // // //         );
// // // // // // // // //       default:
// // // // // // // // //         return Container(); // Return an empty container for unsupported index
// // // // // // // // //     }
// // // // // // // // //   }
// // // // // // // // // }

// // // // // // // // // // Page for Item 1
// // // // // // // // // class Item1Page extends StatelessWidget {
// // // // // // // // //   @override
// // // // // // // // //   Widget build(BuildContext context) {
// // // // // // // // //     return Scaffold(
// // // // // // // // //       appBar: AppBar(
// // // // // // // // //         title: Text('Item 1 Page'),
// // // // // // // // //       ),
// // // // // // // // //       body: Center(
// // // // // // // // //         child: Text('This is the Item 1 page content.'),
// // // // // // // // //       ),
// // // // // // // // //     );
// // // // // // // // //   }
// // // // // // // // // }
// // // // // // // import 'package:flutter/material.dart';

// // // // // // // void main() => runApp(MyApp());

// // // // // // // class MyApp extends StatelessWidget {
// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return MaterialApp(
// // // // // // //       title: 'Flutter Demo',
// // // // // // //       theme: ThemeData(
// // // // // // //         primarySwatch: Colors.red,
// // // // // // //       ),
// // // // // // //       home: App(),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }

// // // // // // // enum TabItem { red, green, blue }

// // // // // // // class App extends StatefulWidget {
// // // // // // //   @override
// // // // // // //   State<StatefulWidget> createState() => AppState();
// // // // // // // }

// // // // // // // class AppState extends State<App> {
// // // // // // //   TabItem currentTab = TabItem.red;
// // // // // // //   Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
// // // // // // //     TabItem.red: GlobalKey<NavigatorState>(),
// // // // // // //     TabItem.green: GlobalKey<NavigatorState>(),
// // // // // // //     TabItem.blue: GlobalKey<NavigatorState>(),
// // // // // // //   };

// // // // // // //   void _selectTab(TabItem tabItem) {
// // // // // // //     setState(() {
// // // // // // //       currentTab = tabItem;
// // // // // // //     });
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return WillPopScope(
// // // // // // //       onWillPop: () async =>
// // // // // // //           !await navigatorKeys[currentTab]!.currentState!.maybePop(),
// // // // // // //       child: Scaffold(
// // // // // // //         body: Stack(
// // // // // // //           children: <Widget>[
// // // // // // //             _buildOffstageNavigator(TabItem.red),
// // // // // // //             _buildOffstageNavigator(TabItem.green),
// // // // // // //             _buildOffstageNavigator(TabItem.blue),
// // // // // // //           ],
// // // // // // //         ),
// // // // // // //         bottomNavigationBar: BottomNavigation(
// // // // // // //           currentTab: currentTab,
// // // // // // //           onSelectTab: _selectTab,
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   Widget _buildOffstageNavigator(TabItem tabItem) {
// // // // // // //     return Offstage(
// // // // // // //       offstage: currentTab != tabItem,
// // // // // // //       child: TabNavigator(
// // // // // // //         navigatorKey: navigatorKeys[tabItem],
// // // // // // //         tabItem: tabItem,
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }

// // // // // // // class TabNavigatorRoutes {
// // // // // // //   static const String root = '/';
// // // // // // //   static const String detail = '/detail';
// // // // // // // }

// // // // // // // class TabNavigator extends StatelessWidget {
// // // // // // //   TabNavigator({this.navigatorKey, this.tabItem});
// // // // // // //   final GlobalKey<NavigatorState> navigatorKey;
// // // // // // //   final TabItem tabItem;

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return Navigator(
// // // // // // //       key: navigatorKey,
// // // // // // //       initialRoute: TabNavigatorRoutes.root,
// // // // // // //       onGenerateRoute: (routeSettings) {
// // // // // // //         return MaterialPageRoute(
// // // // // // //           builder: (context) => _routeBuilders(context)[routeSettings.name](context),
// // // // // // //         );
// // // // // // //       },
// // // // // // //     );
// // // // // // //   }

// // // // // // //   Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
// // // // // // //     return {
// // // // // // //       TabNavigatorRoutes.root: (context) => ColorsListPage(
// // // // // // //             color: TabHelper.color(tabItem),
// // // // // // //             title: TabHelper.description(tabItem),
// // // // // // //             onPush: (materialIndex) => _push(context, materialIndex: materialIndex),
// // // // // // //           ),
// // // // // // //       TabNavigatorRoutes.detail: (context) => ColorDetailPage(
// // // // // // //             color: TabHelper.color(tabItem),
// // // // // // //             title: TabHelper.description(tabItem),
// // // // // // //             materialIndex: materialIndex,
// // // // // // //           ),
// // // // // // //     };
// // // // // // //   }

// // // // // // //   void _push(BuildContext context, {int materialIndex: 500}) {
// // // // // // //     var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

// // // // // // //     Navigator.push(
// // // // // // //       context,
// // // // // // //       MaterialPageRoute(
// // // // // // //         builder: (context) => routeBuilders[TabNavigatorRoutes.detail](context),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }

// // // // // // // class ColorsListPage extends StatelessWidget {
// // // // // // //   ColorsListPage({this.color, this.title, this.onPush});
// // // // // // //   final MaterialColor color;
// // // // // // //   final String title;
// // // // // // //   final ValueChanged<int> onPush;

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return Scaffold(
// // // // // // //       appBar: AppBar(
// // // // // // //         title: Text(title),
// // // // // // //         backgroundColor: color,
// // // // // // //       ),
// // // // // // //       body: Container(
// // // // // // //         color: Colors.white,
// // // // // // //         child: _buildList(),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   final List<int> materialIndices = [900, 800, 700, 600, 500, 400, 300, 200, 100, 50];

// // // // // // //   Widget _buildList() {
// // // // // // //     return ListView.builder(
// // // // // // //       itemCount: materialIndices.length,
// // // // // // //       itemBuilder: (BuildContext context, int index) {
// // // // // // //         int materialIndex = materialIndices[index];
// // // // // // //         return Container(
// // // // // // //           color: color[materialIndex],
// // // // // // //           child: ListTile(
// // // // // // //             title: Text('$materialIndex', style: TextStyle(fontSize: 24.0)),
// // // // // // //             trailing: Icon(Icons.chevron_right),
// // // // // // //             onTap: () => onPush(materialIndex),
// // // // // // //           ),
// // // // // // //         );
// // // // // // //       },
// // // // // // //     );
// // // // // // //   }
// // // // // // // }

// // // // // // // class ColorDetailPage extends StatelessWidget {
// // // // // // //   ColorDetailPage({this.color, this.title, this.materialIndex: 500});
// // // // // // //   final MaterialColor color;
// // // // // // //   final String title;
// // // // // // //   final int materialIndex;

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return Scaffold(
// // // // // // //       appBar: AppBar(
// // // // // // //         backgroundColor: color,
// // // // // // //         title: Text('$title[$materialIndex]'),
// // // // // // //       ),
// // // // // // //       body: Container(
// // // // // // //         color: color[materialIndex],
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }
// // // // // // import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
// // // // // // import 'package:flutter/material.dart';

// // // // // // void main() => runApp(MyApp());

// // // // // // class MyApp extends StatelessWidget {
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return MaterialApp(
// // // // // //       title: 'Flutter Demo',
// // // // // //       theme: ThemeData(
// // // // // //         primarySwatch: Colors.red,
// // // // // //       ),
// // // // // //       home: App(),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // // enum TabItem { red, green, blue }

// // // // // // class App extends StatefulWidget {
// // // // // //   @override
// // // // // //   State<StatefulWidget> createState() => AppState();
// // // // // // }

// // // // // // class AppState extends State<App>  with SingleTickerProviderStateMixin  {
// // // // // //   TabItem currentTab = TabItem.red;

// // // // // //   // void _selectTab(TabItem tabItem) {
// // // // // //   //   setState(() {
// // // // // //   //     currentTab = tabItem;
// // // // // //   //   });
// // // // // //   // }
// // // // // //   late TabController _tabController = TabController(length: 4, vsync: this);


// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       appBar: AppBar(
// // // // // //         title: Text('Flutter Demo'),
// // // // // //       ),
// // // // // //        body:
       
// // // // // //        Column(children: [
// // // // // //        TabBar(
// // // // // //         controller: _tabController,
// // // // // //         labelColor: Batatis_Dark,
// // // // // //         unselectedLabelColor: grey_Dark,
// // // // // //         indicatorSize: TabBarIndicatorSize.tab,
// // // // // //         indicatorPadding: EdgeInsets.all(5.0),
// // // // // //        indicatorColor: Batatis_Dark,
// // // // // //         tabs: [
// // // // // //           Tab(
// // // // // //             text: "Home",
// // // // // //             icon: Icon(Icons.home_outlined),
// // // // // //           ),
// // // // // //           Tab(
// // // // // //             text: "Orders",
// // // // // //             icon: Icon(Icons.list_alt_outlined),
// // // // // //           ),
// // // // // //           Tab(
// // // // // //             text: "Group",
// // // // // //             icon: Icon(Icons.supervised_user_circle),
// // // // // //           ),
// // // // // //           Tab(
// // // // // //             text: "Options",
// // // // // //             icon: Icon(Icons.settings),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //       TabBarView(
// // // // // //         controller: _tabController,
// // // // // //         children: [
// // // // // //          Text("Cmainpage()") ,
// // // // // //            Text("Corder()") ,
// // // // // //           Text("Cgroup order()") ,
// // // // // //           Text("settting()") ,
// // // // // //         ],
// // // // // //       ),])
// // // // // //       // Column(
// // // // // //       //   children: <Widget>[
// // // // // //       //     _buildTabBar(),
// // // // // //       //     Expanded(
// // // // // //       //       child: _buildTabBarView(),
// // // // // //       //     ),
// // // // // //       //   ],
// // // // // //       // ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildTabBar() {
// // // // // //     return TabBar(
// // // // // //       tabs: <Widget>[
// // // // // //         Tab(text: 'Red'),
// // // // // //         Tab(text: 'Green'),
// // // // // //         Tab(text: 'Blue'),
// // // // // //       ],
// // // // // //       controller: _tabController,
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildTabBarView() {
// // // // // //     return TabBarView(
// // // // // //       controller: _tabController,
// // // // // //       children: <Widget>[
// // // // // //         _buildColorPage(TabItem.red),
// // // // // //         _buildColorPage(TabItem.green),
// // // // // //         _buildColorPage(TabItem.blue),
// // // // // //       ],
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildColorPage(TabItem tabItem) {
// // // // // //     return Center(
// // // // // //       child: Column(
// // // // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // // // //         children: <Widget>[
// // // // // //           Text('Color: ${_getColorName(tabItem)}', style: TextStyle(fontSize: 24)),
// // // // // //           ElevatedButton(
// // // // // //             onPressed: () => _push(tabItem),
// // // // // //             child: Text('Go to Detail'),
// // // // // //           ),
// // // // // //         ],
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   String _getColorName(TabItem tabItem) {
// // // // // //     switch (tabItem) {
// // // // // //       case TabItem.red:
// // // // // //         return 'Red';
// // // // // //       case TabItem.green:
// // // // // //         return 'Green';
// // // // // //       case TabItem.blue:
// // // // // //         return 'Blue';
// // // // // //     }
// // // // // //   }

// // // // // //   void _push(TabItem tabItem) {
// // // // // //     Navigator.of(context).push(
// // // // // //       MaterialPageRoute(
// // // // // //         builder: (context) => ColorDetailPage(tabItem: tabItem),
// // // // // //       ),
// // // // // //     );
// // // // // //   }


// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     _tabController.dispose();
// // // // // //     super.dispose();
// // // // // //   }
// // // // // // }

// // // // // // class ColorDetailPage extends StatelessWidget {
// // // // // //   final TabItem tabItem;

// // // // // //   ColorDetailPage({required this.tabItem});

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       appBar: AppBar(
// // // // // //         title: Text('Detail Page - ${_getColorName(tabItem)}'),
// // // // // //       ),
// // // // // //       body: Center(
// // // // // //         child: Text(
// // // // // //           'This is the detail page for ${_getColorName(tabItem)}',
// // // // // //           style: TextStyle(fontSize: 24),
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   String _getColorName(TabItem tabItem) {
// // // // // //     switch (tabItem) {
// // // // // //       case TabItem.red:
// // // // // //         return 'Red';
// // // // // //       case TabItem.green:
// // // // // //         return 'Green';
// // // // // //       case TabItem.blue:
// // // // // //         return 'Blue';
// // // // // //     }
// // // // // //   }
// // // // // // }
// // // // // import 'package:flutter/material.dart';

// // // // // void main() => runApp(MyApp());

// // // // // class MyApp extends StatelessWidget {
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return MaterialApp(
// // // // //       title: 'Flutter Demo',
// // // // //       theme: ThemeData(
// // // // //         primarySwatch: Colors.red,
// // // // //       ),
// // // // //       home: App(),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // enum TabItem { home, orders, group, options }

// // // // // class App extends StatefulWidget {
// // // // //   @override
// // // // //   State<StatefulWidget> createState() => AppState();
// // // // // }

// // // // // class AppState extends State<App> with SingleTickerProviderStateMixin {
// // // // //   late TabController _tabController;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _tabController = TabController(length: 4, vsync: this);
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text('Flutter Demo'),
// // // // //       ),
// // // // //       body: Column(
// // // // //         children: [
// // // // //           TabBar(
            
// // // // //             controller: _tabController,
// // // // //             labelColor: Colors.red, // Change to your desired color
// // // // //             unselectedLabelColor: Colors.grey, // Change to your desired color
// // // // //             indicatorSize: TabBarIndicatorSize.tab,
// // // // //             indicatorPadding: EdgeInsets.all(5.0),
// // // // //             tabs: [
// // // // //               Tab(
// // // // //                 text: "Home",
// // // // //                 icon: Icon(Icons.home_outlined),
// // // // //               ),
// // // // //               Tab(
// // // // //                 text: "Orders",
// // // // //                 icon: Icon(Icons.list_alt_outlined),
// // // // //               ),
// // // // //               Tab(
// // // // //                 text: "Group",
// // // // //                 icon: Icon(Icons.supervised_user_circle),
// // // // //               ),
// // // // //               Tab(
// // // // //                 text: "Options",
// // // // //                 icon: Icon(Icons.settings),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //           Expanded(
// // // // //             child: TabBarView(
// // // // //               controller: _tabController,
// // // // //               children: [
// // // // //                 Center(
// // // // //                   child: Text("Home Content"),
// // // // //                 ),
// // // // //                 Center(
// // // // //                   child: Text("Orders Content"),
// // // // //                 ),
// // // // //                 Center(
// // // // //                   child: Text("Group Content"),
// // // // //                 ),
// // // // //                 Center(
// // // // //                   child: Text("Options Content"),
// // // // //                 ),
// // // // //               ],
// // // // //             ),
// // // // //           ),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _tabController.dispose();
// // // // //     super.dispose();
// // // // //   }
// // // // // }
// // // // import 'package:flutter/material.dart';

// // // // void main() => runApp(MyApp());

// // // // class MyApp extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return MaterialApp(
// // // //       title: 'Flutter Demo',
// // // //       theme: ThemeData(
// // // //         primarySwatch: Colors.red,
// // // //       ),
// // // //       home: App(),
// // // //     );
// // // //   }
// // // // }

// // // // enum TabItem { home, orders, group, options }

// // // // class App extends StatefulWidget {
// // // //   @override
// // // //   State<StatefulWidget> createState() => AppState();
// // // // }

// // // // class AppState extends State<App> with SingleTickerProviderStateMixin {
// // // //   late TabController _tabController;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _tabController = TabController(length: 4, vsync: this);
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Flutter Demo'),
// // // //       ),
// // // //       body: Column(
// // // //         children: [
// // // //           Container(
// // // //             height: 500, // Adjust the height as needed
// // // //             child: ListView(
// // // //               scrollDirection: Axis.vertical,
// // // //               children: [
// // // //                 _buildTab("Home", Icons.home_outlined, TabItem.home),
// // // //                 _buildTab("Orders", Icons.list_alt_outlined, TabItem.orders),
// // // //                 _buildTab("Group", Icons.supervised_user_circle, TabItem.group),
// // // //                 _buildTab("Options", Icons.settings, TabItem.options),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //           Expanded(
// // // //             child: TabBarView(
// // // //               controller: _tabController,
// // // //               children: [
// // // //                 Center(child: Text("Home Content")),
// // // //                 Center(child: Text("Orders Content")),
// // // //                 Center(child: Text("Group Content")),
// // // //                 Center(child: Text("Options Content")),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildTab(String label, IconData icon, TabItem tabItem) {
// // // //     return InkWell(
// // // //       onTap: () {
// // // //         _tabController.animateTo(tabItem.index); // Change to the selected tab
// // // //       },
// // // //       child: Container(
// // // //         padding: EdgeInsets.symmetric(horizontal: 16),
// // // //         child: Row(
// // // //           children: [
// // // //             Icon(icon),
// // // //             SizedBox(width: 4),
// // // //             Text(label),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     _tabController.dispose();
// // // //     super.dispose();
// // // //   }
// // // // // }
// // // // import 'package:flutter/material.dart';

// // // // void main() => runApp(MyApp());

// // // // class MyApp extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return MaterialApp(
// // // //       home: CView(),
// // // //     );
// // // //   }
// // // // }

// // // // class CView extends StatefulWidget {
// // // //   @override
// // // //   _CViewState createState() => _CViewState();
// // // // }

// // // // bool WantAppBar = true ; 
// // // // class _CViewState extends State<CView> {
// // // //   int _currentIndex = 0;
// // // // static late  StateSetter s ; 
// // // //   final List<Widget> _views = [
// // // //     MainPage(),
// // // //     Page1(),
// // // //     Page2(),
// // // //   ];
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     s = setState ; 
// // // //     return Scaffold(
// // // //       appBar: WantAppBar? AppBar(
// // // //         title: Text('Your App Title'),
// // // //       ):null,
// // // //      body: 
       
// // // //       Navigator(
// // // //         onGenerateRoute: (settings) {
// // // //           return MaterialPageRoute(
// // // //             builder: (context) => _views[_currentIndex],
// // // //           );
// // // //         },
// // // //       ),
// // // //      // _views[_currentIndex],
// // // //       bottomNavigationBar: BottomNavigationBar(
// // // //         currentIndex: _currentIndex,
// // // //         onTap: (index) {
// // // //           setState(() {
// // // //             _currentIndex = index;
// // // //           });
// // // //         },
// // // //         items: [
// // // //           BottomNavigationBarItem(
// // // //             icon: Icon(Icons.home),
// // // //             label: 'Main Page',
// // // //           ),
// // // //           BottomNavigationBarItem(
// // // //             icon: Icon(Icons.pageview),
// // // //             label: 'Page 1',
// // // //           ),
// // // //           BottomNavigationBarItem(
// // // //             icon: Icon(Icons.pageview),
// // // //             label: 'Page 2',
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class MainPage extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //  //   _CViewState.s((){ 
// // // //   print("MainPage");
// // // //     WantAppBar = true ; 
// // // // //});
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Main Page'),
// // // //       ),
// // // //       body: Center(
// // // //         child: ElevatedButton(
// // // //           onPressed: () async{
            
// // // //             //Navigate to Page1 with a back arrow in the AppBar
// // // //             //  _CViewState.s((){ 
// // // //             //   WantAppBar = false ; 
// // // //             //   });
// // // //             Navigator.push(
// // // //               context,
// // // //               MaterialPageRoute(
// // // //                 builder: (context) => Page1(),
// // // //               ),
// // // //            );
// // // //           },
// // // //           child: Text('Go to Page 1'),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }


// // // // class Page1 extends StatelessWidget {
// // // //   @override 
   
// // // //   Widget build(BuildContext context) {
// // // // //    _CViewState.s((){ 
// // // // //    final WantAppBar = false ;
// // // // // });
  
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Page 1'),
// // // //       ),
// // // //       body: Center(
// // // //         child: Text('This is Page 1'),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class Page2 extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Page 2'),
// // // //       ),
// // // //       body: Center(
// // // //         child: Text('This is Page 2'),
// // // //       ),
// // // //     );
// // // //   }
// // // // }import 'package:flutter/material.dart';
// // // //  import 'package:flutter/material.dart';
// // // // void main() => runApp(MyApp());

// // // // class MyApp extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return MaterialApp(
// // // //       home: CView(),
// // // //     );
// // // //   }
// // // // }

// // // // class CView extends StatefulWidget {
// // // //   @override
// // // //   _CViewState createState() => _CViewState();
// // // // }

// // // // bool WantAppBar = true;

// // // // class _CViewState extends State<CView> {
// // // //   int _currentIndex = 0;

// // // //   final List<Widget> _views = [
// // // //     MainPage(),
// // // //     Page1(),
// // // //     Page2(),
// // // //     Page3(),
// // // //   ];

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: WantAppBar ? AppBar(title: Text('Your App Title')) : null,
// // // //       body: Navigator(
// // // //         key: GlobalKey<NavigatorState>(),
// // // //         onGenerateRoute: (settings) {
// // // //           return MaterialPageRoute(
// // // //             builder: (context) => _views[_currentIndex],
// // // //           );
// // // //         },
// // // //       ),
// // // //       bottomNavigationBar: BottomNavigationBar(
// // // //         currentIndex: _currentIndex,
// // // //         onTap: (index) {
// // // //           if (index == 0) {
// // // //             // If Main Page is tapped, navigate to Page 3
// // // //             _currentIndex = 3;
// // // //           } else {
// // // //             _currentIndex = index;
// // // //           }
// // // //           setState(() {});
// // // //         },
// // // //         items: [
// // // //           BottomNavigationBarItem(
// // // //             icon: Icon(Icons.home),
// // // //             label: 'Main Page',
// // // //           ),
// // // //           BottomNavigationBarItem(
// // // //             icon: Icon(Icons.pageview),
// // // //             label: 'Page 1',
// // // //           ),
// // // //           BottomNavigationBarItem(
// // // //             icon: Icon(Icons.pageview),
// // // //             label: 'Page 2',
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class MainPage extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     print("MainPage");
// // // //     WantAppBar = true;
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Main Page'),
// // // //       ),
// // // //       body: Center(
// // // //         child: ElevatedButton(
// // // //           onPressed: () {
// // // //             Navigator.push(
// // // //               context,
// // // //               MaterialPageRoute(
// // // //                 builder: (context) => Page3(),
// // // //               ),
// // // //             );
// // // //           },
// // // //           child: Text('Go to Page 3'),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class Page1 extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Page 1'),
// // // //       ),
// // // //       body: Center(
// // // //         child: Text('This is Page 1'),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class Page2 extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Page 2'),
// // // //       ),
// // // //       body: Center(
// // // //         child: Text('This is Page 2'),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class Page3 extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Page 3'),
// // // //       ),
// // // //       body: Center(
// // // //         child: ElevatedButton(
// // // //           onPressed: () {
// // // //             // Navigate to Page 2 when the button is pressed
// // // //             Navigator.push(
// // // //               context,
// // // //               MaterialPageRoute(
// // // //                 builder: (context) => Page2(),
// // // //               ),
// // // //             );
// // // //           },
// // // //           child: Text('Go to Page 2'),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }




// // // //////////////////////////////////////////////////////
// // // // import 'package:flutter/material.dart';

// // // // void main() => runApp(MyApp());

// // // // class MyApp extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return MaterialApp(
// // // //       home: CView(),
// // // //       routes: {
// // // //         '/page1': (context) => Page1(),
// // // //         '/page2': (context) => Page2(),
// // // //         '/page3': (context) => Page3(),
// // // //       },
// // // //     );
// // // //   }
// // // // }

// // // // class CView extends StatefulWidget {
// // // //   @override
// // // //   _CViewState createState() => _CViewState();
// // // // }

// // // // bool WantAppBar = true;

// // // // class _CViewState extends State<CView> {
// // // //   int _currentIndex = 0;

// // // //   final List<String> _routeNames = [
// // // //     '/',
// // // //     '/page1',
// // // //     '/page2',
// // // //     '/page3',
// // // //   ];

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: WantAppBar ? AppBar(title: Text('Your App Title')) : null,
// // // //       body: Navigator(
// // // //         key: GlobalKey<NavigatorState>(),
// // // //         initialRoute: _routeNames[_currentIndex],
// // // //         onGenerateRoute: (settings) {
// // // //           return MaterialPageRoute(
// // // //             builder: (context) {
// // // //               return _views[_currentIndex];
// // // //             },
// // // //           );
// // // //         },
// // // //       ),
// // // //       bottomNavigationBar: BottomNavigationBar(
// // // //         currentIndex: _currentIndex,
// // // //         onTap: (index) {
// // // //           setState(() {
// // // //             _currentIndex = index;
// // // //           });
// // // //         },
// // // //         items: [
// // // //           BottomNavigationBarItem(
// // // //             icon: Icon(Icons.home),
// // // //             label: 'Main Page',
// // // //           ),
// // // //           BottomNavigationBarItem(
// // // //             icon: Icon(Icons.pageview),
// // // //             label: 'Page 1',
// // // //           ),
// // // //           BottomNavigationBarItem(
// // // //             icon: Icon(Icons.pageview),
// // // //             label: 'Page 2',
// // // //           ),
// // // //           BottomNavigationBarItem(
// // // //             icon: Icon(Icons.pageview),
// // // //             label: 'Page 3',
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   final List<Widget> _views = [
// // // //     MainPage(),
// // // //     Page1(),
// // // //     Page2(),
// // // //     Page3(),
// // // //   ];
// // // // }

// // // // class MainPage extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     WantAppBar = true;
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Main Page'),
// // // //       ),
// // // //       body: Center(
// // // //         child: ElevatedButton(
// // // //           onPressed: () {
// // // //             Navigator.of(context).pushNamed('/page3');
// // // //           },
// // // //           child: Text('Go to Page 3'),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class Page1 extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Page 1'),
// // // //       ),
// // // //       body: Center(
// // // //         child: Text('This is Page 1'),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class Page2 extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Page 2'),
// // // //       ),
// // // //       body: Center(
// // // //         child: Text('This is Page 2'),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class Page3 extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Page 3'),
// // // //       ),
// // // //       body: Center(
// // // //         child: ElevatedButton(
// // // //           onPressed: () {
// // // //             Navigator.of(context).pushNamed('/page2');
// // // //           },
// // // //           child: Text('Go to Page 2'),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // // import 'package:flutter/material.dart';

// // // void main() => runApp(MyApp());

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       home: CView(),
// // //     );
// // //   }
// // // }

// // // class CView extends StatefulWidget {
// // //   @override
// // //   _CViewState createState() => _CViewState();
// // // }

// // // bool WantAppBar = true;

// // // class _CViewState extends State<CView> {
// // //   int _currentIndex = 0;

// // //   final List<Widget> _views = [
// // //     MainPage(),
// // //     Page1(),
// // //     Page2(),
// // //     Page3(),
// // //   ];

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: WantAppBar ? AppBar(title: Text('Your App Title')) : null,
// // //       body: Navigator(
// // //         key: GlobalKey<NavigatorState>(),
// // //         initialRoute: '/',
// // //         onGenerateRoute: (settings) {
// // //           return MaterialPageRoute(
// // //             builder: (context) => _views[_currentIndex],
// // //           );
// // //         },
// // //       ),
// // //       bottomNavigationBar: BottomNavigationBar(
// // //         currentIndex: _currentIndex,
// // //         onTap: (index) {
// // //           setState(() {
// // //             _currentIndex = index;
// // //           });
// // //         },
// // //         items: [
// // //           BottomNavigationBarItem(
// // //             icon: Icon(Icons.home),
// // //             label: 'Main Page',
// // //           ),
// // //           BottomNavigationBarItem(
// // //             icon: Icon(Icons.pageview),
// // //             label: 'Page 1',
// // //           ),
// // //           BottomNavigationBarItem(
// // //             icon: Icon(Icons.pageview),
// // //             label: 'Page 2',
// // //           ),
// // //           BottomNavigationBarItem(
// // //             icon: Icon(Icons.pageview),
// // //             label: 'Page 3',
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // class MainPage extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     WantAppBar = true;
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Main Page'),
// // //       ),
// // //       body: Center(
// // //         child: ElevatedButton(
// // //           onPressed: () {
// // //             Navigator.of(context).pushNamed('/page3');
// // //           },
// // //           child: Text('Go to Page 3'),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class Page1 extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Page 1'),
// // //       ),
// // //       body: Center(
// // //         child: Text('This is Page 1'),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class Page2 extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Page 2'),
// // //       ),
// // //       body: Center(
// // //         child: Text('This is Page 2'),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class Page3 extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     WantAppBar = true;
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Page 3'),
// // //       ),
// // //       body: Center(
// // //         child: ElevatedButton(
// // //           onPressed: () {
// // //             Navigator.of(context).pushNamed('/page2');
// // //           },
// // //           child: Text('Go to Page 2'),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // // // // 
// // // import 'package:flutter/material.dart';

// // // class UserLocationDialog extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return AlertDialog(
// // //       insetPadding: EdgeInsets.all(0),
// // //       content: Container(
// // //         width: 350,
// // //         height: 645,
// // //         child: Stack(
// // //           children: [
// // //             // Your dialog content here
// // //             Positioned(
// // //               top: 50,
// // //               left: 0,
// // //               right: 0,
// // //               child: LocationPicker(width: 400.0, height: 450.0),
// // //             ),
// // //             Positioned(
// // //               top: 0,
// // //               left: 0,
// // //               right: 0,
// // //               child: Row(
// // //                 mainAxisAlignment: MainAxisAlignment.end,
// // //                 children: [
// // //                   Container(
// // //                     child: Text(
// // //                       "Select Location",
// // //                       style: TextStyle(
// // //                         color: Colors.black, // Change color as needed
// // //                         fontSize: 20,
// // //                         fontWeight: FontWeight.bold,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                   SizedBox(width: 60),
// // //                   IconButton(
// // //                     onPressed: () {
// // //                       Navigator.pop(context);
// // //                     },
// // //                     icon: Icon(Icons.cancel),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //             Positioned(
// // //               bottom: 0,
// // //               left: 0,
// // //               right: 0,
// // //               child: Container(
// // //                 width: 400,
// // //                 padding: EdgeInsets.all(0),
// // //                 margin: EdgeInsets.only(bottom: 0),
// // //                 child: Column(
// // //                   children: [
// // //                     // Your dialog content here
// // //                     // Example:
// // //                     // Text("Your Text"),
// // //                     // CustomButton(...),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class LocationPicker extends StatelessWidget {
// // //   final double width;
// // //   final double height;

// // //   LocationPicker({required this.width, required this.height});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // Implement your LocationPicker widget here
// // //     // You can use Google Maps or any other location picker
// // //     // Example: GoogleMap(...)
// // //     return Container(
// // //       width: width,
// // //       height: height,
// // //       color: Colors.blue, // Replace with your location picker
// // //     );
// // //   }
// // // }

// // // class CustomButton extends StatelessWidget {
// // //   final String text;
// // //   final Function onPressed;
// // //   final String type;

// // //   CustomButton({required this.text, required this.onPressed, required this.type});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // Implement your custom button widget here
// // //     return ElevatedButton(
// // //       onPressed: () {
// // //         onPressed();
// // //       },
// // //       child: Text(text),
// // //     );
// // //   }
// // // }

// // // void main() {
// // //   runApp(MyApp());
// // // }

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       home: Scaffold(
// // //         appBar: AppBar(
// // //           title: Text('Your App Title'),
// // //         ),
// // //         body: Center(
// // //           child: ElevatedButton(
// // //             onPressed: () {
// // //               showDialog(
// // //                 context: context,
// // //                 builder: (context) {
// // //                   return UserLocationDialog();
// // //                 },
// // //               );
// // //             },
// // //             child: Text('Open Location Dialog'),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // import 'package:flutter/material.dart';

// // // void main() => runApp(MyApp());

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       home: CView(),
// // //     );
// // //   }
// // // }

// // // class CView extends StatefulWidget {
// // //   @override
// // //   _CViewState createState() => _CViewState();
// // // }

// // // class _CViewState extends State<CView> {
// // //   int _currentIndex = 0;

// // //   final List<Widget> _views = [
// // //     MainPage(),
// // //     Page1(),
// // //     Page2(),
// // //   ];

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Your App Title'),
// // //       ),
// // //       body: Navigator(
// // //         onGenerateRoute: (settings) {
// // //           return MaterialPageRoute(
// // //             builder: (context) => _views[_currentIndex],
// // //           );
// // //         },
// // //       ),
// // //       bottomNavigationBar: BottomNavigationBar(
// // //         currentIndex: _currentIndex,
// // //         onTap: (index) {
// // //           setState(() {
// // //             _currentIndex = index;
// // //           });
// // //         },
// // //         items: [
// // //           BottomNavigationBarItem(
// // //             icon: Icon(Icons.home),
// // //             label: 'Main Page',
// // //           ),
// // //           BottomNavigationBarItem(
// // //             icon: Icon(Icons.pageview),
// // //             label: 'Page 1',
// // //           ),
// // //           BottomNavigationBarItem(
// // //             icon: Icon(Icons.pageview),
// // //             label: 'Page 2',
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // class MainPage extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Main Page'),
// // //       ),
// // //       body: Center(
// // //         child: ElevatedButton(
// // //           onPressed: () {
// // //             // Navigate to Page1 when the button is pressed
// // //             Navigator.push(context, MaterialPageRoute(builder: (context) => Page1()));
// // //           },
// // //           child: Text('Go to Page 1'),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class Page1 extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Page 1'),
// // //       ),
// // //       body: Center(
// // //         child: Text('This is Page 1'),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class Page2 extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Page 2'),
// // //       ),
// // //       body: Center(
// // //         child: Text('This is Page 2'),
// // //       ),
// // //     );
// // //   }
// // // }
// // // import 'package:flutter/material.dart';

// // // void main() => runApp(MyApp());

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       home: CView(),
// // //     );
// // //   }
// // // }

// // // class CView extends StatefulWidget {
// // //   @override
// // //   _CViewState createState() => _CViewState();
// // // }

// // // class _CViewState extends State<CView> {
// // //   int _currentIndex = 0;

// // //   final List<Widget> _views = [
// // //     MainPage(),
// // //     Page1(),
// // //     Page2(),
// // //   ];

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Your App Title'),
// // //       ),
// // //       body: _views[_currentIndex], // Display the selected view directly
// // //       bottomNavigationBar: BottomNavigationBar(
// // //         currentIndex: _currentIndex,
// // //         onTap: (index) {
// // //           setState(() {
// // //             _currentIndex = index;
// // //           });
// // //         },
// // //         items: [
// // //           BottomNavigationBarItem(
// // //             icon: Icon(Icons.home),
// // //             label: 'Main Page',
// // //           ),
// // //           BottomNavigationBarItem(
// // //             icon: Icon(Icons.pageview),
// // //             label: 'Page 1',
// // //           ),
// // //           BottomNavigationBarItem(
// // //             icon: Icon(Icons.pageview),
// // //             label: 'Page 2',
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // class MainPage extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Main Page'),
// // //       ),
// // //       body: Center(
// // //         child: ElevatedButton(
// // //           onPressed: () {
// // //             // Update the current index to navigate to Page1
// // //             setState(() {
// // //               _currentIndex = 1;
// // //             });
// // //           },
// // //           child: Text('Go to Page 1'),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class Page1 extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Page 1'),
// // //       ),
// // //       body: Center(
// // //         child: Text('This is Page 1'),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class Page2 extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Page 2'),
// // //       ),
// // //       body: Center(
// // //         child: Text('This is Page 2'),
// // //       ),
// // //     );
// // //   }
// // // }



// // // void main() => runApp(MyApp());

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       home: CView(),
// // //     );
// // //   }
// // // }

// // // class CView extends StatefulWidget {
// // //   @override
// // //   _CViewState createState() => _CViewState();
// // // }

// // // class _CViewState extends State<CView> {
// // //   int _currentIndex = 0;

// // //   final List<Widget> _views = [
// // //     MainPage(onTabChanged: (index) {
// // //       // Update the current index to navigate to Page1
// // //       // setState(() {
// // //       //   _currentIndex = index;
// // //       // });
// // //     }),
// // //     Page1(),
// // //     Page2(),
// // //   ];

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Your App Title'),
// // //       ),
// // //       body: _views[_currentIndex],
// // //       bottomNavigationBar: BottomNavigationBar(
// // //         currentIndex: _currentIndex,
// // //         onTap: (index) {
// // //           setState(() {
// // //             _currentIndex = index;
// // //           });
// // //         },
// // //         items: [
// // //           BottomNavigationBarItem(
// // //             icon: Icon(Icons.home),
// // //             label: 'Main Page',
// // //           ),
// // //           BottomNavigationBarItem(
// // //             icon: Icon(Icons.pageview),
// // //             label: 'Page 1',
// // //           ),
// // //           BottomNavigationBarItem(
// // //             icon: Icon(Icons.pageview),
// // //             label: 'Page 2',
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // class MainPage extends StatelessWidget {
// // //   final Function(int) onTabChanged;

// // //   MainPage({required this.onTabChanged});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Main Page'),
// // //       ),
// // //       body: Center(
// // //         child: ElevatedButton(
// // //           onPressed: () {
// // //             // Call the callback to update the current index to navigate to Page1
// // //             onTabChanged(1);
// // //           },
// // //           child: Text('Go to Page 1'),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class Page1 extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Page 1'),
// // //       ),
// // //       body: Center(
// // //         child: Text('This is Page 1'),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class Page2 extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Page 2'),
// // //       ),
// // //       body: Center(
// // //         child: Text('This is Page 2'),
// // //       ),
// // //     );
// // //   }
// // // }
// // //////////////////////////////////////////////here and down stack thing
// // // void main() => runApp(new MyApp());

// // // class MyApp extends StatelessWidget {
// // //   // This widget is the root of your application.
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       title: 'Flutter Demo',
// // //       theme: ThemeData(
// // //         primarySwatch: Colors.red,
// // //       ),
// // //       home: App(),
// // //     );
// // //   }
// // // }
// // // enum TabItem { red, green, blue }

// // // class App extends StatefulWidget {
// // //   @override
// // //   State<StatefulWidget> createState() => AppState();
// // // }

// // // class AppState extends State<App> {

// // //   TabItem currentTab = TabItem.red;

// // //   void _selectTab(TabItem tabItem) {
// // //     setState(() {
// // //       currentTab = tabItem;
// // //     });
// // //   }
// // // final navigatorKey = GlobalKey<NavigatorState>();
// // //   @override
// // //   Widget build(BuildContext context) {
// // //      return Scaffold(
// // //       body: TabNavigator(
// // //         navigatorKey: navigatorKey,
// // //         tabItem: currentTab,
// // //       ),
// // //       bottomNavigationBar: BottomNavigation(//BottomNavigation(
// // //         currentTab: currentTab,
// // //         onSelectTab: _selectTab,
// // //       ),
// // //     );
// // //   }
  
// // //   Widget _buildBody() {
// // //     return Container(
// // //     color: TabHelper.color(TabItem.red),
// // //     alignment: Alignment.center,
// // //     child: FlatButton(
// // //       child: Text(
// // //         'PUSH',
// // //         style: TextStyle(fontSize: 32.0, color: Colors.white),
// // //       ),
// // //       onPressed: _push,
// // //     )
// // //   );
// // // }

// // // void _push() {
// // //   Navigator.of(context).push(MaterialPageRoute(
// // //     // we'll look at ColorDetailPage later
// // //     builder: (context) => ColorDetailPage(
// // //       color: TabHelper.color(TabItem.red),
// // //       title: TabHelper.description(TabItem.red),
// // //     ),
// // //   ));
// // //   }
// // // }
// // // class TabNavigatorRoutes {
// // //   static const String root = '/';
// // //   static const String detail = '/detail';
// // // }

// // // class TabNavigator extends StatelessWidget {
// // //   TabNavigator({required this.navigatorKey, required this.tabItem});
// // //   final GlobalKey<NavigatorState> navigatorKey;
// // //   final TabItem tabItem;

// // //   void _push(BuildContext context, {int materialIndex = 500}) {
// // //     var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

// // //     Navigator.push(
// // //         context,
// // //         MaterialPageRoute(
// // //             builder: (context) =>
// // //                 routeBuilders[TabNavigatorRoutes.detail]!(context)));
// // //   }

// // //   Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
// // //       {int materialIndex: 500}) {
// // //     return {
// // //       TabNavigatorRoutes.root: (context) => ColorsListPage(
// // //             color: TabHelper.color(tabItem),
// // //             title: TabHelper.description(tabItem),
// // //             onPush: (materialIndex) =>
// // //                 _push(context, materialIndex: materialIndex),
// // //           ),
// // //       TabNavigatorRoutes.detail: (context) => ColorDetailPage(
// // //             color: TabHelper.color(tabItem),
// // //             title: TabHelper.description(tabItem),
// // //             materialIndex: materialIndex,
// // //           ),
// // //     };
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     var routeBuilders = _routeBuilders(context);

// // //     return Navigator(
// // //         key: navigatorKey,
// // //         initialRoute: TabNavigatorRoutes.root,
// // //         onGenerateRoute: (routeSettings) {
// // //           return MaterialPageRoute(
// // //               builder: (context) => routeBuilders[routeSettings.name]!(context));
// // //         });
// // //   }
// // // }

// // // class ColorsListPage extends StatelessWidget {
// // //   ColorsListPage({this.color, this.title, this.onPush});
// // //   final MaterialColor color;
// // //   final String title;
// // //   final ValueChanged<int> onPush;

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //         appBar: AppBar(
// // //           title: Text(
// // //             title,
// // //           ),
// // //           backgroundColor: color,
// // //         ),
// // //         body: Container(
// // //           color: Colors.white,
// // //           child: _buildList(),
// // //         ));
// // //   }

// // //   final List<int> materialIndices = [900, 800, 700, 600, 500, 400, 300, 200, 100, 50];

// // //   Widget _buildList() {
// // //     return ListView.builder(
// // //         itemCount: materialIndices.length,
// // //         itemBuilder: (BuildContext content, int index) {
// // //           int materialIndex = materialIndices[index];
// // //           return Container(
// // //             color: color[materialIndex],
// // //             child: ListTile(
// // //               title: Text('$materialIndex', style: TextStyle(fontSize: 24.0)),
// // //               trailing: Icon(Icons.chevron_right),
// // //               onTap: () => onPush(materialIndex),
// // //             ),
// // //           );
// // //         });
// // //   }
// // // }
// // // class ColorDetailPage extends StatelessWidget {
// // //   ColorDetailPage({this.color, this.title, this.materialIndex: 500});
// // //   final MaterialColor color;
// // //   final String title;
// // //   final int materialIndex;

// // //   @override
// // //   Widget build(BuildContext context) {

// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         backgroundColor: color,
// // //         title: Text(
// // //           '$title[$materialIndex]',
// // //         ),
// // //       ),
// // //       body: Container(
// // //         color: color[materialIndex],
// // //       ),
// // //     );
// // //   }
// // // }

// // // // Example of a ProductPage
// // // class RecievePage extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // Retrieve and use parameters as needed
// // //     final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
// // //     final String OrderId = arguments['OrderId'] ?? '';

// // //     // Build the UI for the ProductPage
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('OrderId Details'),
// // //       ),
// // //       body: Center(
// // //         child: Text('OrderId: $OrderId'),
// // //       ),
// // //     );
// // //   }
// // // }


// // // void main() {
// // //   runApp(MyApp());
// // // }

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       home: MyHomePage(),
// // //     );
// // //   }
// // // }

// // // class MyHomePage extends StatefulWidget {
// // //   @override
// // //   _MyHomePageState createState() => _MyHomePageState();
// // // }

// // // class _MyHomePageState extends State<MyHomePage> {
// // //   int _selectedIndex = 0;

// // //   List<BottomNavigationBarItem> _bottomNavigationBarItems = [
// // //     BottomNavigationBarItem(
// // //       icon: Icon(Icons.home),
// // //       label: 'Home',
// // //     ),
// // //     BottomNavigationBarItem(
// // //       icon: Icon(Icons.search),
// // //       label: 'Search',
// // //     ),
// // //     BottomNavigationBarItem(
// // //       icon: Icon(Icons.favorite),
// // //       label: 'Favorites',
// // //     ),
// // //   ];

// // //   Widget _getBody() {
// // //     switch (_selectedIndex) {
// // //       case 0:
// // //         return HomeTab();
// // //       case 1:
// // //         return SearchTab();
// // //       case 2:
// // //         return FavoritesTab();
// // //       default:
// // //         return Container(); // You can return a default widget if needed
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Bottom Navigation Example'),
// // //       ),
// // //       body: _getBody(),
// // //       bottomNavigationBar: BottomNavigationBar(
// // //         items: _bottomNavigationBarItems,
// // //         currentIndex: _selectedIndex,
// // //         onTap: (int index) {
// // //           setState(() {
// // //             _selectedIndex = index;
// // //           });
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }

// // // class HomeTab extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Center(
// // //       child: Text('Home Tab Content'),
// // //     );
// // //   }
// // // }

// // // class SearchTab extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return 
// // //     Scaffold(
// // //       appBar: AppBar(),
// // //       body:
// // //     Center(
// // //       child: Text('Search Tab Content'),
// // //     ));
// // //   }
// // // }

// // // class FavoritesTab extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Center(
// // //       child: ElevatedButton(child: Text("data"), onPressed: () {
// // //         Navigator.push(context,MaterialPageRoute(builder: (context) => SearchTab()));
// // //       },) //Text('Favorites Tab Content'),
// // //     );
// // //   }
// // // // }
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_stripe/flutter_stripe.dart';
// // // import 'dart:convert';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_stripe/flutter_stripe.dart';
// // // import 'package:http/http.dart' as http;

// // // import 'Customer_Widgets/colors.dart';
// // //import 'package:stripe_payment/stripe_payment.dart';
// // // Create this file

// // void main() async {
// // WidgetsFlutterBinding.ensureInitialized();
// //   Stripe.publishableKey = "pk_test_51O1zUECOEKBCIL7I5y7EIe67GPdPLwSWjFcuCPH3qLCk7pMXnLsZugmQInYocoXnwjW2C52GWBc4aOpGPmw75mtP00JEBWWraN";
// //  // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
// //   //Stripe.urlScheme = 'flutterstripe';
// //   //await Stripe.instance.applySettings();
// //  //  StripePayment.setOptions(
// //  //    StripeOptions(
// //  //      publishableKey: "pk_test_51O1zUECOEKBCIL7I5y7EIe67GPdPLwSWjFcuCPH3qLCk7pMXnLsZugmQInYocoXnwjW2C52GWBc4aOpGPmw75mtP00JEBWWraN",
// //  //    ),
// //  // );

// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: HomeScreen()// PaymentScreen(),
// //     );
// //   }
// // }

// // class HomeScreen extends StatefulWidget {
// //   const HomeScreen({Key? key}) : super(key: key);

// //   @override
// //   _HomeScreenState createState() => _HomeScreenState();
// // }

// // class _HomeScreenState extends State<HomeScreen> {
// //   Map<String, dynamic>? paymentIntent;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Stripe Payment'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //          //   CardField(),
// //            // Paymentw
// //           //Stripe.buildWebCard(controller:CardEditController(initialDetails: CardFieldInputDetails(complete : false , cvc: "123") )  ),
// //             TextButton(
// //               child: const Text('Buy Now'),
// //               onPressed: () async {
// //                 await makePayment(70);
// //             //      showModalBottomSheet<void>(
// //             // context: context,
// //             // builder: (BuildContext context) {
// //             //    return customPaymentSheet();});
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //     }
    
// //   //   Widget customPaymentSheet(){
// //   //  //final mthodpayment = Stripe.instance. 
     
     
// //   //     return  Container(
// //   //           height: MediaQuery.of(context).size.height / 2,
// //   //         //  color: Colors.green,
// //   //           child: Center(
// //   //             child: TextButton(child: Text('Bottom Half') , onPressed: () {
                
// //   //             },),
// //   //           ),
// //   //         );
// //   //   }



// //   //   }

     
// // ///////////////////////////////////////////////////////////////////////////////////////////////
// //     Future<void> makePayment(amount) async {
// //     try {
// //     paymentIntent = await createPaymentIntent((amount*100).toString(), 'SAR');

// //       //STEP 2: Initialize Payment Sheet
// //       await Stripe.instance
// //           .initPaymentSheet(
            
// //           paymentSheetParameters: SetupPaymentSheetParameters(
// //             billingDetailsCollectionConfiguration : BillingDetailsCollectionConfiguration(
// //               address:AddressCollectionMode.never,
// //               name: CollectionMode.never,
// //               email : CollectionMode.never
// //                ),
// //             primaryButtonLabel : "Pay $amount.00 SR",
            
// //               billingDetails : null , //BillingDetails(name:  " ashhhhh ") , 
// //               paymentIntentClientSecret: paymentIntent![
// //               'client_secret'], //Gotten from payment intent
// //               style: ThemeMode.light,
// //                merchantDisplayName: 'BATATIS',
// //               appearance:PaymentSheetAppearance(
                
// //                 primaryButton: PaymentSheetPrimaryButtonAppearance(
                  
// //                                 colors: PaymentSheetPrimaryButtonTheme(
// //                                         light: PaymentSheetPrimaryButtonThemeColors(
// //                                           background: Batatis_Dark)
// //                                          )) ,                
// //                 colors:  PaymentSheetAppearanceColors(
// //                   background: Colors.white, // Change the background color as needed
// //                   primary: Colors.black,
// //                 ) ),

// //               //googlePay: gpay
// //               ))
// //           .then((value) {print(" value valuee          $value" );});
        
// //       //STEP 3: Display Payment sheet
// //       displayPaymentSheet();
// //     } catch (err) {
// //       print("erorrrrrrr");
// //       print(err);
// //     }
// //   }

// //   displayPaymentSheet() async {
// //     try {
// //       var s = await Stripe.instance.presentPaymentSheet().then((value) async {
// //       //    print("hosnvpancssssuyu ${await paymentIntent!["status"]} hoho ");
    
// //       });
// //     } catch (e) {
// //       print("object");
// //       print('$e');
// //     }
// //   }

// //   createPaymentIntent(String amount, String currency) async {
// //   print("amount $amount");


// //     try {
// //       Map<String, dynamic> body = {
        
// //         'amount': amount,
// //         'currency': currency,
        
       
// //       };
// //       print("before response");
// //       var response = await http.post(
// //         Uri.parse('https://api.stripe.com/v1/payment_intents'),
// //         headers: {
// //           'Authorization': 'Bearer sk_test_51O1zUECOEKBCIL7IOPdfCposTk5NoLDRJ3q5vhLD9XNQrYMzMGolXZeMb6GQKJix5k1Bwm4bs1lkgBQ3xKE3sqgu00ehbsYuzf',
// //           'Content-Type': 'application/x-www-form-urlencoded'
// //         },
// //         body: body,
// //       );
// //       print(response.body);
// //       print("after response");
// //       return json.decode(response.body);
// //     } catch (err) {
// //       print("errrr");
// //       throw Exception(err.toString());
// //     }
// //   }


// // }
// // ///////////////////////////////////////////////////////////////////////////////////////////////////
// // // class PaymentScreen extends StatefulWidget {
// // //   @override
// // //   _PaymentScreenState createState() => _PaymentScreenState();
// // // }

// // // class _PaymentScreenState extends State<PaymentScreen> {
// // //   Token? _paymentToken;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     StripePayment.setOptions(
// // //       StripeOptions(
// // //         publishableKey: "pk_test_51O1zUECOEKBCIL7I5y7EIe67GPdPLwSWjFcuCPH3qLCk7pMXnLsZugmQInYocoXnwjW2C52GWBc4aOpGPmw75mtP00JEBWWraN",
// // //       ),
// // //     );
// // //   }

// // //   void _handlePayment() async {
// // //     final paymentMethod = PaymentMethodRequest(
// // //       card:  CreditCard(
// // //         number: '4242424242424242',
// // //         expMonth: 12,
// // //         expYear: 24,
// // //         cvc: '123',
// // //       ),
// // //     );

// // //     final PaymentMethod = await StripePayment.createPaymentMethod(paymentMethod);
// // //     final token = await StripePayment.c
// // //     setState(() {
// // //       _paymentToken = token ;
// // //     });
// // //     // Process the payment or save the token to your server.
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Stripe Payment Example'),
// // //       ),
// // //       body: Center(
// // //         child: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             CardField(),
// // //             ElevatedButton(
// // //               onPressed: _handlePayment,
// // //               child: Text('Make Payment'),
// // //             ),
// // //             if (_paymentToken != null)
// // //               Text('Payment Successful: ${_paymentToken!.id}'),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shimmer/shimmer.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.deepPurple,
// //       ),
// //       home: MyHomePage(title: 'Flutter Demo Home Page'),
// //     );
// //   }
// // }

// // class MyHomePage extends StatefulWidget {
// //   MyHomePage({Key? key, required this.title}) : super(key: key);

// //   final String title;

// //   @override
// //   _MyHomePageState createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyHomePage> {
// //   int timer = 800, offset = 0;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.title),
// //       ),
// //       body: GridView.builder(
// //           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
// //               maxCrossAxisExtent: 200,
// //               crossAxisSpacing: 20,
// //               mainAxisSpacing: 20),
// //           itemCount: 8,
// //           itemBuilder: (BuildContext ctx, index) {
// //             offset +=50;
// //             timer = 800 + offset;
// //             print(timer);
// //             return Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Shimmer.fromColors(
// //                 baseColor: grey_Dark , // Colors.grey[300],
// //                 highlightColor: Colors.white,
// //                 period: Duration(milliseconds: timer),
// //                 child: box(),
// //               ),
// //             );
// //           }),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {},
// //         child: Icon(Icons.add),
// //       ),
// //     );
// //   }


// //   Widget box(){
// //     return Container(
// //       height: 100,
// //       width: 100,
// //       color: Colors.grey,
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   void requestNotificationPermissions() {
//     _firebaseMessaging.requestPermission ;  //   requestNotificationPermissions();
//     _firebaseMessaging.configure(
//       onMessage: (message) async {
//         print("Message received: $message");
//       },
//     );
//   }

//   void sendNotification() async {
//     final message = {
//       'notification': {
//         'title': 'Notification Title',
//         'body': 'Notification Body',
//       },
//       'to': '/topics/all_devices', // Send to a topic or specific device
//     };

//     final response = await _firebaseMessaging.send(message);
//     print('Notification sent: $response');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firebase Notification App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             RaisedButton(
//               onPressed: () {
//                 requestNotificationPermissions();
//               },
//               child: Text("Request Notification Permissions"),
//             ),
//             SizedBox(height: 20),
//             RaisedButton(
//               onPressed: () {
//                 sendNotification();
//               },
//               child: Text("Send Notification"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
