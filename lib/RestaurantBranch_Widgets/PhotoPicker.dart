

import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:batatis/Customer_Widgets/colors.dart';
import 'package:batatis/RestaurantBranch_Widgets/RestaurantBranch_texts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPicker extends StatefulWidget {
  
  //final Function(File) onImageSelected;
// String Rid ;
// String Bid ;
// String Imgname ;
//PhotoPicker({scale }) ;
   PhotoPicker({Key? key , required this.img , required this.width ,required this.height , this.editing = true }) : super(key: key);
 Widget img ; 
 var width;
  var height;
  var editing ; 


  @override
  _PhotoPickerState createState() => _PhotoPickerState();

  static void uploadBytes(String path) {
    _PhotoPickerState.uploadBytes(path);
  }

  static Future<void> getimg(imgpath) async {
    await _PhotoPickerState.getImageurl(imgpath);
    //print(" this is the path " + imgpath);
    // return _PhotoPickerState.getImageurl(imgpath);
  }
  static void getBytes(String path) {
      _PhotoPickerState.getImagebytes(path);
    }
  static geturl() => _PhotoPickerState.URL;
  static getbytes() => _PhotoPickerState.bytes;
  static bool Ispicked() {
    print("is picked");
    if (_PhotoPickerState.picked != null) {
      return true;
    } else {
      return false;
    }
  }
}

class _PhotoPickerState extends State<PhotoPicker> {
  // static var picked;
  // final ImagePicker _imagePicker = ImagePicker();
  // XFile? _selectedImage;

  // Future<void> _pickImageFromGallery() async {
  //   final XFile? selectedImage = await _imagePicker.pickImage(
  //     source: ImageSource.gallery,
  //   );

  //   if (selectedImage != null) {
  //     setState(() {
  //       _selectedImage = selectedImage;
  //     });

  //     widget.onImageSelected(File(selectedImage.path));
  //   }
  //}
  //Widget displayed = widget.img ; 
  static String URL = " ";
  static Uint8List? bytes = [] as Uint8List? ;
  List<Widget> colchildren = [
    // Center(
    //     child: CustomText(
    //         text: "Pick your resturant logo from Gallery", type: "default")),
            
  ];
  bool flag = true ;
  @override
  Widget build(BuildContext context) {
    if(flag){
  colchildren.add(widget.img);
  flag = false ;}
    return GestureDetector(
      onTap: widget.editing? pickApic : (){}, // Trigger the image picker when the container is tapped
      child: 
      SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.all(0.0),
        width: widget.width,//MediaQuery.of(context).size.width * 0.16,
        height:widget.height ,//MediaQuery.of(context).size.height * 0.1,
        //margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          //color: grey_light,
         // borderRadius: BorderRadius.circular(30),
        ),
        child: Column(children: colchildren
            //[
            // if (_selectedImage != null)
            //   Image.file(
            //     File(_selectedImage!.path),
            //     height: 150,
            //     width: 150,
            //   ),

            // CustomText(text:"Pick your resturant logo from Gallery", type:"default" ),

            //],
            ),
      )),
    );
  }

  // static Uint8List? bytes  ;
  static var picked;
  Future<void> pickApic() async {
    picked = await FilePicker.platform.pickFiles(type: FileType.image);

    if (picked != null) {
      print(picked.files.first.name);
      var bytes = picked.files.first.bytes!;
      setState(() {
        colchildren = [];
        //colchildren.add(CustomText(text: "your img ", type: "default"));
        colchildren.add(Center (child:  Image.memory(
          bytes!,
          width: widget.width  ,
          height: widget.height,
          
        )));
      });

      //  uploadBytes(bytes!,picked.files.first.name);
    } else {
      return;
    }
    // return bytes ;//Text("data");
  }

  static Future<void> uploadBytes( String path) async {
    try {
      var bytes = picked.files.first.bytes;
      print("uploadBytes");
      print(bytes.length);
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("$path.png");
      print("upload bytes " + "$path.png");
      await storageReference.putData(bytes!);
      print('Upload successful');
      // getImage("/imgs/$fileName");
    } catch (e) {
      print('Error uploading bytes to Firebase Storage: $e');
    }
  }

  static Future<void> getImageurl(String imagePath) async {
    var storage = FirebaseStorage.instance;
    var storageRef = storage.ref();
    // const imagePath = '/images/1694214275894.jpg'; // Replace with your image path.

    URL = await storageRef.child("$imagePath.png").getDownloadURL();

print("the urlll" + URL);
    //print("asdfghjkl;poiuytrewqzxcvbnm,.");
    // Use the URL to display the image or perform any other operations.
    //print("Download URL: ${url}");
    //// You can set the URL as the source of an <img> tag.
    // const imgElement = document.getElementById('imageElement');

    //return ;

    //return "ptata" ;
    // final Reference storageReference = FirebaseStorage.instance.ref().child("gs://batatis14-ab827.appspot.com/bytes/imgByte1");
    // print(80);
    // final data = await storageReference.getData();
    // print(82);
    // //return Uint8List.fromList(data);
    // print(data);
  }

    static Future<void> getImagebytes(String imagePath) async {
    var storage = FirebaseStorage.instance;
    var storageRef = storage.ref();
    bytes = await storageRef.child("$imagePath.png").getData();
    print("the bytes" + bytes!.isEmpty.toString() );
  }
}
