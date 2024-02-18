import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Costomer_Screens/ViewMenuToCustomer.dart';
import 'RB.dart';
import 'memberItems.dart';

class Orders {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
   late  String orderId;
   late  String creatorId;
   late  RB Restaurantobj;
   late  String name;
   late  String number;
   late  String PaymentMethod;
   late  String Token ; 
   late  String deleveryLocation;
   late  String RestaurantID;
   late  String OrderTime;
   late  String Total;
   late  String status;
   late Map<String,MemberItems> ItemsWithMembers ; 
   late MemberItems AllItems ; 
     Orders.basic(  
      this.orderId , 
      String this.creatorId,
          RB this.Restaurantobj,
     //String name,
     //String Token , 
     String this.number,
     String this.PaymentMethod,
     String this.deleveryLocation,
     String this.RestaurantID,
     String this.OrderTime,
     String this.Total,
     String this.status,
    
     );
     Orders.allItems( 
      this.orderId , 
       String this.creatorId,
        RB this.Restaurantobj,
     //String name,
     //String Token , 
     String this.number,
     String this.PaymentMethod,
     String this.deleveryLocation,
     String this.RestaurantID,
     String this.OrderTime,
     String this.Total,
     String this.status,
     this.AllItems ,
    
     );
  
   Orders.ItemsWithMembers( 
    this.orderId , 
     String this.creatorId,
      RB this.Restaurantobj,
     //String name,
     //String Token , 
     String this.number,
     String this.PaymentMethod,
     String this.deleveryLocation,
     String this.RestaurantID,
     String this.OrderTime,
     String this.Total,
     String this.status,
     this.ItemsWithMembers,
     );

  static Future<String> addorder({
    required String creatorId,
    required String name,
    required String number,
    required String Token , 
    required String deleveryLocation,
    required String RestaurantID,
    required String OrderTime,
    required String Total,
    required String status,
  }) async {
    print("S>>>>>>>>>>A>A>S");
    final OrdersRef = _firestore.collection('Orders').doc();
    var OrderId = OrdersRef.id;
  RB Resturant = await RB.getRest(RestaurantID);


    print("addordeddryyyyyyyyyyyyyy " );
    print("addordeddrxxxxxxxxxxxxxx ${Resturant.resturantName}" );
    OrdersRef.set({
      "Restaurant" : Resturant.toJson(),
      "ContactNum":number,
      "Creator": creatorId,
      "deleveryLocation": deleveryLocation,
      "RestaurantID": RestaurantID,
      "OrderTime": OrderTime,
      "Total": 0,
      "PaymentMethod":"none",
      "status": status,
      "tokens": [Token]
    });

    var memberRef =
        _firestore.collection('Orders/$OrderId/Member').doc(creatorId).set({
      "name": name,
      "creator": true,
      "items": [],
      "quantity": [],
      "prices": [],
      "subtotal": 0,
      "confirmed": false
    });
    SharedPrefer.SetCurrentOrder(OrderId, true, "ongoing", RestaurantID,0.0);
    return OrderId;
  }

  static Future<void> addMemberToOrder(OrderId, MemberId, name, RestaurantID,token) async {
    print("OrderId $OrderId");
    var memberRef =   _firestore.collection('Orders/$OrderId/Member').doc(MemberId).set({
      "name": name,
      "creator": false,
      "confirmed": false,
      "items": [],
      "quantity": [],
      "prices": [],
      "subtotal": 0
    });
    var orderRef = _firestore.collection('Orders').doc(OrderId) ; 
    var qurey = await orderRef.get();
    var tokens = qurey.get("tokens");
    tokens.add(token);
    
   orderRef.update({
    "tokens":tokens
   });

    
    SharedPrefer.SetCurrentOrder(OrderId, false, "ongoing", RestaurantID,0.0);
  }

  static Future<bool> addMemberItems(
      OrderId, MemberId, Items, Iquantity, Iprices) async {
    try {
     //SetNumOfOrders(SharedPrefer.numOfOrders! + 1);
      var memberRef =
          _firestore.collection('Orders/$OrderId/Member').doc(MemberId);
      var qurey = await memberRef.get();

      var Cprices = qurey.get("prices");
      var Cquantity = qurey.get("quantity");
      var Citems = qurey.get("items");
      print("item add ${Citems.indexOf("Cheesje  Nachos")} ");

    

      /////////////
      var index = Citems.indexOf(Items);
      if (index != -1) {
        // item already exisit (change the quantity only )
        print("item already exist");
        Cquantity[index] = Cquantity[index] + Iquantity;
      } else {
         SharedPrefer.incNumOfOrders();
        print("item is new${Citems.runtimeType} hmm $Items ");
        //var temp = Citems + Items ;
        Citems.add(Items);
        print(
            "item is new ${Cquantity.runtimeType} hmmm ${Iquantity.runtimeType} ");
        Cquantity.add(Iquantity);
        print("item is new ");
        Cprices.add(Iprices);
        //  temp =Iprices + Cprices ;
        // Cprices  = temp ;

        print("item is new ");
      }

      memberRef.update({
        "items": Citems,
        "quantity": Cquantity,
        "prices": Cprices,
        "subtotal": 0
      });
      return true;
    } catch (e) {
      print("Error occured while adding item $e");
      return false;
    }
  }
 



static Future<bool> decMemberItemssad(
      OrderId, MemberId, Items) async {
    try {
      var memberRef =
          _firestore.collection('Orders/$OrderId/Member').doc(MemberId);
      var qurey = await memberRef.get();

      var Cquantity = qurey.get("quantity");
      var Citems = qurey.get("items");
      var index = Citems.indexOf(Items);
      if (index != -1) {
        // item already exisit (change the quantity only )
        print("item already exist");
        Cquantity[index] = Cquantity[index] - 1;
      } 
      //SharedPrefer.decNumOfOrders();
      memberRef.update({
        "quantity": Cquantity,
      });
      return true;
    } catch (e) {
      print("Error occured while decreminting item $e");
      return false;
    }
  }

static Future<bool> deleteMemberItemssad(
      OrderId, MemberId, Items) async {
          SharedPrefer.decNumOfOrders();

    try {
      var memberRef =
          _firestore.collection('Orders/$OrderId/Member').doc(MemberId);
      var qurey = await memberRef.get();

      var Cprices = qurey.get("prices");
      var Cquantity = qurey.get("quantity");
      var Citems = qurey.get("items");
      var index = Citems.indexOf(Items);
    
      if (index != -1) {
        // item already exisit 
        print("item already exist");
        Cprices.removeAt(index);
        Cquantity.removeAt(index);
        Citems.removeAt(index);

      } 

      memberRef.update({
        "items": Citems,
        "quantity": Cquantity,
        "prices": Cprices,
      });
      return true;
    } catch (e) {
      print("Error occured while adding item $e");
      return false;
    }
  }

 static Future<bool> addMemberItemsSad(
      OrderId, MemberId, Items) async {
    try {
      var memberRef =
          _firestore.collection('Orders/$OrderId/Member').doc(MemberId);
      var qurey = await memberRef.get();

      var Cquantity = qurey.get("quantity");
      var Citems = qurey.get("items");
      //SharedPrefer.incNumOfOrders();
      var index = Citems.indexOf(Items);
      if (index != -1) {
        // item already exisit (change the quantity only )
        print("item already exist");
        Cquantity[index] = Cquantity[index] + 1;
      } 

      memberRef.update({
        "quantity": Cquantity,
      });
      return true;
    } catch (e) {
      print("Error occured while adding item $e");
      return false;
    }
  }
  static void delteOrder(orderid){
    _firestore.collection('Orders').doc(orderid).delete() ; 
    SharedPrefer.DeleteCurrentOrder();
  }
static Future<Orders?> getOrder(OrderId , {membersWithItems = false , AllItems = false ,}) async {
    var OrderRef = _firestore.collection('Orders') ; 
    var TheOrder = await OrderRef.doc(OrderId).get();

   if(TheOrder.exists){
    
    var id = TheOrder.id.toString().substring(0,5);
    var cr =TheOrder.get("Creator") ; 
    var RBs = TheOrder.get("Restaurant");
   print(RB.fromJson(RBs));
    var num =TheOrder.get("ContactNum"); 
    var pmethod = TheOrder.get("PaymentMethod"); 
    var Dlocation =TheOrder.get("deleveryLocation");
    var RestId =TheOrder.get("RestaurantID") ; 
    var Otime =TheOrder.get("OrderTime");
    var total = TheOrder.get("Total").toString() ; 
    var status =TheOrder.get("status"); 

    print("getOrder exists${TheOrder.get("RestaurantID")}");
    Orders ResOrder ; 
    if(membersWithItems){
     var  ItemsMembers = await getMembersWithItems(OrderId);
     ResOrder =  Orders.ItemsWithMembers(id,cr,RB.fromJson(RBs),num,pmethod,Dlocation,RestId,Otime,total,status,ItemsMembers);
    }else if(AllItems){
     var  AllItems = await getAllItems(OrderId);
     ResOrder =  Orders.allItems(id,cr,RB.fromJson(RBs),num,pmethod,Dlocation,RestId,Otime,total,status,AllItems);
    }else{
    ResOrder =  Orders.basic(id,cr,RB.fromJson(RBs),num,pmethod,Dlocation,RestId,Otime,total,status);
   }
   
   print("Ddd${ResOrder.RestaurantID}");
   return ResOrder;
   }else{
     print("getOrder noexists");
    return null ; }
   
}
static Future< Map<String,String>> getMembers(OrderId)async{
    Map<String,String> members = {}; 
   var OrderRef = await  _firestore.collection('Orders/$OrderId/Member').get() ; 
       OrderRef.docs.forEach((element) {
        members[element.id] = element.get("name");
       });
     return members ; 
}
static Future< Map<String,MemberItems>> getMembersWithItems(OrderId)async{
    Map<String,MemberItems> membersWithItems = {}; 
   
   var OrderRef = await  _firestore.collection('Orders/$OrderId/Member').get() ; 
     await Future.wait(   OrderRef.docs.map((element)async {
        membersWithItems[element.get("name")] =await MemberItems.getMemberItems(OrderId, element.id);
       }));
     
       print(membersWithItems);
     return membersWithItems ; 
}

static Future< MemberItems> getAllItems(OrderId)async{
 Map<String,MemberItems> membersWithItems = await getMembersWithItems(OrderId);
 List<MemberItems> memberlist = membersWithItems.values.toList() ; 
 Map<String, int> itemQuantities =   await sumQuantities(memberlist);
 print("ehehehehhe ${itemQuantities.keys.toList()}");
 MemberItems TotalItemList =await MemberItems(itemQuantities.keys.toList() ,price, itemQuantities.values.toList()); 
  print("is it wokring ? ${TotalItemList}");
  return TotalItemList ; 
}

static List<int> price = [] ; 
static Map<String, int> sumQuantities(List<MemberItems> members) {
  Map<String , int> itemQuantities = {};
  Map<String , int> itemPrices = {};
  for (MemberItems member in members) {
    for (int i = 0; i < member.items.length; i++) {
      String item = member.items[i];
      int quantity = member.quantitys[i];
      int price = member.prices[i];
      // If the item is already in the map, add the quantity; otherwise, initialize with the quantity
      itemQuantities[item] = (itemQuantities[item] ?? 0) + quantity;
      itemPrices[item] = (itemPrices[item] ?? price) ;

    }
  }
  price = itemPrices.values.toList() ; 
  return itemQuantities;
}

}