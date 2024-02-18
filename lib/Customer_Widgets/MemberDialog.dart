import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
import 'package:batatis/RestaurantBranch_Screens/sharedPref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MemberDialog extends StatefulWidget {
  @override
  _MemberDialogState createState() => _MemberDialogState();
}

class _MemberDialogState extends State<MemberDialog> {
  @override
  Widget build(BuildContext context) {
    return MemberListDialog();
  }
}

class MemberListDialog extends StatelessWidget {
  @override
  late bool isCreator;
  late String
      orderID; // should be stored when first created and also stored when joining
  late String userID;
  static int numberOfMembers = 1;
  Color backgroundColor = Colors.grey;

  Widget build(BuildContext context) {
    if (SharedPrefer.CurrentOrderId != null) {
      isCreator = SharedPrefer.iscreator!;
      orderID = SharedPrefer.CurrentOrderId
          .toString(); // should be stored when first created and also stored when joining
      userID = SharedPrefer.UserId.toString();
    } else {
      isCreator = true;
      orderID = SharedPrefer.CurrentOrderId
          .toString(); // should be stored when first created and also stored when joining
      userID = SharedPrefer.UserId.toString();
    }
    return AlertDialog(
      title: Row(children: [
        Text('Members List'),
        Text(
          '(max 20)',
          style: TextStyle(fontSize: 14),
        ),
        // IconButton(
        //         onPressed: () async {
        //           if (SharedPrefer.CurrentOrderId == null ||
        //               SharedPrefer.CurrentOrderId == "") {
        //             print("there is no order yet");
        //             var Orderid = await Orders.addorder(
        //                 creatorId: SharedPrefer.UserId.toString(),
        //                 name: SharedPrefer.UserName.toString(),
        //                 deleveryLocation: SharedPrefer.UserAddress.toString(),
        //                 RestaurantID: RestaurantId.toString(),
        //                 OrderTime: DateTime.now().toString(),
        //                 Total: "0",
        //                 status: "ongoing");
        //             Link.createDynamicLink(RestaurantId.toString(), Orderid);
        //           } else {
        //             checkkicked(context);
        //             if (!iscicked) {
        //               print("there is order ");
        //               Link.createDynamicLink(
        //                   RestaurantId.toString(), SharedPrefer.CurrentOrderId);
        //             }
        //           }
        //         },
        //         icon: Icon(
        //           Icons.ios_share_outlined,
        //           size: 30,
        //           color: white,
        //         ))
      ]),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Orders')
                  .doc(orderID)
                  .collection("Member")
                  .orderBy("name")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final members = snapshot.data!.docs;
                // sort sadeem Move the item with the specified name to the beginning of the list
                                                                                          members.sort((a, b) {
                                                                                            if (a.data()['creator'] == true ) {
                                                                                              return -1; // Move 'Bob' to the beginning
                                                                                            } else if (b.data()['creator'] == true ) {
                                                                                              return 1;
                                                                                            } else {
                                                                                              return 0;//a.data()['creator'] .compareTo(b.data()['creator'] );
                                                                                            }
                                                                                          });
              //////////////////////////////
                numberOfMembers = members.length;
                return isCreator
                    ? Column(
                        children: members.map((memberDoc) {
                          final memberData = memberDoc.data();
                          final isCre = memberData['creator'] == true;

                          return Card(
                            elevation: 4, // Add shadow
                            margin:
                                EdgeInsets.all(8), // Add space around the card
                            child: ListTile(
                              leading: Icon(
                                Icons.account_circle,
                                color: Batatis_Dark,
                              ),
                              title: Row(
                                children: [
                                  Text(memberData['name']),
                                 if (isCre) 
                                  Text(' (Host)'),
                                ],
                              ),
                              trailing: !isCre
                                  ? GestureDetector(
                                      onTap: () {
                                        showDeleteConfirmationDialog(context,
                                            memberDoc.id, memberData['name']);
                                      },
                                      child: Icon(
                                        Icons.cancel_rounded,
                                        color: red,
                                      ),
                                    )
                                  : null,
                            ),
                          );
                        }).toList(),
                      )
                    : Column(
                        children: members.map((memberDoc) {
                          final memberData = memberDoc.data();
                          final isCre = memberData['creator'] == true;

                          return Card(
                            elevation: 4, // Add shadow
                            margin:
                                EdgeInsets.all(8), // Add space around the card
                            child: ListTile(
                              leading: Icon(
                                Icons.account_circle,
                                color: Batatis_Dark,
                              ),
                              title:  Row(
                                children: [
                                  Text(memberData['name']),
                                 if (isCre) 
                                  Text(' (Host)'),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close'),
        ),
      ],
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

  void showDeleteConfirmationDialog(
      BuildContext context, String memberId, String memberName) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return CustomDialog(
          text: 'Are you sure you want to delete $memberName?',
          action: null,
          onPressed: () {
            Navigator.of(dialogContext).pop();
            removeMember(memberId);
          },
          type: "customizeddanger",
          MainButton: "Delete",
        );
        AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete $memberName?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                removeMember(memberId);
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
