import 'package:shared_preferences/shared_preferences.dart';

import '../moudles/Orders.dart';

class SharedPrefer {
  static bool? Islogin = false;
  static String? UserId = "";
  static String? UserToken = "";

  static String? UserName = "";
  static String? UserPhoneNumber = "";

  static String? UserAddress = "";
  static String? UserLat = "";
  static String? UserLong = "";

  static String? CurrentOrderId = "";
  static bool? iscreator = false;
  static String? status = "";
  static double? total = 0;
  static String? CurrentOrderResturantId = "";
  static int? numOfOrders = 0;

  // static int? CurrentOrderNumber = 0 ;

  static Future SetSharedPrefer() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    Islogin =
        await s.getBool("Islogin") == null ? false : await s.getBool("Islogin");
    UserId = await s.getString("UserId");
    UserToken = await s.getString("UserToken");
    UserPhoneNumber = await s.getString("UserPhoneNumber");
    UserAddress = await s.getString("UserAddress");
    UserLat = await s.getString("UserLat");
    UserLong = await s.getString("UserLong");
    CurrentOrderId = await s.getString("CurrentOrderId");
    iscreator = await s.getBool("iscreator");
    status = await s.getString("status");
    numOfOrders = await s.getInt("numOfOrders");
     total = await s.getDouble("total");

    CurrentOrderResturantId = await s.getString("CurrentOrderResturantId");
    printPrefrenses();
  }

  static Future SetLogin(
      String Userid, Username, usertoken, phonenumber) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setBool("Islogin", true);
    Islogin = true;
    await s.setString("UserId", Userid);
    UserId = Userid;
    await s.setString("UserToken", usertoken);
    UserToken = UserToken;
    await s.setString("UserName", Username);
    UserName = Username;
    await s.setString("UserPhoneNumber", phonenumber);
    UserPhoneNumber = phonenumber;
    await s.setInt("numOfOrders", 0);
    numOfOrders = 0;
    printPrefrenses();
  }

  static Future SetUserLocation(String address, String lat, String long) async {
    SharedPreferences s = await SharedPreferences.getInstance();

    await s.setString("UserAddress", address);
    UserAddress = address;
    await s.setString("UserLat", lat);
    UserLat = lat;
    await s.setString("UserLong", long);
    UserLong = long;
    printPrefrenses();
  }

  static Future SetCurrentOrder(
      String Orderid, bool Iscreator, String sstatus, restId,totall) async {
        print("SetCurrentOrder $Orderid");
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("CurrentOrderId", Orderid);
    CurrentOrderId = Orderid;
    await s.setBool("iscreator", Iscreator);
    iscreator = Iscreator;
    await s.setString("status", sstatus);
    status = sstatus;
    await s.setString("CurrentOrderResturantId", restId);
    CurrentOrderResturantId = restId;
await s.setInt("numOfOrders", 0);
    numOfOrders = 0;
     await s.setDouble("total", totall);
    total = totall;
    printPrefrenses();
  }

  static Future DeleteCurrentOrder() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    // await s.setString("CurrentOrderId", "");
    await s.remove("CurrentOrderId");
    CurrentOrderId = null; //"";
    await s.setBool("iscreator", false);
    iscreator = false;
    await s.setString("status", "");
    status = "";
    await s.setInt("numOfOrders", 0);
    numOfOrders =0;
    await s.setString("CurrentOrderResturantId", "");
    CurrentOrderResturantId = "";
    await s.setDouble("total", 0);
    total = 0;
    printPrefrenses();
  }

  static Future SetStatus(
      String Orderid, /*bool Iscreator*/ String sstatus) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("CurrentOrderId", Orderid);
    CurrentOrderId = Orderid;
    await s.setString("status", sstatus);
    status = sstatus;
    printPrefrenses();
  }


  static Future Settotal(double totall) async {
    SharedPreferences s = await SharedPreferences.getInstance();

    // iscreator = Iscreator;
    await s.setDouble("total", totall);
    total = totall;
    //  await s.setString("CurrentOrderResturantId", restId);
    // CurrentOrderResturantId = restId;
    printPrefrenses();
  }
  // static Future SetNumOfOrders(int anumOfOrders) async {
  //   SharedPreferences s = await SharedPreferences.getInstance();

  //   // await s.setBool("iscreator", Iscreator);
  //   // iscreator = Iscreator;
  //   await s.setInt("numOfOrders", anumOfOrders);
  //   numOfOrders = anumOfOrders;
  //   //  await s.setString("CurrentOrderResturantId", restId);
  //   // CurrentOrderResturantId = restId;
  //   printPrefrenses();
  // }
  static Future incNumOfOrders() async {
    SharedPreferences s = await SharedPreferences.getInstance();

    // await s.setBool("iscreator", Iscreator);
    // iscreator = Iscreator;
   numOfOrders = numOfOrders! + 1;
    await s.setInt("numOfOrders", numOfOrders!);
    
    //  await s.setString("CurrentOrderResturantId", restId);
    // CurrentOrderResturantId = restId;
    printPrefrenses();
  }
    static Future decNumOfOrders() async {
    SharedPreferences s = await SharedPreferences.getInstance();

    // await s.setBool("iscreator", Iscreator);
    // iscreator = Iscreator;
    
   numOfOrders = numOfOrders! - 1;
    await s.setInt("numOfOrders", numOfOrders!);
    
    //  await s.setString("CurrentOrderResturantId", restId);
    // CurrentOrderResturantId = restId;
    printPrefrenses();
  }

  static Future SetSignedOut() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    if(CurrentOrderId != null || CurrentOrderId == "" ){
      Orders.delteOrder(CurrentOrderId);
      DeleteCurrentOrder();
    }

    Islogin = false;
    await s.setBool("Islogin", false);
    UserId = "";
    await s.setString("UserId", "");
    UserPhoneNumber = "";
    await s.setString("UserToken", "");
    UserToken = "";
    await s.setString("UserPhoneNumber", "");
    UserAddress = "";
    await s.setString("UserName", "");
    UserName = "";
    await s.setString("UserAddress", "");
    UserLat = "";
    await s.setString("UserLat", "");
    UserLong = "";
    await s.setString("UserLong", "");
    CurrentOrderId = "";
    await s.setString("CurrentOrderId", "");
    iscreator = false;
    await s.setBool("iscreator", false);
    status = "";
    await s.setString("status", "");
    numOfOrders = 0;
    await s.setInt("numOfOrders", 0);
    total = 0;
    await s.setInt("total", 0);
    CurrentOrderResturantId = "";
    await s.setString("CurrentOrderResturantId", "");
    printPrefrenses();
  }

  static void printPrefrenses() {
    print(
        "Shared Prefrenses updates Islogin : $Islogin / UserId : $UserId / UserName:$UserName / UserPhoneNumber : $UserPhoneNumber / UserAddress :$UserAddress / UserLat: $UserLat /UserLong: $UserLong / CurrentOrderId :$CurrentOrderId / iscreator:$iscreator / status:$status / rest : $CurrentOrderResturantId / token : $UserToken / numm : $numOfOrders / total : $total");
  }
}
