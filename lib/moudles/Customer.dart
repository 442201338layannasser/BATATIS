

import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Customer {

  final String name ; 
  final String phonenumber ; 
  final int wallet = 0 ;
  
Customer({required this.name, required this.phonenumber,});
  


  CollectionReference Customers =  db.collection('Customers');
  var flag = true ; 

  Future<void> addFilde(id,filed,value ) async  {
      await  Customers.doc(id).set({filed : value});
 
  }
  Future<void> addcustomer(id ) async  {
  
    
    return Customers.doc(id.toString()).set({
    
      'name':this.name,
      'phonenumber': this.phonenumber ,
      
    })
        .then((value)  {
        print("whats this ");
        })
        .catchError((error) => print("Failed to add Customer: $error"));}
 
    int count =0  ;
    
    Future<int> getDocumentCount() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Customers') 
          .get();

        count = snapshot.size;
        
      return count;
    } catch (e) {
      
      return 0; 
  }}

    static Future<bool> checkexistingPhoneNumber(String phonenum) async {

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final QuerySnapshot querySnapshot = await _firestore
      .collection('Customers')
      .where('phonenumber', isEqualTo: phonenum)
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    
    return true ; 
  } else {
    
    return false ; 
    
  }
}
    }