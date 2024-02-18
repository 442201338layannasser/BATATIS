import 'package:batatis/Controller.dart';
import 'package:batatis/RegExp.dart';
import 'package:batatis/RestaurantBranch_Screens/LocationPicker.dart';
import 'package:batatis/RestaurantBranch_Screens/dottedFieldChangeDialog.dart';
import 'package:batatis/RestaurantBranch_Screens/RBAccount.dart';
import 'package:batatis/RestaurantBranch_Screens/RBRegisterFirst.dart';
import 'package:batatis/RestaurantBranch_Widgets/RBdivider.dart';
import 'package:batatis/RestaurantBranch_Widgets/editdrop.dart';
import 'package:batatis/Routes.dart';
import 'package:batatis/moudles/RB.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'sharedPref.dart';
import '../RestaurantBranch_Widgets/All_RB_Widgets.dart';
import '../RestaurantBranch_Widgets/RBedittimeend.dart';

import '../RestaurantBranch_Widgets/RBedittimestrart.dart';

class RBeditprofile extends StatefulWidget {
  const RBeditprofile({super.key});

  @override
  State<RBeditprofile> createState() => RBeditprofileState();
}

class RBeditprofileState extends State<RBeditprofile> {
  TextEditingController currentPasswordController = TextEditingController();
  String errorMessage = '';
  static  var set  ; 
  void setErrorMessage(String message) {
    setState(() {
      errorMessage = message;
    });
  }

  static String errorMsg = " ";
  FocusNode _focusNode = FocusNode();
  FocusNode _focusNodeRestaurantName = FocusNode();
  FocusNode _focusNodeFee = FocusNode();

  // bool _isRestaurantNameEditable = false;
  // bool _isFeeEditable = false;
  // bool _isBankNameEditable = false;
  // bool _isIBANEditable = false;
  // bool _isBeneficiaryNameEditable = false;
  // bool _isStartTimeEditable = false;
  // bool _isEndTimeEditable = false;
  bool _iseditable = false;
  //bool _isEditable= false;
  // static String newRestaurantName="";
  // String newFee="";
  // String newBankName="";
  // String newIBAN="";
  // String newBeneficiaryName="";
  String? RestaurantId = RSharedPref.RestId;
  String newPass = '';

  @override
  void dispose() {
    // _focusNodeRestaurantName.dispose();
    // _focusNodeFee.dispose();
    super.dispose();
  }

  void updatePassword(String newPassword) {
    setState(() {
      newPass = newPassword;
    });
  }

  bool loading = true;
  bool timeGo = true;
  static String startTime = " ";
  static String endTime = " ";
  static String splitted = " ";
  static String newendtime = '';
  static String newstarttime = '';
  Map<String, BitmapDescriptor> listOfRestaurantBitmaps = {};
  //bool hour1=true;
  //bool hour2=true;
  bool timeFromPicker = false;

  static String val = " Resturant Category";
  Map<String, Widget> listOfRestaurantImages = {};
  List<String> listOfCategory = []; // Initialize with an empty list
  Future<void> fetchAndSetCategories() async {
    try {
      List<String> categories = await RB.getResturantCategories();
      setState(() {
        listOfCategory = categories;
        categories.sort((a, b) => a.compareTo(b));
        listOfCategory.remove('Other');
        listOfCategory.add('Other');
      });
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  String? resturantid = '';
  Future<void> loadData() async {
    try {
      resturantid = await Controller.getUid();
      print("iam in load");

      await loadResturantsImages();
      print("done with logo");

      await getStarttime();
      print("done with starttime $rbeditstart");

      await getendtime();
      print("done with endtime $rbeditend");

      //await getemail();
      await getIban();
      print("done with iban $iban");

      await getaddressname();
      print("done with address $address");

      await getbankname();
      print("done with bankname $bankname");

      await getbenename();
      print("done with banname $benename");

      getCommercialNumber();
      print("done with crnumber $crnumb");

      await getfee();
      print("done with fee $fee");

      await getrestname();
      print("done with restname $restname");

      await getresttype();
      print("done with type $type");

      resturantid = await Controller.getUid();

      setState(() {
        print("loged in, in setate");

        RBAccountState.myRBControllerForEdit[2].text = restname;
        RBAccountState.myRBControllerForEdit[3].text =
            fee; //should be the actual fee from the db (RSharedPref)
        RBAccountState.myRBControllerForEdit[4].text = bankname;
        RBAccountState.myRBControllerForEdit[5].text = iban;
        RBAccountState.myRBControllerForEdit[6].text = benename;
        RBAccountState.myRBControllerForEdit[7].text =
            rbeditstart; //should be the actual start time from the db (RSharedPref)
        RBAccountState.myRBControllerForEdit[8].text =
            rbeditend; //should be the actual end time from the db (RSharedPref
        RBAccountState.myRBControllerForEdit[9].text = crnumb;
        RBAccountState.myRBControllerForEdit[10].text = type;

        loading = false;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> islog() async {
    isLoggedIn = await sharedPref.isUserLoggedIn();
  }

  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    set  = setState;
    islog();

    //EnsuerData();
    loadData();
    print("loaddataaaaaa");

    // values['type'] = val;
    //print(
    //"${values['type']}"); // Initialize 'type' with the initially selected value.
    // RBAccountState.myRBControllerForEdit[2].text = restname;
    // RBAccountState.myRBControllerForEdit[3].text = fee; //should be the actual fee from the db (RSharedPref)
    // RBAccountState.myRBControllerForEdit[4].text = bankname;
    // RBAccountState.myRBControllerForEdit[5].text = iban;
    // RBAccountState.myRBControllerForEdit[6].text = benename;
    // RBAccountState.myRBControllerForEdit[7].text = rbeditstart; //should be the actual start time from the db (RSharedPref)
    // RBAccountState.myRBControllerForEdit[8].text = rbeditend; //should be the actual end time from the db (RSharedPref
    // RBAccountState.myRBControllerForEdit[9].text = crnumb;
    // RBAccountState.myRBControllerForEdit[10].text = type;
    // print("current bank name is");
    // print( RBAccountState.myRBControllerForEdit[4].text);
    // print("current iban is");
    // print( RBAccountState.myRBControllerForEdit[5].text);
    // print("current bene name");
    // print( RBAccountState.myRBControllerForEdit[6].text);
    //type
    //crnumb
    //address
  }

  // EnsuerData(){
  //    loadData().then((value) => {
  //         print("loading done"),
  //         setState(() {
  //           loading = false;
  //         }),
  //       });
  // }

  // Future<String> getemail() async {
  //   DocumentReference orderRef =
  //       FirebaseFirestore.instance.collection("Restaurants").doc(resturantid);

  //   DocumentSnapshot snapshot = await orderRef.get();

  //   if (snapshot.exists) {
  //     Map<String, dynamic>? dataMap = snapshot.data() as Map<String, dynamic>?;

  //     if (dataMap != null) {
  //       dynamic emailValue = dataMap["Email"];

  //       if (emailValue != null) {
  //         return emailValue.toString();
  //       } else {
  //         return "Email field is null";
  //       }
  //     } else {
  //       return "Document data is null or not a Map";
  //     }
  //   } else {
  //     return "Document does not exist";
  //   }
  // }

  String iban = '';
  Future<void> getIban() async {
    // String? resturantid = await Controller.getUid();

    DocumentReference orderRef =
        FirebaseFirestore.instance.collection("Restaurants").doc(resturantid);

    DocumentSnapshot snapshot = await orderRef.get();

    if (snapshot.exists) {
      Map<String, dynamic>? dataMap = snapshot.data() as Map<String, dynamic>?;

      if (dataMap != null) {
        dynamic emailValue = dataMap["IBAN"];

        if (emailValue != null) {
          iban = emailValue.toString();
        } else {}
      } else {}
    } else {}
  }

  String restname = '';
  Future<void> getrestname() async {
    //String? resturantid = await Controller.getUid();

    DocumentReference orderRef =
        FirebaseFirestore.instance.collection("Restaurants").doc(resturantid);

    DocumentSnapshot snapshot = await orderRef.get();

    if (snapshot.exists) {
      Map<String, dynamic>? dataMap = snapshot.data() as Map<String, dynamic>?;

      if (dataMap != null) {
        dynamic emailValue = dataMap["Resturant Name"];

        if (emailValue != null) {
          restname = emailValue.toString();
        } else {}
      } else {}
    } else {}
  }

  String fee = '';
  Future<void> getfee() async {
    //String? resturantid = await Controller.getUid();

    DocumentReference orderRef =
        FirebaseFirestore.instance.collection("Restaurants").doc(resturantid);

    DocumentSnapshot snapshot = await orderRef.get();

    if (snapshot.exists) {
      Map<String, dynamic>? dataMap = snapshot.data() as Map<String, dynamic>?;

      if (dataMap != null) {
        dynamic emailValue = dataMap["Fee"];

        if (emailValue != null) {
          fee = emailValue.toString();
        } else {}
      } else {}
    } else {}
  }

  String buttonType = "Edit";
  String type = '';
  Future<void> getresttype() async {
    //String? resturantid = await Controller.getUid();

    DocumentReference orderRef =
        FirebaseFirestore.instance.collection("Restaurants").doc(resturantid);

    DocumentSnapshot snapshot = await orderRef.get();

    if (snapshot.exists) {
      Map<String, dynamic>? dataMap = snapshot.data() as Map<String, dynamic>?;

      if (dataMap != null) {
        dynamic emailValue = dataMap["Resturant Type"];

        if (emailValue != null) {
          print("iam in typeee");
          type = emailValue.toString();
          print("should be type =$type");
        } else {}
      } else {}
    } else {}
  }

  static String rbeditstart = '';
  Future<void> getStarttime() async {
    //String? resturantid = await Controller.getUid();

    DocumentReference orderRef =
        FirebaseFirestore.instance.collection("Restaurants").doc(resturantid);

    DocumentSnapshot snapshot = await orderRef.get();

    if (snapshot.exists) {
      Map<String, dynamic>? dataMap = snapshot.data() as Map<String, dynamic>?;

      if (dataMap != null) {
        dynamic emailValue = dataMap["StartTime"];

        if (emailValue != null) {
          rbeditstart = emailValue.toString();
          RBedittimestartState.val = rbeditstart;
        } else {}
      } else {}
    } else {}
  }

  int counter = 0;

  static String rbeditend = '';
  Future<void> getendtime() async {
    //String? resturantid = await Controller.getUid();

    DocumentReference orderRef =
        FirebaseFirestore.instance.collection("Restaurants").doc(resturantid);

    DocumentSnapshot snapshot = await orderRef.get();

    if (snapshot.exists) {
      Map<String, dynamic>? dataMap = snapshot.data() as Map<String, dynamic>?;

      if (dataMap != null) {
        dynamic emailValue = dataMap["EndTime"];

        if (emailValue != null) {
          rbeditend = emailValue.toString();
          RBedittimeendState.val = rbeditend;
        } else {}
      } else {}
    } else {}
  }

  String buttonText = "Edit";
  String crnumb = '';
  void getCommercialNumber() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await firestore.collection('Restaurants').doc(resturantid).get();

    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      crnumb = data['CRnumber'];
      print('Commercial Number: $crnumb');
    } else {
      print('Restaurant does not exist');
    }
  }

  String benename = '';
  Future<void> getbenename() async {
    //String? resturantid = await Controller.getUid();

    DocumentReference orderRef =
        FirebaseFirestore.instance.collection("Restaurants").doc(resturantid);

    DocumentSnapshot snapshot = await orderRef.get();

    if (snapshot.exists) {
      Map<String, dynamic>? dataMap = snapshot.data() as Map<String, dynamic>?;

      if (dataMap != null) {
        dynamic emailValue = dataMap["BeneficiaryName"];

        if (emailValue != null) {
          benename = emailValue.toString();
        } else {}
      } else {}
    } else {}
  }

  String bankname = '';
  Future<void> getbankname() async {
    //String? resturantid = await Controller.getUid();

    DocumentReference orderRef =
        FirebaseFirestore.instance.collection("Restaurants").doc(resturantid);

    DocumentSnapshot snapshot = await orderRef.get();

    if (snapshot.exists) {
      Map<String, dynamic>? dataMap = snapshot.data() as Map<String, dynamic>?;

      if (dataMap != null) {
        dynamic emailValue = dataMap["BankName"];
        print("bbbbbbbbbbbbbbbbbbbbbbbbbbbaaaaaannkkkkk   " + bankname);
        if (emailValue != null) {
          bankname = emailValue.toString();
        } else {}
      } else {}
    } else {}
  }

  Future<bool> isCurrentPassCorrect(String currentPass) async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print("user is null ");
        print(user == null);
        // User is not authenticated
        return false;
      }

      // Sign in with the current user's email and password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPass,
      );

      // Attempt to reauthenticate the user with the entered password
      await user.reauthenticateWithCredential(credential);

      // If reauthentication is successful, the entered password is correct
      print("pass is correct");
      return true;
    } catch (e) {
      // Handle any errors that might occur during the reauthentication process
      print('Error in isCurrentPassCorrect: $e');
      print("pass is incorrect");
      return false;
    }
  }

  AlertDialog deleteAccount() {
    return AlertDialog(
      title: Text('Delete account'),
      content: Column(
        children: [
          TextField(
            controller: currentPasswordController,
            obscureText: true,
            decoration: InputDecoration(labelText: ' Enter Current Password'),
          ),
          if (errorMessage.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // if (errorMessage!='')
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            String currentPassword = currentPasswordController.text;
            bool isCurrentPasswordCorrect =
                await isCurrentPassCorrect(currentPassword);

            if (isCurrentPasswordCorrect) {
              final CollectionReference restaurantCollection =
                  FirebaseFirestore.instance.collection('Restaurants');

              try {
                QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                    .collection("Orders")
                    .where("RestaurantID",
                        isEqualTo: RSharedPref.RestId.toString())
                    .where("status", whereIn: ["waiting"]).get();
                if (querySnapshot.docs.isEmpty) {
                  print("i will enter delete");

                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Delete Account'),
                      content: const Text(
                          'Are you sure you want to delete your account?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(
                            context,
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Batatis_Dark,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            print("iam befor controller heeeerreee");

                            restaurantCollection
                                .doc(RSharedPref.RestId)
                                .delete();

//////////////////////////////////////////////////////////////////////////////
                            UserCredential tempUserCredential =
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                              email: RSharedPref.RestEmail.toString(),
                              password: currentPasswordController
                                  .text, // Use the same password used during user creation
                            );
                            tempUserCredential.user?.delete();
                            //////////////////////////////////////////////////////////////////////
                            moveRoute(context, '/SignInPage');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Your profile has been deleted successfuly'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              color: red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Your have to finish your orders before deleting account'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                print('Document deleted successfully');
              } catch (e) {
                print('Error deleting document: $e');
              }

              // Close the dialog
              //  errorMessage='';
            } else {
              // Show an error message for incorrect current password
              setErrorMessage("Incorrect current password");
              print("wrong current pass");
            }
          },
          child: Text('Delete Account'),
        ),
      ],
    );
  }

  String passw = '';
//   Future<void> deleteDocument(String documentId) async {
//     final CollectionReference restaurantCollection =
//         FirebaseFirestore.instance.collection('Restaurants');

//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection("Orders")
//           .where("RestaurantID", isEqualTo: RSharedPref.RestId.toString())
//           .where("status", whereIn: ["waiting"]).get();
//       if (querySnapshot.docs.isEmpty) {
//         print("i will enter delete");

//         showDialog<String>(
//           context: context,
//           builder: (BuildContext context) => AlertDialog(
//             title: const Text('Delete account'),
//             content:
//                 const Text('Are you sure you want to delete your account?'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () => Navigator.pop(
//                   context,
//                 ),
//                 child: Text(
//                   'Cancel',
//                   style: TextStyle(
//                     color: Batatis_Dark,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   print("iam befor controller heeeerreee");

//                   restaurantCollection.doc(documentId).delete();

// //////////////////////////////////////////////////////////////////////////////
//                   UserCredential tempUserCredential =
//                       await FirebaseAuth.instance.signInWithEmailAndPassword(
//                     email: RSharedPref.RestEmail.toString(),
//                     password:
//                         passw, // Use the same password used during user creation
//                   );
//                   tempUserCredential.user?.delete();
//               //////////////////////////////////////////////////////////////////////
//                   moveRoute(context, '/SignInPage');
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content:
//                           Text('Your profile has been deleted successfuly'),
//                       backgroundColor: Colors.green,
//                     ),
//                   );
//                 },
//                 child: Text(
//                   'Delete',
//                   style: TextStyle(
//                     color: red,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content:
//                 Text('Your have to finish your orders before deleting account'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }

//       print('Document deleted successfully');
//     } catch (e) {
//       print('Error deleting document: $e');
//     }
//   }

  static String address = '';
  String lat = '';
  String long = '';
  Future<void> getaddressname() async {
    //String? resturantid = await Controller.getUid();

    DocumentReference orderRef =
        FirebaseFirestore.instance.collection("Restaurants").doc(resturantid);

    DocumentSnapshot snapshot = await orderRef.get();

    if (snapshot.exists) {
      Map<String, dynamic>? dataMap = snapshot.data() as Map<String, dynamic>?;

      if (dataMap != null) {
        dynamic emailValue = dataMap["Address"];
        lat = dataMap["Lat"];
        long = dataMap["Long"];
        LocationPicker.value = LatLng( double.parse(lat) ,double.parse(long));
        if (emailValue != null) {
          address = emailValue.toString();
        } else {}
      } else {}
    } else {}
  }

  final _RBEditProfile1 = GlobalKey<FormState>();
  final _RBEditProfile2 = GlobalKey<FormState>();
  final _RBEditProfile3 = GlobalKey<FormState>();

  // final _RBsignupKey1 = GlobalKey<FormState>();
  // static var values = {
  //   'email': "",
  //   'password': "",

  //   'name': "",
  //   'crnumber': "",
  //   'type': "",
  //   'logo': "",

  //   'startTime':
  //       '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}', // Initialize with current time
  //   'endTime':
  //       '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}', // Initialize with current time
  //   'fee': "",
  //   'address': "",
  //   'lat': "",
  //   'long': "",

  //   'bankName': "",
  //   'iban': "",
  //   'benefName': "",
  // };

  late Widget logo;
  Future<void> loadResturantsImages() async {
    final String imagePath = "/Restaurants/$resturantid/Logo";

    await PhotoPicker.getimg(imagePath);
    final String imageUrl = await PhotoPicker.geturl();
    logo = Padding(
      padding: EdgeInsets.all(0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // Set the border radius here
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 250,
          height: 300,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   set  = setState;
    fetchAndSetCategories();
    //myRBController[0].text = "apapappaap";
    return Scaffold(
        //appBar: AppBar(),
        body: !loading
            ? SingleChildScrollView(
                child: Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 30), //add some space avove the row

                        // Add space between icons and form

                        Form(
                          key: _RBEditProfile1,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  RBDivider(text: "Restaurant information"),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                   // mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: 100,),
                                          CustomText(
                                            text: " Email:  ",
                                            color: black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          CustomText(
                                            text: RSharedPref.RestEmail
                                                .toString(),
                                            color: black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 590,
                                      ),
                                      CustomButton(
                                        type: buttonType,
                                        text: buttonText,
                                        onPressed: () {
                                          counter++;

                                          if (buttonText == "Save" &&
                                              counter > 0) {
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: const Text(
                                                    'Save information'),
                                                content: const Text(
                                                    'Are you sure you want to save your Edits?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        _iseditable = false;
                                                        buttonType = "Edit";
                                                        buttonText = "Edit";
                                                      });
                                                    },
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                        color: Batatis_Dark,
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                    LocationPickerState. getAddresslatlong(RSharedPref.RestId);
                                                    
                                                      print("location ${LocationPicker.value.latitude} ");
                                                      PhotoPicker.uploadBytes("/Restaurants/${RSharedPref.RestId}/Logo");
                                                      print("did u get the new img ?");
                                                      print(
                                                          "iam befor controller heeeerreee");
                                                      Controller.RBEditProfile(
                                                          _RBEditProfile1,
                                                          RBAccountState
                                                              .myRBControllerForEdit,
                                                          context,
                                                          timeGo);
                                                      moveRoute(context,
                                                          '/RBHomePage');
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              'Your profile has been updated successfuly'),
                                                          backgroundColor:
                                                              Colors.green,
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      'Save',
                                                      style: TextStyle(
                                                        color: Batatis_Dark,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );

                                            //   setState(() {
                                            //     buttonText="Edit";
                                            // buttonType="Edit";
                                            //  _iseditable = !_iseditable;
                                            //   });
                                          } else {
                                            setState(() {
                                              _iseditable = !_iseditable;
                                              buttonText = "Save";
                                              buttonType = "Save";
                                            });
                                          }
                                        },
                                        width: 0.13,
                                        height: 0.08,
                                      ),
                                      // SizedBox(
                                      //   width: 170,
                                      // ),
                                      // CustomButton(
                                      //     type: "delete1",
                                      //     text: "Delete Account",
                                      //     width: 0.14,
                                      //     height: 0.08,
                                      //     onPressed: () {
                                      //       showDialog<String>(
                                      //           context: context,
                                      //           builder:
                                      //               (BuildContext context) =>
                                      //                   deleteAccount());
                                      //     })
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 14),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: "Logo ",
                                                color: black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              PhotoPicker(
                                               editing: _iseditable,
                                                  img: Padding(
                                                      padding: EdgeInsets.all( 0.0), // Add margin to all sides of the CachedNetworkImage
                                                      child: logo),
                                                  width: 250,
                                                  height: 300),
                                                  SizedBox(height: 100,)
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  // CustomText(
                                                  //   text: "Name :",
                                                  //   color: black,
                                                  //   fontSize: 18,
                                                  //   fontWeight: FontWeight.bold,
                                                  // ),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  // CustomTextFiled(
                                                  //   width: 0.13,
                                                  //   value: restname,
                                                  //   text: "Restaurant Name",
                                                  //   controller: RBAccountState
                                                  //       .myRBControllerForEdit[2],
                                                  //   iseditable:
                                                  //       _isRestaurantNameEditable,
                                                  //   isvalid: Controller
                                                  //       .StringValidation,
                                                  //   maxLen: 15,
                                                  //   allowed:
                                                  //       regonlycharandspacec,
                                                  //   onLostFocus: (text) {
                                                  //     print(
                                                  //         "Field lost focus: $text");
                                                  //   },
                                                  // ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      CustomText(
                                                        text: "Name:",
                                                        color: black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      SizedBox(
                                                        height: 50,
                                                      ),
                                                      CustomText(
                                                        text: "CR Number:",
                                                        color: black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                      ),
                                                      CustomText(
                                                        text: "Category:",
                                                        color: black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      // CustomTextFiled(
                                                      //   width: 0.13,
                                                      //   text:
                                                      //       "Commercial Registration Number :",
                                                      //   value: crnumb,
                                                      //   controller: RBAccountState
                                                      //       .myRBControllerForEdit[9],
                                                      //   isvalid: Controller
                                                      //       .CRnumberlength,
                                                      //   maxLen: 10,
                                                      //   allowed: regonlynumber,
                                                      //   onLostFocus: (text) {
                                                      //     // Add your code here to handle the message when the field loses focus
                                                      //     print(
                                                      //         "Field lost focus: $text");
                                                      //   },
                                                      // ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      // CustomText(
                                                      //   text: "Category :",
                                                      //   color: black,
                                                      //   fontSize: 18,
                                                      //   fontWeight: FontWeight.bold,
                                                      // ),
                                                      CustomTextFiled(
                                                        width: 0.13,
                                                        value: restname,
                                                        text: "Restaurant Name",
                                                        controller: RBAccountState
                                                            .myRBControllerForEdit[2],
                                                        iseditable: _iseditable,
                                                        isvalid: Controller
                                                            .StringValidation,
                                                        maxLen: 15,
                                                        allowed:
                                                            regonlycharandspacec,
                                                        onLostFocus: (text) {
                                                          print(
                                                              "Field lost focus: $text");
                                                        },
                                                      ),
                                                      CustomTextFiled(
                                                        iseditable: _iseditable,
                                                        width: 0.13,
                                                        text:
                                                            "Commercial Registration Number:",
                                                        value: crnumb,
                                                        controller: RBAccountState
                                                            .myRBControllerForEdit[9],
                                                        isvalid: Controller
                                                            .CRnumberlength,
                                                        maxLen: 10,
                                                        allowed: regonlynumber,
                                                        onLostFocus: (text) {
                                                          // Add your code here to handle the message when the field loses focus
                                                          print(
                                                              "Field lost focus: $text");
                                                        },
                                                      ),
                                                      EditWidget(
                                                        iseditable: _iseditable,
                                                        items: listOfCategory,
                                                        selectedValue: type,
                                                        setState: setState,
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            type = newValue;
                                                            RBAccountState
                                                                .myRBControllerForEdit[
                                                                    10]
                                                                .text = type;
                                                            //values['type'] = type;
                                                            const TextStyle(
                                                              color: Color
                                                                  .fromRGBO(0,
                                                                      0, 0, 1),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 16.0,
                                                            );
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 80,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: <Widget>[
                                                           TextButton(
                                                            onPressed: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return dottedFieldChangeDialog(
                                                                      updatePassword:
                                                                          updatePassword,
                                                                      filedType:
                                                                          "Pass");
                                                                },
                                                              );
                                                            },
                                                            child: Text(
                                                              "Change password",
                                                              style: TextStyle(
                                                                color:
                                                                    Batatis_Dark,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                decorationColor:
                                                                    Batatis_Dark,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return dottedFieldChangeDialog(
                                                                      updatePassword:
                                                                          updatePassword,
                                                                      filedType:
                                                                          "bankInfo");
                                                                },
                                                              );
                                                            },
                                                            child: Text(
                                                              "Change bank information",
                                                              style: TextStyle(
                                                                color:
                                                                    Batatis_Dark,
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                decorationColor:
                                                                    Batatis_Dark,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Column(
                                            children: [
                                              CustomText(
                                                text: "Location",
                                                color: black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              LocationPicker(
                                                setter :setState , 
                                                editing : _iseditable,
                                              //  value:LatLng( double.parse(lat) ,double.parse(long)) ,
                                                //iwant to put the selected address named address
                                                width: 250,
                                                height: 300,
                                              ),
                                              Container(
                                                width: 250,
                                                child: CustomText(
                                                  text: address,
                                                  color: black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 60,
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  CustomText(
                                                    text: "Fee in SR:",
                                                    color: black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  CustomTextFiled(
                                                    width: 0.13,
                                                    iseditable: _iseditable,
                                                    value: fee,
                                                    text: "Fee",
                                                    controller: RBAccountState
                                                        .myRBControllerForEdit[3],
                                                    isvalid: Controller
                                                        .deliveryfeeValidation,
                                                    maxLen: 7,
                                                    allowed:
                                                        regonlynumberandDot,
                                                    onLostFocus: (text) {
                                                      // Add your code here to handle the message when the field loses focus
                                                      print(
                                                          "Field lost focus: $text");
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  CustomText(
                                                    text: " Start time:",
                                                    color: black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  Stack(
                                                    children: [
                                                      //   if (RBFirstSignUpState.values['endTime'] ==RBFirstSignUpState.values['endTime'] )
                                                      RBedittimestart(
                                                        isEditable: _iseditable,
                                                        onTimeSelected:
                                                            (selectedTime) {
                                                          timeFromPicker =
                                                              false;

                                                          // You can save it, display it, or perform any other action with the selected time.
                                                          RBAccountState
                                                              .myRBControllerForEdit[
                                                                  7]
                                                              .text = selectedTime;
                                                          RBedittimestartState
                                                                  .val =
                                                              selectedTime;
                                                          print(
                                                              "You're in start");
                                                          print(
                                                              "You choose start " +
                                                                  selectedTime);

                                                          String? startTime =
                                                              RBAccountState
                                                                  .myRBControllerForEdit[
                                                                      7]
                                                                  .text;
                                                          String? endTime =
                                                              RBAccountState
                                                                  .myRBControllerForEdit[
                                                                      8]
                                                                  .text;

                                                          if (endTime != null) {
                                                            // Check if selectedTime doesn't end with AM or PM
                                                            if (!endTime
                                                                    .endsWith(
                                                                        "AM") &&
                                                                !endTime
                                                                    .endsWith(
                                                                        "PM")) {
                                                              timeFromPicker =
                                                                  true;

                                                              List<String>
                                                                  parts =
                                                                  endTime.split(
                                                                      ':');
                                                              if (parts
                                                                      .length ==
                                                                  2) {
                                                                int hours =
                                                                    int.parse(
                                                                        parts[
                                                                            0]);
                                                                int minutes =
                                                                    int.parse(
                                                                        parts[
                                                                            1]);

                                                                if (0 <=
                                                                        hours &&
                                                                    hours <=
                                                                        11) {
                                                                  endTime +=
                                                                      " AM";
                                                                } else if (hours ==
                                                                    12) {
                                                                  endTime +=
                                                                      " PM";
                                                                } else if (13 <=
                                                                        hours &&
                                                                    hours <=
                                                                        23) {
                                                                  endTime =
                                                                      "${hours - 12}:${minutes.toString().padLeft(2, '0')} PM";
                                                                }
                                                              }
                                                            }
                                                          }

                                                          print(startTime);
                                                          print(endTime);

                                                          if (startTime !=
                                                                  null &&
                                                              endTime != null) {
                                                            DateFormat
                                                                formatter =
                                                                DateFormat(
                                                                    'HH:mm a'); // Define the formatter
                                                            DateTime time1 =
                                                                formatter.parse(
                                                                    startTime);
                                                            DateTime time2 =
                                                                formatter.parse(
                                                                    endTime);

                                                            print(time1);

                                                            // Check if the parsed time is midnight (00:00)
                                                            if (time1.hour ==
                                                                0) {
                                                              // Convert it to noon (12:00 PM)
                                                              time1 = DateTime(
                                                                  1970,
                                                                  01,
                                                                  01,
                                                                  12,
                                                                  time1.minute,
                                                                  time1.second);
                                                              print(time1);
                                                            }
                                                            // Check if the parsed time is afternoon (12:00)
                                                            else if (time1
                                                                    .hour ==
                                                                12) {
                                                              // Convert it to noon (12:00 PM)
                                                              time1 = DateTime(
                                                                  1970,
                                                                  01,
                                                                  01,
                                                                  00,
                                                                  time1.minute,
                                                                  time1.second);
                                                              print(time1);
                                                            }

                                                            // Check if the parsed time is midnight (00:00)
                                                            if (time2.hour ==
                                                                0) {
                                                              // Convert it to noon (12:00 PM)
                                                              time2 = DateTime(
                                                                  1970,
                                                                  01,
                                                                  01,
                                                                  12,
                                                                  time2.minute,
                                                                  time2.second);
                                                              print(time2);
                                                            }

                                                            // Check if the parsed time is afternoon (12:00)
                                                            else if (time2
                                                                    .hour ==
                                                                12) {
                                                              // Convert it to noon (12:00 PM)
                                                              time2 = DateTime(
                                                                  1970,
                                                                  01,
                                                                  01,
                                                                  00,
                                                                  time2.minute,
                                                                  time2.second);

                                                              print(time2);
                                                            }

                                                            print(time1);
                                                            print(time2);

                                                            if (!timeFromPicker) {
                                                              if (time1 ==
                                                                  time2) {
                                                                setState(() {
                                                                  timeGo =
                                                                      false;
                                                                  errorMsg =
                                                                      "start and end time can not be the same";
                                                                });
                                                              }

                                                              if (time1.isAfter(
                                                                  time2)) {
                                                                setState(() {
                                                                  timeGo =
                                                                      false;
                                                                  errorMsg =
                                                                      "Start time can not be after the end time";
                                                                });
                                                              } else {
                                                                // Reset the error message when a valid time is selected
                                                                setState(() {
                                                                  timeGo = true;
                                                                  errorMsg = "";
                                                                });
                                                              }
                                                            } //timeformpicker
                                                          }
                                                        },
                                                      ),
                                                      if (errorMsg != null)
                                                        Transform.translate(
                                                          offset: Offset(25,
                                                              50), // Adjust the Y-offset to move the text upwards
                                                          child: Text(
                                                            // Display the error message conditionally
                                                            errorMsg!,
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  CustomText(
                                                    text: "End time:",
                                                    color: black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  Stack(
                                                    children: [
                                                      //   if (RBFirstSignUpState.values['endTime'] ==RBFirstSignUpState.values['endTime'] )
                                                      RBedittimeend(
                                                        isEditable: _iseditable,
                                                        onTimeSelected:
                                                            (selectedTime) {
                                                          timeFromPicker =
                                                              false;

                                                          // You can save it, display it, or perform any other action with the selected time.
                                                          RBAccountState
                                                              .myRBControllerForEdit[
                                                                  8]
                                                              .text = selectedTime;
                                                          RBedittimeendState
                                                                  .val =
                                                              selectedTime;
                                                          print(
                                                              "You're in end");
                                                          print(
                                                              "You choose end " +
                                                                  selectedTime);

                                                          String? startTime =
                                                              RBAccountState
                                                                  .myRBControllerForEdit[
                                                                      7]
                                                                  .text;
                                                          String? endTime =
                                                              RBAccountState
                                                                  .myRBControllerForEdit[
                                                                      8]
                                                                  .text;

                                                          if (startTime !=
                                                              null) {
                                                            // Check if selectedTime doesn't end with AM or PM
                                                            if (!startTime
                                                                    .endsWith(
                                                                        "AM") &&
                                                                !startTime
                                                                    .endsWith(
                                                                        "PM")) {
                                                              List<String>
                                                                  parts =
                                                                  startTime
                                                                      .split(
                                                                          ':');
                                                              if (parts
                                                                      .length ==
                                                                  2) {
                                                                int hours =
                                                                    int.parse(
                                                                        parts[
                                                                            0]);
                                                                int minutes =
                                                                    int.parse(
                                                                        parts[
                                                                            1]);

                                                                if (0 <=
                                                                        hours &&
                                                                    hours <=
                                                                        11) {
                                                                  startTime +=
                                                                      " AM";
                                                                } else if (hours ==
                                                                    12) {
                                                                  startTime +=
                                                                      " PM";
                                                                } else if (13 <=
                                                                        hours &&
                                                                    hours <=
                                                                        23) {
                                                                  startTime =
                                                                      "${hours - 12}:${minutes.toString().padLeft(2, '0')} PM";
                                                                }
                                                              }
                                                            }
                                                          }

                                                          print(startTime);
                                                          print(endTime);

                                                          if (startTime !=
                                                                  null &&
                                                              endTime != null) {
                                                            DateFormat
                                                                formatter =
                                                                DateFormat(
                                                                    'HH:mm a'); // Define the formatter
                                                            DateTime time1 =
                                                                formatter.parse(
                                                                    startTime);
                                                            DateTime time2 =
                                                                formatter.parse(
                                                                    endTime);

                                                            print(time2.hour);

                                                            // Check if the parsed time is midnight (00:00)
                                                            if (time1.hour ==
                                                                0) {
                                                              // Convert it to noon (12:00 PM)
                                                              time1 = DateTime(
                                                                  1970,
                                                                  01,
                                                                  01,
                                                                  12,
                                                                  time1.minute,
                                                                  time1.second);
                                                              print(time1);
                                                            }
                                                            // Check if the parsed time is afternoon (12:00)
                                                            else if (time1
                                                                    .hour ==
                                                                12) {
                                                              // Convert it to noon (12:00 PM)
                                                              time1 = DateTime(
                                                                  1970,
                                                                  01,
                                                                  01,
                                                                  00,
                                                                  time1.minute,
                                                                  time1.second);
                                                              print(time1);
                                                            }

                                                            // Check if the parsed time is midnight (00:00)
                                                            if (time2.hour ==
                                                                0) {
                                                              // Convert it to noon (12:00 PM)
                                                              time2 = DateTime(
                                                                  1970,
                                                                  01,
                                                                  01,
                                                                  12,
                                                                  time2.minute,
                                                                  time2.second);
                                                              print(time2);
                                                            }

                                                            // Check if the parsed time is afternoon (12:00)
                                                            else if (time2
                                                                    .hour ==
                                                                12) {
                                                              // Convert it to noon (12:00 PM)
                                                              time2 = DateTime(
                                                                  1970,
                                                                  01,
                                                                  01,
                                                                  00,
                                                                  time2.minute,
                                                                  time2.second);

                                                              print(time2);
                                                            }

                                                            print(time1);
                                                            print(time2);

                                                            if (!timeFromPicker) {
                                                              if (time1 ==
                                                                  time2) {
                                                                setState(() {
                                                                  timeGo =
                                                                      false;
                                                                  errorMsg =
                                                                      "start and end time can not be the same";
                                                                });
                                                              } else if (time1
                                                                  .isAfter(
                                                                      time2)) {
                                                                setState(() {
                                                                  timeGo =
                                                                      false;
                                                                  errorMsg =
                                                                      "Start time can not be after the end time";
                                                                });
                                                              } else {
                                                                // Reset the error message when a valid time is selected
                                                                setState(() {
                                                                  timeGo = true;
                                                                  errorMsg = "";
                                                                });
                                                              }
                                                            } //timefrompicker
                                                          }
                                                        },
                                                      ),

                                                      if (errorMsg != null)
                                                        Transform.translate(
                                                          offset: Offset(25,
                                                              50), // Adjust the Y-offset to move the text upwards
                                                          child: Text(
                                                            // Display the error message conditionally
                                                            errorMsg!,
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              CustomButton(
                                                  type: "delete1",
                                                  text: "Delete Account",
                                                  width: 0.14,
                                                  height: 0.08,
                                                  onPressed: () {
                                                    showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            deleteAccount());
                                                  })
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ), //col
                  ),
                ), //senter
              )
            : Center(
                child: CircularProgressIndicator(),
              )); //scafold
  } //build
} //class
