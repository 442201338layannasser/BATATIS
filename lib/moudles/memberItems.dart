import 'package:cloud_firestore/cloud_firestore.dart';

class MemberItems{
  late List<dynamic> items ;
  late List<dynamic> prices;
  late List<dynamic> quantitys ;

  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  MemberItems(this.items, this.prices, this.quantitys);

  static Future<MemberItems> getMemberItems(orderid, memberid)async{
   var memberRef =  await  _firestore.collection('Orders/$orderid/Member').doc(memberid).get();
    MemberItems memberItems = MemberItems(memberRef.get("items"),memberRef.get("prices"),memberRef.get("quantity")); 
 return memberItems ; 
  }
 Map<String, dynamic> toJson() =>
  {
    'items': items,
    'prices': prices,
    'quantitys':quantitys
  };
  
}