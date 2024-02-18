import 'package:batatis/RestaurantBranch_Screens/All_RestaurantBranch_Screens.dart';
import 'package:batatis/moudles/Orders.dart';
import 'package:flutter/material.dart';
import '../moudles/RB.dart';
import '/RestaurantBranch_Widgets/All_RB_Widgets.dart';
import '/Views/RestaurantBranch_View.dart';
import '/RegExp.dart';
import '/Controller.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:batatis/main.dart';
import 'package:batatis/Routes.dart';

class addItem extends StatefulWidget {
  const addItem({super.key});

  @override
  State<addItem> createState() => addItemState();
}

class addItemState extends State<addItem> {
  static String errorMsg = " ";

  String Rid = viewMenu.boho;
  String RestaurantId = viewMenuState.RestaurantId!;
  double size = 0.15 * Batatis.Swidth;

  //List<String> items=['Appetizers', 'Beverages', 'Side Dishes', 'Main Courses', 'Deeserts' , 'breakfast'];
  String dropdownValue = 'Select a Category';
  Color ccc = Color.fromRGBO(127, 128, 129, 1);

  // String val = " Appetizers";
  //ile image =new File("assets/Images/burger.png"); //
  List<String> itemsCategories = []; // Initialize with an empty list

  @override
  final _addItemKey = GlobalKey<FormState>();

  var values = {
    'Name': "",
    'description': "",
    'price': "",
    'category': "",
  };
  

  Future<void> fetchAndSetItemCategories() async {
    try {
      List<String> categories = await RB.getMenuItemCategories();
      setState(() {
        itemsCategories = categories;
      });
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  List<TextEditingController> myController =
      List.generate(3, (i) => TextEditingController());
  Widget build(BuildContext context) {
    fetchAndSetItemCategories();
    // errorMsg = " ";
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Container(
                    //alignment: Alignment(0, 0),
                    child: Form(
      key: _addItemKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
                                      text: 'Add Item ', type: "Subheading1WB"),
          Container(
            // width:   size,
            // height: size,
            margin: EdgeInsets.all(5.0),

            child: 
            Column(children: [
            PhotoPicker(
                img: Image.asset("assets/Images/img holder.jpg",
                    width: 100, height: 100),
                width: 100,
                height: 100),
                
                Text(errorMsg, style : TextStyle(
                color: Colors.red,
                fontSize: 10,
              ),)
                ],)
            //) ,   //need to checked if good
            //           PhotoPicker(
            //           onImageSelected: (File selectedImage) {

            //           // You can save it, display it, or perform any other action.
            //   },
            // ),
          ),
          CustomTextFiled(
            text: "  Name",
            controller: myController[0],
            isvalid: Controller.EmptyValidation,
            maxLen: 20,
            allowed: regcharandnumSpace,
            width: 0.40,
            height: 0.09,
            onLostFocus: (text) {
              // Add your code here to handle the message when the field loses focus
              print("Field lost focus: $text");
            },
          ),
          CustomTextFiled(
            text: "  description",
            controller: myController[1],
            isvalid: Controller.EmptyValidation,
            maxLen: 100,
            allowed: regcharandnumSpace,
            width: 0.40,
            height: 0.09,
            onLostFocus: (text) {
              // Add your code here to handle the message when the field loses focus
              print("Field lost focus: $text");
            },
          ),
          //////CustomTextFiled(text:" category " ,Controller :myController[2],isvaild: Controller.EmptyValidation ,maxLen: 15,allowed:regonlychar ,width:0.40 ,height: 0.09,) ,
          CustomTextFiled(
            text: "  price in SR",
            controller: myController[2],
            isvalid: Controller.priceValidation,
            maxLen: 7,
            allowed: regonlynumberandDot,
            width: 0.40,
            height: 0.09,
            onLostFocus: (text) {
              // Add your code here to handle the message when the field loses focus
              print("Field lost focus: $text");
            },
          ),
          // Container(
          //   child: CustomText(
          //     text: errorMsg,
          //     color: red,
          //     fontSize: 18,
          //   ),
          // ),

          //                 onChanged: (newValue) {
          //                   setState(() {
          //                     val = newValue!;
          //                     // style: TextStyle(
          //                     //   color: Color.fromRGBO(0, 0, 0, 0),
          //                     //   fontWeight: FontWeight.w500,
          //                     //   fontSize: 16.0,

//         decoration: BoxDecoration(
//           color: grey_light,
//           borderRadius: BorderRadius.circular(30),

//         ),

//       child: Center(
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               selectedValue,
//               style: TextStyle(
//                 color:gg ,  //Color.fromRGBO(127, 128, 129, 1),
//                 fontWeight: FontWeight.w500,
//                 fontSize: 16.0,
//               ),
//             ),
//           ),
//         ),
//          ),

          Container(
            width: 0.40 * Batatis.Swidth,
            height: 0.09 * Batatis.Sheight,
            margin: EdgeInsets.all(0),
            child: DropdownButtonFormField(
              //focusColor: Colors.transparent,

              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0.0),
                // border : OutlineInputBorder( ),

                enabledBorder: OutlineInputBorder(
                    //<-- SEE HERE
                    borderSide: BorderSide(color: grey_light),
                    borderRadius: BorderRadius.circular(30)),
                focusedBorder: OutlineInputBorder(
                    //<-- SEE HERE
                    borderSide: BorderSide(color: grey_light),
                    borderRadius: BorderRadius.circular(30)),
                //     OutlineInputBorder(
                //      borderRadius: BorderRadius.circular(30),

                //    ),
                fillColor: grey_light,

                filled: true,
                errorStyle:  TextStyle(
                color: Colors.red,
                fontSize: 10,
              ),
                hintStyle: TextStyle(
                  color: Color.fromRGBO(127, 128, 129, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
              dropdownColor: grey_light,
              value: dropdownValue,

              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                  value : newValue! ;
                  //ccc=
                });
              },
              items:
                  itemsCategories.map<DropdownMenuItem<String>>((String value) {
                //items: <String>['Select a category','Main Courses','Appetizers', 'Beverages', 'Side Dishes',  'Deeserts' , 'breakfast'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),

              validator: (value) {
                if (value == null ||
                    value.isEmpty 
                    //||
                   // value == 'Select a Category'
                    ) {
                  return 'Required field';
                } else {
                  return null;
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  text: "Cancel",
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('leave this page'),
                        content: const Text(
                            'Are you sure you want to leave this page? the changes will not be saved'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(
                              context,
                            ),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => {
                              moveRoute(context, "/RBHomePageM"),
                            },
                            child: Text(
                              'leave',
                              style: TextStyle(color: red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  type: "add",
                  width: 0.1),
              SizedBox(
                  width:
                      431), // Add horizontal space between Dropdown and Button
              CustomButton(
                text: "add",
                onPressed: () {
                  if(!PhotoPicker.Ispicked()){setState(() {
                    errorMsg = "Required field" ;
                  });}
                   if (_addItemKey.currentState!.validate()) {
                            //   createAccount();
                            print("addd please");
                            Controller.itemAdd(RestaurantId, dropdownValue /*val*/,
                      _addItemKey, values, setState, myController, context);
                   }
                   
                //    else{ 
                // }
                },
                type: "add",
                width: 0.1,
              ),
            ],
          ),
        ],
      ),
    )))));
  }
}
