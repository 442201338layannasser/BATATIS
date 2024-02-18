import 'package:flutter/material.dart';
import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
import 'package:batatis/Costomer_Screens/All_Costomer_Screens.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';

class CHomePage extends StatefulWidget {
  const CHomePage({Key? key}) : super(key: key);

  @override
  State<CHomePage> createState() => CHomePageState();
}

class CHomePageState extends State<CHomePage>
    with SingleTickerProviderStateMixin {
  late Widget Thebody;
  static int _currentIndex = 0;
  static late StateSetter s;
  final List<Widget> _views = [
    Cmainpage(),
    COrder(),
    CSettings(),
    // CCurrentOrder(),

    //  ViewMenuToCustomer()
  ];

  late TabController _tabController = TabController(length: 4, vsync: this);

  void initState() {
    super.initState();
    //_tabController
  }

  void changeTap(index) {
    setState(() {
      print("index changes ${Navigator.canPop(context)}");
      print("index changes $index");

      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static void changetab(n) {
    _currentIndex = n;
  }

  Set<Marker> userMarkers = {};

  Widget build(BuildContext context) {
    // Link.handleDynamicLinks(context);
    print("bulidookkoko");
    final ap = Provider.of<AuthProvider>(context, listen: false);
    Image.asset('assets/Images/Batatis_logo.jpeg');
    return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   backgroundColor: Batatis_Dark,
        //   title: Image.asset(
        //     'assets/Images/Batatis_logo.jpeg',
        //     width: 140,
        //     height: 130,
        //   ),

        //   actions:
        // ),

        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          fixedColor: Batatis_Dark,
          unselectedItemColor: grey_Dark,
          // indicatorSize: TabBarIndicatorSize.tab,
          // indicatorPadding: EdgeInsets.all(5.0),
          // indicatorColor: Batatis_Dark,
          onTap: (index) {
            changeTap(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: 'Orders',
            ),
            // BottomNavigationBarItem(
            //  icon: Icon(Icons.shopping_cart_outlined),
            //   label: 'Order',
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
        ),

        // TabBar(
        //   controller: _tabController,
        //   labelColor: Batatis_Dark,
        //   unselectedLabelColor: grey_Dark,
        //   indicatorSize: TabBarIndicatorSize.tab,
        //   indicatorPadding: EdgeInsets.all(5.0),
        //   indicatorColor: Batatis_Dark,
        //   tabs: [
        //     Tab(
        //       text: "Home",
        //       icon: Icon(Icons.home_outlined),
        //     ),
        //     Tab(
        //       text: "Orders",
        //       icon: Icon(Icons.list_alt_outlined),
        //     ),
        //     Tab(
        //       text: "Group",
        //       icon: Icon(Icons.supervised_user_circle),
        //     ),
        //     Tab(
        //       text: "Options",
        //       icon: Icon(Icons.settings),
        //     ),
        //   ],
        // ),

        body: _views[_currentIndex]
        //  Navigator(
        //   onGenerateRoute: (settings) {
        //     print("onGenerateRoute");
        //     return MaterialPageRoute(
        //       builder: (context) => _views[_currentIndex],
        //     );
        //   },
        // )
        // TabBarView(
        //   controller: _tabController,
        //   children: [
        //     Cmainpage(),
        //     COrder(),
        //     CGroupOrder(),
        //     CSettings(),
        //   ],
        // ),
        );
  }

// }  Widget PickLocationDilog(){
//     return
}
