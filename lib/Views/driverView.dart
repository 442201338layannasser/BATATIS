//import 'package:batatis/RestaurantBranch_Widgets/All_RB_Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
import 'package:batatis/Costomer_Screens/All_Costomer_Screens.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../RestaurantBranch_Screens/toaddress.dart';
import '../moudles/Orders.dart';
import '../provider/auth_provider.dart';


class DriverPage extends StatefulWidget {
  const DriverPage({Key? key , this.orderid }) : super(key: key);
  final orderid ; 
  @override
  State<DriverPage> createState() => DriverPageState();
}

class DriverPageState extends State<DriverPage>{
   Set<Marker> userMarkers = {Marker(markerId: MarkerId("Delivering"),)};
   var payment = "Paid!" ; 
   var total = "225" ; 
   var contactNumber = "+996 553132177" ; 
   var Clatitude = "24.734247782421782";
   var Clongitude ="46.61258160455868" ;
   var Address = "PJGG+F5P, King Saud University, Riyadh 12372, Saudi Arabia";
   late Orders Order ;  
   void initState(){
      super.initState();
  //  fetchOrder();
   }
   Future<void> fetchOrder() async {
   
    Order = (await Orders.getOrder(widget.orderid))!;
   await getcor(Order.deleveryLocation);
   }
  @override
  Widget build(BuildContext context) {
 print("buliding viewdriver");
    return Scaffold(
      appBar: CustomAppBar(
        wantback: true,
      ),
body:

 FutureBuilder(
      future: fetchOrder(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Display a loading indicator while waiting for data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Data has been successfully fetched, dis
return Center(
  child: Column (
  //  mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
    SizedBox(height: 30,),
    CustomText(text : "OrderID : #${Order.orderId}",type: "heading",),
    SizedBox(height: 30,),
LocationPicker(
                        width: 300.0,
                        height: 300.0,
                        markers: userMarkers,
                        selfPin: 0.0,
                      ),
                      TextButton(child: Text("get directions",style: TextStyle( decoration: TextDecoration.underline,color: black),) , onPressed: (){getTodireactions();  },),
    //CustomText(text : "Order details",type: "heading",),  Row(children: [ Icon(Icons.money_outlined,size: 35 ) ,
SizedBox(height: 40,),
Column(children: [ CustomText(text : " ${Order.Total} SR   ",color: black,fontSize: 24) 
,CustomText(text : "${Order.PaymentMethod !="Paid" ?"(Cash on delievery) ": "(Paid)"}",
color: Order.PaymentMethod !="Paid" ? black : green
,fontSize: 24,),

],),
   SizedBox(height: 30,),
    // Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
    //   children: [
    //   Column(children: [ Icon(Icons.call,size: 35,), Icon(Icons.payment,size: 35) ,Icon(Icons.money_outlined,size: 35),], crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,),
    //    Column(children: [   TextButton(onPressed: (){_launchPhoneApp(Order.number);}, child:  Text(": ${Order.number}", style: TextStyle( color: black,fontSize: 24, decoration: TextDecoration.underline,))) ,CustomText(text : ": ${Order.PaymentMethod !="Paid" ?"Cash on delievery ": "Paid"}",color: black,fontSize: 24,) , CustomText(text : ": ${Order.Total} SR",color: black,fontSize: 24),] , crossAxisAlignment: CrossAxisAlignment.start)
    // ],)
    // // CustomText(text : "contact number :",type: "heading",),
    // // CustomText(text : "$contactNumber",color: black,fontSize: 24,) ,
    // //  CustomText(text : "payment :",type: "heading",) ,
    // // CustomText(text : "$payment",color: black,fontSize: 24,) ,
   
    // //   CustomText(text : "Total:",type: "heading",),
    
    // //  CustomText(text : "$total",color: black,fontSize: 24)
    // .
    // Row(//mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //   Column(children: [  CustomText(text : "contact number :",type: "heading",), CustomText(text : "payment :",type: "heading",) , CustomText(text : "Total:",type: "heading",),], crossAxisAlignment: CrossAxisAlignment.end,),
    //    Column(children: [  CustomText(text : "$contactNumber",color: black,fontSize: 24,) ,CustomText(text : "$payment",color: black,fontSize: 24,) , CustomText(text : "$total",color: black,fontSize: 24),] , crossAxisAlignment: CrossAxisAlignment.start)
    // ],)
  
CustomButton(text: "Call customer", onPressed: (){_launchPhoneApp(Order.number);},type: "confirm",width: 180,height: 40)
    ,//SizedBox(height: 0,),
  CustomButton(text: "Delivered", onPressed: (){ 
statusDelivered();
Navigator.push(context, 
MaterialPageRoute(builder: (context) => CSignIn() ));
  },type: "confirm",width: 180,height: 40)                
  ]),
);}}),
    );
  }

void statusDelivered(){
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
     var OrderRef = _firestore.collection('Orders').doc(widget.orderid).update({"status" :"Delivered" }) ; 

}
Future<void> getcor  (address) async {

  var cor = await getCoordinatesFromAddressUsingGoogleMapsAPI(address);
   Clatitude = cor["latitude"].toString();
   Clongitude = cor["longitude"].toString();
   userMarkers = {Marker(markerId: MarkerId("Delivered") ,position :LatLng(double.parse(Clatitude), double.parse(Clongitude)) )};
    LocationPicker.value = LatLng(double.parse(Clatitude), double.parse(Clongitude));
    }
 
 void getTodireactions  () async {
 String url =  'google.navigation:q=$Clatitude,$Clongitude&mode=d' ;
 // String url =  'google.navigation:q=${Order.deleveryLocation}&mode=d' ;
_launchURL(url);

}
void _launchURL(String url) async {

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
void _launchPhoneApp(String phoneNumber) async {
  String url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    // Handle error
    print('Could not launch $url');
  }
}


  
}