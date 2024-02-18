import 'package:shared_preferences/shared_preferences.dart';

class sharedPref{
static Future<void> setUserLoggedIn(bool value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('loggedIn', value);
}

static Future<bool> isUserLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('loggedIn') ?? false;
}}

class RSharedPref {
  static bool? Islogin = false;
  static String? RestId = "";
  static String? RestToken = "";
  
  static String? RestName = "";
  static String? RestEmail = "";

  static String? RestAddress = "";
  static String? RestLat = "";
  static String? RestLong = "";
  
  static int? OrdersId = 0;
  static int? numOfOrders = 0;

  //static String? CurrentOrderId = "";
  //static bool? iscreator = false;
  //static String? status = "";
  //static String? CurrentOrderResturantId = "" ; 
  //static int? numOfOrders = 0;

  // static int? CurrentOrderNumber = 0 ; 

  static Future SetSharedPrefer() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    Islogin = await s.getBool("Islogin") == null ? false :await s.getBool("Islogin") ;
    RestId = await s.getString("RestId");
    RestToken = await s.getString("RestToken");
    RestEmail = await s.getString("RestEmail");
    RestAddress = await s.getString("RestAddress");
    RestLat = await s.getString("RestLat");
    RestLong = await s.getString("RestLong");
    OrdersId = await s.getInt("OrdersId");
    numOfOrders = await s.getInt("numOfOrders");

    // CurrentOrderId = await s.getString("CurrentOrderId");
    // iscreator = await s.getBool("iscreator");
    // status = await s.getString("status");
    // numOfOrders = await s.getInt("numOfOrders");

    // CurrentOrderResturantId= await s.getString("CurrentOrderResturantId");
    printPrefrenses();
  }

  static Future SetLogin(String RestIdd, restEmail ) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setBool("Islogin", true);
    Islogin = true;
    print("object $RestId");
    await s.setString("RestId", RestIdd);
    RestId = RestIdd;
    // await s.setString("RestToken", RestToken);
    // RestToken = RestToken;
    await s.setString("RestEmail", restEmail);
    RestEmail = restEmail;
   
    printPrefrenses();
  }
   static Future SetToken(RestToken ) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("RestToken", RestToken);
    RestToken = RestToken;
    printPrefrenses();
  }

  static Future SetRestLocation(String address, String lat, String long) async {
    SharedPreferences s = await SharedPreferences.getInstance();

    await s.setString("RestAddress", address);
    RestAddress = address;
    await s.setString("RestLat", lat);
    RestLat = lat;
    await s.setString("RestLong", long);
    RestLong = long;
    printPrefrenses();
  }

static Future setOrdersIDs()async{
    SharedPreferences s = await SharedPreferences.getInstance();
    
    OrdersId = (OrdersId! + 1) ; 
    await s.setInt("OrdersId", OrdersId!);
    OrdersId = OrdersId;
}

static Future SetNumOfOrders( int anumOfOrders ) async {
    SharedPreferences s = await SharedPreferences.getInstance();

    await s.setInt("numOfOrders", anumOfOrders);
    numOfOrders = anumOfOrders;
   
  }
//   static Future SetCurrentOrder(
//       String Orderid, bool Iscreator, String sstatus , restId) async {
//     SharedPreferences s = await SharedPreferences.getInstance();
//     await s.setString("CurrentOrderId", Orderid);
//     CurrentOrderId = Orderid;
//     await s.setBool("iscreator", Iscreator);
//     iscreator = Iscreator;
//     await s.setString("status", sstatus);
//     status = sstatus;
//     await s.setString("CurrentOrderResturantId", restId);
//     CurrentOrderResturantId = restId;
//     printPrefrenses();
//   }

//    static Future DeleteCurrentOrder() async {
//     SharedPreferences s = await SharedPreferences.getInstance();
//    // await s.setString("CurrentOrderId", "");
//    await s.remove("CurrentOrderId");
//     CurrentOrderId = null ; //"";
//     await s.setBool("iscreator", false);
//     iscreator =false;
//     await s.setString("status", "");
//     status = "";
//     await s.setInt("numOfOrders", 0);
//     numOfOrders = 0;
//      await s.setString("CurrentOrderResturantId", "");
//     CurrentOrderResturantId = "";
//     printPrefrenses();
//   }

//   static Future SetStatus(
//       String Orderid, /*bool Iscreator*/ String sstatus ) async {
//     SharedPreferences s = await SharedPreferences.getInstance();
//     await s.setString("CurrentOrderId", Orderid);
//     CurrentOrderId = Orderid;
//     // await s.setBool("iscreator", Iscreator);
//     // iscreator = Iscreator;
//     await s.setString("status", sstatus);
//     status = sstatus;
//     //  await s.setString("CurrentOrderResturantId", restId);
//     // CurrentOrderResturantId = restId;
//     printPrefrenses();
//   }

//  static Future SetNumOfOrders( int anumOfOrders ) async {
//     SharedPreferences s = await SharedPreferences.getInstance();

//     // await s.setBool("iscreator", Iscreator);
//     // iscreator = Iscreator;
//     await s.setInt("numOfOrders", anumOfOrders);
//     numOfOrders = anumOfOrders;
//     //  await s.setString("CurrentOrderResturantId", restId);
//     // CurrentOrderResturantId = restId;
//     printPrefrenses();
//   }

  static Future SetSignedOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();

    Islogin = false;
    await s.setBool("Islogin", false);
    RestId = "";
    await s.setString("RestId", "");
    RestEmail = "";
    await s.setInt("RestName", 0 );
    RestName = "";
     await s.setString("RestToken", "");
    RestToken = "";
    await s.setString("RestEmail", "");
    RestAddress = "";
    await s.setString("RestAddress", "");
    RestLat = "";
    await s.setString("RestLat", "");
    RestLong = "";
    await s.setString("RestLong", "");
    // CurrentOrderId = "";
    // await s.setString("CurrentOrderId", "");
    // iscreator = false;
    // await s.setBool("iscreator", false);
    // status = "";
    // await s.setString("status", "");
    //  numOfOrders = 0;
    // await s.setInt("numOfOrders", 0);
    // CurrentOrderResturantId = "" ; 
    // await s.setString("CurrentOrderResturantId", "");
    printPrefrenses();
  }

  static void printPrefrenses() {
    print(
        "Shared Prefrenses updates Islogin : $Islogin / RestId : $RestId / RestName:$RestName / RestEmail : $RestEmail / RestAddress :$RestAddress / RestLat: $RestLat /RestLong: $RestLong  / token : $RestToken");
  }
}
