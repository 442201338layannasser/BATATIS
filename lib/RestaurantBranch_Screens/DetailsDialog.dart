import 'package:batatis/RestaurantBranch_Widgets/All_RB_Widgets.dart';
import 'package:flutter/material.dart';

import '../moudles/Orders.dart';

class RBOrdersDetails extends StatefulWidget {
  const RBOrdersDetails({super.key , required this.orderid});
final orderid ; 
  @override
  State<RBOrdersDetails> createState() => _RBOrdersDetailsState();
}


class _RBOrdersDetailsState extends State<RBOrdersDetails>{
late Orders? TheeeOrder ; 
bool loading = true ; 
  void initState() {
    super.initState();
    fetchOrder();

    }
      void fetchOrder()async  {
        TheeeOrder = await Orders.getOrder(widget.orderid ,AllItems: true) ;
       print("TheeeOrder $TheeeOrder");//.then((value) 
          setState(()  {
          
            loading = false ; 
          });
        // }) ;
      }

  @override
  Widget build(BuildContext context) {
   return AlertDialog(
                                              title: Center(
                                                  child: Text("Order ID #${widget.orderid.toString().substring(0,5)}")) ,
                                              content:// !loading? 
                                              Container(
                                                  transformAlignment:
                                                      Alignment.center,
                                                  width: 900,
                                                  height: 218,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: 800,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            margin:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    50,
                                                                    12,
                                                                    12,
                                                                    12),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: white,
                                                              borderRadius: const BorderRadius
                                                                  .only(
                                                                  topLeft:
                                                                      Radius.circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  spreadRadius:
                                                                      2,
                                                                  blurRadius: 4,
                                                                ),
                                                              ], /////////////////////cards creation
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                const SizedBox(
                                                                  width: 40,
                                                                  height: 33,
                                                                ),
                                                                 Container(width: 90 ,alignment: Alignment.center ,child:  CustomText(
                                                                  text:
                                                                      "Quantity",
                                                                  type:
                                                                      "Subheading1B",
                                                                )),
                                                                const SizedBox(
                                                                  height: 33,
                                                                  width: 230,
                                                                ),
                                                                CustomText(
                                                                    text:
                                                                        "Item Name",
                                                                    type:
                                                                        "Subheading1B"),
                                                                const SizedBox(
                                                                  height: 33,
                                                                  width: 230,
                                                                ),
                                                                CustomText(
                                                                  text: "Price",
                                                                  type:
                                                                      "Subheading1B",
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                     
                                                      !loading ?
                                                      Row(children: [
                                                        SizedBox(width: 100,),
                                                       Container(width: 90 ,alignment: Alignment.center ,child: Column(children: ListofText(TheeeOrder!.AllItems.quantitys,pre: "x"),)),
                                                        SizedBox(width: 230,),
                                                      Container(width: 110 ,alignment: Alignment.center  ,child:  Wrap( direction : Axis.vertical ,children: ListofText(TheeeOrder!.AllItems.items),),),
                                                        SizedBox(width: 205,),
                                                        Column(children: ListofText(TheeeOrder!.AllItems.prices,post: "SR"),)


                                                      ],) :   CircularProgressIndicator( )
                                                      // Container(
                                                      //   alignment:
                                                      //       Alignment.center,
                                                      //   height: 130,
                                                      //   width: 800,
                                                      //   child:
                                                      //       SingleChildScrollView(
                                                      //     child: Scrollbar(
                                                      //         child: Column(
                                                      //             children:
                                                      //                 membersorders(
                                                      //                     deatils))),
                                                      //   ),
                                                      // ),
                                                      // Row(
                                                      //   children: [
                                                      //     SizedBox(
                                                      //       height: 50,
                                                      //     ),
                                                      //     CustomText(
                                                      //       text:
                                                      //           "                                                                           Total: ${element.get("Total")} SR",
                                                      //       type: "total",
                                                      //     )
                                                      //   ],
                                                      // )
                                                    ],
                                                  ))
                                              //    Container(height: 20 , width:10  ,child:   
                                                 //)
                                              , 
                                              actions: !loading ?  <Widget>[
                                                Row(
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          "                                                                           Total: ${TheeeOrder!.Total.toString()} SR",//
                                                      type: "total",
                                                    )
                                                  ],
                                                ),
                                                ElevatedButton(
                                                  //cancel
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                    context,
                                                  ),
      style: ElevatedButton.styleFrom(
                                    primary:
                                        Batatis_Dark, // Change the button's background color here
                                  ),
                                                  child: const Text('Ok',
                                    style: TextStyle(
                                      color: Colors
                                          .white, // Set the text color to white
                                    ),),                                                ),
                                              ] : null ,
                                            );
  }
  
  List<Widget> ListofText( list,{post ="" , pre = ""}) {
  List<Widget> res = [] ; 
    list.forEach((ele){
       
      res.add(CustomText(text: "$pre${ele.toString()}$post"  , type: "Subheading1B"));
      //Text("$pre${ele.toString()}$post")
      print(ele.toString());
    });
    return res ; 
  }
}