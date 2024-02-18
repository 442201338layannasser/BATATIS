// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../provider/auth_provider.dart';
// import '/Customer_Widgets/All_customer_Widgets.dart';




// class CGroupOrder  extends StatefulWidget{
//    const CGroupOrder ({super.key});

//    @override
//    State<CGroupOrder > createState() => CGroupOrderState();
//  }

//  class CGroupOrderState extends State<CGroupOrder >{
   

//   @override
//   Widget build(BuildContext context) {
//      final ap = Provider.of<AuthProvider>(context, listen: false);
    
//    return Scaffold(appBar:CustomAppBar(),
//    body : 
//    Center(child: CustomText(text: "you dont have group order yet."  , type: 'paragraph',) ) 
//    );
//   }

//  }
import 'package:batatis/Costomer_Screens/All_Costomer_Screens.dart';
import 'package:batatis/provider/auth_provider.dart' as authp;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/Customer_Widgets/All_customer_Widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';




class CCurrentOrder extends StatefulWidget{
   const CCurrentOrder({super.key});
    
   @override
   State<CCurrentOrder> createState() => CCurrentOrderState();
 }

 class CCurrentOrderState extends State<CCurrentOrder>{
///////////////////////////////////////////////////////////////////////////aaaaaaaaaaaaaassssssssssssssssssshhhhhhhhhhhhh
///ash put the data here
void initState(){
  super.initState();  
  SharedPrefer.SetSharedPrefer();
}
 String Rname = ViewMenuToCustomerState.ResturantName.toString();///restaurant name from hind!!!!!!!!!!!!!!!!!!!!  
 String Olocation = "" ; 
  String rr = "" ;
String Rtoken="";
String token ="";

  double Dfee= double.parse(ViewMenuToCustomerState.ResturantFee.toString());
  String orderID =SharedPrefer.CurrentOrderId.toString();//should be stored when first created and also stored when joining
String userID = SharedPrefer.UserId.toString() ; //"1aScWEtYkThnRLTvCggJihuMkFu1";//should be stored when loged in ??? this is random
String status = SharedPrefer.status.toString() ;
     FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> getlocation() async {
  var OrdersRef =_firestore.collection('Orders').doc(orderID);
      var getOrders  = await OrdersRef.get();
      Olocation = getOrders.get("deleveryLocation");
              rr = getOrders.get("RestaurantID");

}
////////////////////sadeem//////////////////////////////////////
Future<void> getRToken() async {

  var rRef =await _firestore.collection("Restaurants").doc(rr).get();

       token = rRef.get("Token");
}
 ///////////////////////////////////////////////////////////////////////////////////////////////////

  var ap;//service provider auth with db info
  var _fireStoreInstance = FirebaseFirestore.instance;
bool? isLoggedIn ;  //check if the user log in (NOT WORKING)
    bool showB = false;
        bool showA = true;
        bool amInotconfirmed=true;
         bool amInotPlaced=true;
        bool amIcreator=false;
        bool allOrdersConfirmed=true;      
      String dateStr = "";
  String timeStr = "";

 late  bool isCreator ;//for memeber



double subtotal=0;
 double total=0;       

  Set<DocumentSnapshot> mySet = {};
  //List<String> names=[];


Future<void> islog() async{
    isLoggedIn = await ap.issignedin;
  }
Future<void> getOstatus() async{
var nn = await _fireStoreInstance.collection("Orders").doc(orderID).get();
if (  nn.get("status").toString() =="preparing")
     amInotPlaced=false;

  }
 
 

@override
  Widget build (BuildContext context) {

    if(SharedPrefer.CurrentOrderId != null ){
        isCreator = SharedPrefer.iscreator!;
        orderID =SharedPrefer.CurrentOrderId.toString();//should be stored when first created and also stored when joining
       userID = SharedPrefer.UserId.toString() ; 
    }
    else{
       isCreator = true;
       orderID =SharedPrefer.CurrentOrderId.toString();//should be stored when first created and also stored when joining
       userID = SharedPrefer.UserId.toString() ; 
    }

    
    getOstatus();
  Link.handleDynamicLinks(context);
   getlocation();
   getRToken();
 ap = Provider.of<authp.AuthProvider>(context, listen: false);
  DateTime today = DateTime.now();
   dateStr = "${today.day}/${today.month}/${today.year}";
  timeStr = "${today.hour}:${today.minute}";
  int numOfMembers=0;
  


 List<Widget> cards() {
  getOstatus();
  total=0; 
  subtotal=0;      
   List<Widget> cc = [];
  List<Widget> oo = [];
   List<dynamic> items = [];
List<dynamic> quantity = [];
List<dynamic> prices = [];
String namea = "";

bool confirmed=false;
bool creator=false;
allOrdersConfirmed=true; 
  today = DateTime.now();
 dateStr = "${today.day}/${today.month}/${today.year}";
  timeStr = "${today.hour}:${today.minute}";



int i = -1 ; 

 mySet = mySet.toSet() ; 
mySet.forEach((itemData)  {
        i= i+1 ; 
print("forEachssss ${mySet.length}");
     namea = itemData.get('name');
     items=itemData.get('items');
     quantity=itemData.get('quantity');
     prices=itemData.get('prices');
     confirmed=itemData.get('confirmed');
     if (confirmed==false){
     allOrdersConfirmed=false;
     }
     creator=itemData.get('creator');
     double msubtotal=0;

//////////////////////////////////
print(itemData.id);
if ((userID==itemData.id)&&confirmed){
amInotconfirmed=false;
if(creator)
amIcreator=true;

}

//////////////////////////////

     int j = -1 ; 
List<Widget> UserOrder() {
  List<Widget> ItemsDetails = [] ; 
     items.forEach((itemData)  {
           j= j+1 ; 
print(prices);

double w= prices[j]*quantity[j].toDouble()  ;
        msubtotal=msubtotal+w;


       ItemsDetails.add( 
            Container(
              margin: EdgeInsets.all(0),
             width: 370,
                 child: 
                 Padding(padding: EdgeInsets.only(
                                  left: 8, right: 8, bottom: 8, top: 8),
                 child:
               Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                 [CustomText(text:'x'+quantity[j].toString(),type: "paragraph"),
                   //  SizedBox(width: 80), // give it width
    Spacer(),

                 CustomText(text:items[j],type: "paragraph"),
                 //   SizedBox(width: 80), // give it width
    Spacer(),

                 CustomText(text:w.toString()+' SR',type: "paragraph"),
                  // Divider(
                  //                 color: Colors.grey,
                  //               ),
                 ])),),
      
       );

       }
       
      );
      subtotal=subtotal+msubtotal;
_fireStoreInstance.collection("Orders").doc(orderID).collection("Member").doc(itemData.id).update({'subtotal':msubtotal});

      return ItemsDetails ;   } 
      print("oo count ${oo.length}");
       cc.add(

         Container(
          child:
              Column(
                children: [
                  Container(
padding:EdgeInsets.only(left: 8,right: 8,),
                    color: Batatis_light.withOpacity(0.7),
                    child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children:[ 
                    //SizedBox(width:0.5)  ,     

                    Text(
                               namea,
                                style: TextStyle(
                                
                                    fontFamily: 'PoppinsMedium',
                                    fontSize: 16),
                              ),
                    confirmed?  Text(
                               "confirmed",
                                style: TextStyle(
                                  color: Colors.green,
                                    fontFamily: 'PoppinsMedium',
                                    fontSize: 12),
                              ):Text(
                               " not confirmed",
                                style: TextStyle(
                                    fontFamily: 'PoppinsMedium',
                                    color: red,
                                    fontSize: 12),
                              ),  
                             // SizedBox(width:2)  ,     
                    //CustomText(text: namea,type: "Subheading1B"),
                  //confirmed? CustomText(text:"confirmed",type: "Subheading1B"):CustomText(text:" not confirmed",type: "Subheading1B"),
                  ])
                  ),
                 Column( children:   UserOrder()   ),

                 Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(right: 1.0),
          child: Text(
            ' total: '+msubtotal.toString()+' SR',
            style: TextStyle(
                fontFamily: 'PoppinsMedium',
                fontStyle: FontStyle.normal,
               // fontWeight: FontWeight.w500,
                fontSize: 12,
                ),
          ),
        ),
      ),

         ],)
          //  width: 200,/////6.4 inch
          //  height: 230,//////
          //  padding: const EdgeInsets.all(8),
          //  margin:const EdgeInsets.all(10),
         
           ),
          
           );
               
                oo.clear() ; 

               });
           
        total=subtotal+Dfee;    
 mySet.clear() ; 
 
     return cc;
   }

  return   
    Scaffold(
      appBar: CustomAppBar(wantback: true ),
      body: 
      
       FutureBuilder(
  future: Future.wait([islog()]),
  builder: (BuildContext context, AsyncSnapshot<void> futureSnapshot) {
    if (futureSnapshot.connectionState == ConnectionState.waiting) {
      // If the Future is still running, return a loading indicator or some other widget.
      return CircularProgressIndicator();
    } else if (futureSnapshot.hasError) {
      // If the Future encountered an error, display an error message.
      return Text('Error: ${futureSnapshot.error}');
    } else {
      if(isLoggedIn!){
        print("logedin good");
      // If the Future completed successfully, you can start listening to a Stream.
      return StreamBuilder(
        stream: _fireStoreInstance.collection("Orders").doc(orderID).collection("Member").snapshots(),
         builder: (BuildContext context, snapshot) 
         {
          print("snapsho");
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is loading, show a loading indicator.
            print("wait");
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // If an error occurs, display an error message.
            return Text('no data' /*'Error: ${snapshot.error}'*/);
          }
          else   if (snapshot.hasData!) { 
            print("yes");
           

          QuerySnapshot querySnapshot =  snapshot.data! ;
          if(querySnapshot != null) {
            print("querySnapshot not null ${mySet.length}");
          mySet.clear() ; 
           print("before gooo ${querySnapshot.docs.length}");
            querySnapshot.docs.forEach((DocumentSnapshot doc) async {
                        print("gooo");
                        mySet.add(doc);
                        numOfMembers=numOfMembers+1;

                        
//                         names.add( await _fireStoreInstance
//     .collection('Customers')
//     .doc(doc.id)
//     .get()
//     .then((snapshot) {
//         if (snapshot.exists) { 
//             var user = snapshot.get('name');  
//             print("heelo")       ;
//             return user ;   
//  } 
//  print("noooo");
//  return 'no user';

//  })
//  );
                       
           });}
          // }return Text("no orders");
           
           }
          
          
          
          
           return 
            
           Stack(
                  clipBehavior: Clip.none,

        children: <Widget>[

              Positioned(
           //s bottom:10.0,
            left: 0.0,
            right: 0.0,
            top: 10,
            child: 
          
SingleChildScrollView(
  //child:SingleChildScrollView(
                  //  scrollDirection: Axis.vertical,

                child: Container(
                height: 480,
              // SingleChildScrollView(tion: Axis.vertical,
                  //scrollDirec
                  // child:
                  // SingleChildScrollView(
                //  child: Container(
                //                   height: 500,
               
              child:
               SingleChildScrollView(               

                  child:Padding(
            padding: const EdgeInsets.only(left: 13, right: 13, top: 0),
            child:           
                   



            Container(
                                //  height: 500,

            child: Column(
              children: [

                  Container(
                    width: 370,
padding: EdgeInsets.only(bottom: 5,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: 
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Note: the order can only be placed after the confirmation of the included orders. ",
                         maxLines: 2,
                         style: TextStyle(
                fontFamily: 'PoppinsMedium',
                fontStyle: FontStyle.normal,
               // fontWeight: FontWeight.w500,
                fontSize: 12,
                color: red,
                ),
                          //  overflow: TextOverflow.ellipsis,

                            ),
                             Divider(
                                  color: Colors.grey,
                                ),

                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8,top: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            
                            children: [


// SizedBox(
//       width: 50, //<-- SEE HERE
//     ),
//picture 

Container(child:
Column(children: [ 
  
                              Icon(
      Icons.restaurant,
      color: Batatis_Dark,
      size: 26.0,
    ),             

            Text(
                                "Restaurant",
                                style: TextStyle(
                                   // color: grey_light,
                                    fontFamily: 'PoppinsMedium',
                                          color: Batatis_Dark,
                                    fontSize: 14),
                              ),     
  
  Text(
                                Rname,
                                style: TextStyle(
                                    color: grey_Dark,
                                    fontFamily: 'PoppinsMedium',
                                    fontSize: 12),
                              ),     
      Text(
                                "",
                                style: TextStyle(
                                    fontSize: 12),
                              ),           
      
   Text(
                                "",
                                style: TextStyle(
                                    fontSize: 12),
                              ),           
      

                ],
                              
                              
                              ),),

// SizedBox(
//       width: 90, //<-- SEE HERE
//     ),
Column(children: [ 


  
  Icon(
      Icons.location_on ,
      color: Batatis_Dark,
      size: 26.0,
    ),             

            Text(
                                "Location",
                                style: TextStyle(
                                   // color: grey_light,
                                    fontFamily: 'PoppinsMedium',
                                          color: Batatis_Dark,
                                    fontSize: 14),
                              ),     
  Container(
    width: 80,
    child:
  Text(
                               Olocation,
                              // "ggggggggggggggggggggggggggggggggggggggggggggg",
                                maxLines: 3,
        overflow: TextOverflow.ellipsis, // new
                                style: TextStyle(
                                    color: grey_Dark,
                                    fontFamily: 'PoppinsMedium',
                                    fontSize: 12),
                              ),   )      
                              


                              ],),


Column(children: [  
  
  Icon(
      Icons.info ,
      color: Batatis_Dark,
      size: 26.0,
    ),  
    Text(
                                "Order Info",
                                style: TextStyle(
                                   // color: grey_light,
                                    fontFamily: 'PoppinsMedium',
                                          color: Batatis_Dark,
                                    fontSize: 14),
                              ), 
  
           numOfMembers>1?
Text(
                                'Group order',
                                style: TextStyle(
                                    color: grey_Dark,
                                    fontFamily: 'PoppinsMedium',
                                    fontSize: 12),
                              ):Text(
                                'single order',
                                style: TextStyle(
                                    color: grey_Dark,
                                    fontFamily: 'PoppinsMedium',
                                    fontSize: 12),
                              ),  
                             

Text(
                                dateStr,
                                style: TextStyle(
                                    color: grey_Dark,
                                    fontFamily: 'PoppinsMedium',
                                    fontSize: 12),
                              ),  
                              Text(
                                timeStr,
                                style: TextStyle(
                                    color: grey_Dark,
                                    fontFamily: 'PoppinsMedium',
                                    fontSize: 12),
                              ),  

                  ],
                              
                              
                              ),


Column(children: [ 
  
  Icon(
      Icons.payment ,
      color: Batatis_Dark,
      size: 26.0,
    ),             

            Text(
                                "Payement",
                                style: TextStyle(
                                   // color: grey_light,
                                    fontFamily: 'PoppinsMedium',
                                          color: Batatis_Dark,
                                    fontSize: 14),
                              ),     
  
  Text(
                                'creator pays',
                                style: TextStyle(
                                    color: grey_Dark,
                                    fontFamily: 'PoppinsMedium',
                                    fontSize: 12),
                              ),  
                              
  Text(
                                'cash on delivery',
                                style: TextStyle(
                                    color: grey_Dark,
                                    fontFamily: 'PoppinsMedium',
                                    fontSize: 12),
                              ),  
  
 
            Text(
                                '',
                                style: TextStyle(
                                    color: grey_Dark,
                                    fontFamily: 'PoppinsMedium',
                                    fontSize: 12),
                              ),              
                              
                              
                              
                              ],),
                        

                            ],
                            ),

                      
                ),


// SizedBox(
//       height: 10, //<-- SEE HERE
//     ),



                ])
                ),
                ),
                ),
                ),
                
            Container(
              width: 370,
              margin: EdgeInsets.only(top: 10,),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Members',
                                style: TextStyle(
                                    color: Batatis_Dark,
                                    fontFamily: 'PoppinsMedium',
                                    fontSize: 20),
                              ),
                              showB
                                  ? GestureDetector(
                                  onTap: () {
                                    print('false');
                                    setState(() {
                                      showB = false;
                                    });
                                  },
                                  child: Icon(
                                      Icons.keyboard_arrow_up_outlined))
                                  : GestureDetector(
                                  onTap: () {
                                    print('true');
                                    setState(() {
                                      showB = true;
                                    });
                                  },
                                  child: Icon(
                                      Icons.keyboard_arrow_down_outlined))
                            ],
                          ),
                        ),
                        showB
                            ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                              //  width: Width * 0.9,
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                            ),

                             // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 8, right: 8, bottom: 8, top: 2),
                              //child: 

                             SingleChildScrollView(
                    
                    child:
                              
                              
                              Container(
                                height: 180,
                                child:
                                 SingleChildScrollView(
                    child:

                                Container(
                                  height: 180,
                 
                    child:
                               SingleChildScrollView(
                    child:
                                Container(
                                 // height: 240,

                                  child: 
                                
                                
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                 StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Orders')
                  .doc(orderID)
                  .collection("Member")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                final members = snapshot.data!.docs;
                print("isCreator $isCreator");
                return isCreator
                    ? Column(
                        children: members.map((memberDoc) {
                          final memberData = memberDoc.data();
                          final isCre = memberData['creator'] == true;
                          

                          return ListTile(
                            leading: Icon(Icons.account_circle, color: Batatis_Dark,),
                            title: Row(
                            children: [
                                Text(memberData['name']) , (isCre) ?   Text(' (Host)') :  Text(""),
                               //if (isCre) Text(' (Host)'), // Display "Host" for creator
                         ],
                            ),
                            trailing: !isCre
                                ?
                                GestureDetector(
                                    onTap: () {
                                      
                                      // Show confirmation dialog with member name
                                      showDeleteConfirmationDialog(context, memberDoc.id, memberData['name']);
                                    },
                                    child: Icon(Icons.close,color: Batatis_Dark,),
                                  )
       
                       : null 
                          );
                        }).toList(),
                      )
                    : Column(
                        children: members.map((memberDoc) {
                          final memberData = memberDoc.data();
                          final isCre = memberData['creator'] == true;
                          return ListTile(
                            leading: Icon(Icons.account_circle , color: Batatis_Dark,),
                            title:   Row(
                            children: [
                                Text(memberData['name']) , (isCre) ?   Text(' (Host)') :  Text(""),
                               //if (isCre) Text(' (Host)'), // Display "Host" for creator
                         ],
                            ),
                          );
                        }).toList(),
                      );
              },
            ),      




                 

                 
                                   
                                  ],
                                ),
                              ),),
                            ))))
                          ],
                        )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
            ),
//             SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
// child:
            Container(
              width: 370,
              margin: EdgeInsets.only(top: 10,bottom: 40,),
              decoration: BoxDecoration(
               color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Orders',
                                style: TextStyle(
                                    color: Batatis_Dark,
                                    fontFamily: 'PoppinsMedium',
                                    fontSize: 20),
                              ),
                              showA
                                  ? GestureDetector(
                                  onTap: () {
                                    print('false');
                                    setState(() {
                                      showA = false;
                                    });
                                  },
                                  child: Icon(
                                      Icons.keyboard_arrow_up_outlined))
                                  : GestureDetector(
                                  onTap: () {
                                    print('true');
                                    setState(() {
                                      showA = true;
                                    });
                                  },
                                  child: Icon(
                                      Icons.keyboard_arrow_down_outlined))
                            ],
                          ),
                        ),
                        showA
                            ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                              //  width: Width * 0.9,
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 8, right: 8, bottom: 8, top: 2),
                              //child: 
                              SingleChildScrollView(
                    child:
                              Container(
                                height: 180,
                              
                               child: 
                                 SingleChildScrollView(
                    child:

                                Container(
                                  height: 180,
                 
                    child:
                      SingleChildScrollView(
                    child:
                                Container(
                                 // height: 240,

                                  child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: 
                                cards(),)

                               //  [] ,
                                //)
                             //   )
                                ),)))
                              ),)
                          //  )
                          ],
                        )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
            ),

            //),
            ],
            ),
          ),
                      ),)
                      )
          //),
          )),
          Positioned(
            bottom:5.0,
            left: 0.0,
            right: 0.0,
           // top: 30,
            child: 
         
          Container(
            width: 370,
            padding: EdgeInsets.only(top:20,left: 30,right: 30,bottom: 5),
              decoration: BoxDecoration(
               color: Colors.white,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(40),topRight:Radius.circular(40),),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 6,
                    blurRadius: 4,
                    offset: Offset(6,0), // changes position of shadow
                  ),
                ],
              ),
child:  
Column(
children: [

Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 1.0),
          child: Text(
            'Subtotal: '+subtotal.toString()+' SR',
            style: TextStyle(
                fontFamily: 'PoppinsMedium',
                fontStyle: FontStyle.normal,
               // fontWeight: FontWeight.w500,
                fontSize: 14,
                ),
          ),
        ),
      ),

Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 1.0),
          child: Text(
            'Delivery fee: '+Dfee.toString()+ ' SR',
            style: TextStyle(
                fontFamily: 'PoppinsMedium',
                fontStyle: FontStyle.normal,
               // fontWeight: FontWeight.w500,
                fontSize: 14,
                ),
          ),
        ),
      ),

Divider(
      color: Colors.grey,
                                ),
Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 1.0, bottom: 10),
          child: Text(
            'Total: '+total.toString()+' SR',
            style: TextStyle(
                fontFamily: 'PoppinsMedium',
                fontStyle: FontStyle.normal,
               // fontWeight: FontWeight.w500,
                fontSize: 20,
                ),
          ),
        ),
      ),


amInotconfirmed?
              CustomButton(
                text: "confirm",
                /*width:20,*/ onPressed: () {
                   showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Confirm orders'),
                      content: const Text(
                          'Are you sure you want to confirm your orders'),
                      actions: <Widget>[
                         TextButton(
                          onPressed: () =>  Navigator.pop(
                             context,
                          ),
                          child:  Text('cancel',
                           style: TextStyle(
                color: Batatis_Dark,
                ),
                           
                          ),
                        ),
                        TextButton(
                          onPressed: () => {
                           _fireStoreInstance.collection("Orders").doc(orderID).collection("Member").doc(userID).update({'confirmed':true}),

                           print("confiiiirmmmmmmm"),
                            Navigator.pop(
                              context,
                            ),
                           // reload(),
                          },
                          child:   Text('confirm',
                          style: TextStyle(
                color: Batatis_Dark,
                ),
                          
                          ),
                        ),
                      ],
                    ),
                  );
                },
                type: 'confirm',
                // height: 0.03,
                // width: 0.07,
              ):amIcreator?
              
              amInotPlaced?
              
              CustomButton(
                text: "Place order",
                /*width:20,*/ onPressed: () {
                   showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Confirm placing the order'),
                      content: const Text(
                          'Are you sure you want to place your order'),
                      actions: <Widget>[
                         TextButton(
                          onPressed: () =>  Navigator.pop(
                             context,
                          ),
                          child:  Text('cancel',
                            style: TextStyle(
                color:Batatis_Dark ,
                ),
                          
                          
                          ),
                        ),
                        TextButton(
                          onPressed: () => {

    print("Orders/ $orderID  hereoooo is the path"),               
 if (allOrdersConfirmed){
  print("Orders/ $orderID  here is the path"),
_fireStoreInstance.collection("Orders").doc(orderID).update({'status':'preparing'}),
SharedPrefer.SetStatus(orderID, "preparing"),
 
//CurrentOrderId 
// _fireStoreInstance.collection("Orders").doc(orderID).update({'Total':total}),
                              
//                                    moveRoute(context, "/RBHomePageAdd");
//                                 Navigator.pushNamed(context, "/SignInPage");return Text(" "); }

ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(

            content: Text("the order is placeed successfully"),

            backgroundColor: Colors.green, // Customize the Snackbar's appearance.

          ),

        ),
            


                            }

else {ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(

            content: Text("all the orders must be confirmed first"),

            backgroundColor: Colors.red, // Customize the Snackbar's appearance.

          ),

        ),},
                           
                               
                            Navigator.pop(
                              context,
                            ),
                           // reload(),
                          },
                          child:   Text('confirm',
                              style: TextStyle(
                color:Batatis_Dark ,
                ),
                         
                          ),
                        ),
                      ],
                    ),
                  );
                },
                type: 'confirm',
                // height: 0.03,
                // width: 0.07,
              ):Container():Container(),           

  
],

),

),
          ), 
          
          
          
          
          ]);
// 
// 
        
          }

          
          
          
           
         
);
         }  else {return Text(" ");} }
         
         
         
         
         }),);
         
         }



  void showDeleteConfirmationDialog(BuildContext context, String memberId, String memberName) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Confirm remove memebr'),
          content: Text('Are you sure you want to remove $memberName?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the confirmation dialog
                Navigator.of(dialogContext).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Close the confirmation dialog
                Navigator.of(dialogContext).pop();
                // Call the removeMember method to delete the member
                removeMember(memberId);
              },
              child: Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
  removeMember(String memberId) {
    FirebaseFirestore.instance
        .collection('Orders')
        .doc(orderID)
        .collection("Member")
        .doc(memberId)
        .delete();
  }
 }//class

 