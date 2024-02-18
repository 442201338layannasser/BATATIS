
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PhotoPicker extends StatefulWidget {// this class deals with img picking img storing and img retreving 
  
   PhotoPicker({Key? key , required this.img , required this.width ,required this.height }) : super(key: key);
    Widget img ; 
    var width;
    var height;


  @override
  _PhotoPickerState createState() => _PhotoPickerState();

  static void uploadBytes(String path) {// storeing the img in the provided path 
    _PhotoPickerState.uploadBytes(path);
  }

  static Future<void> getimg(imgpath) async { // getting the img from the path (set the URL variable )
    await _PhotoPickerState.getImageurl(imgpath);}

  static Future<void> getBytes(String path)async {// getting the img too but has spical use for ash(set the bytes variable )
      await _PhotoPickerState.getImagebytes(path);
    }
  static geturl() => _PhotoPickerState.URL;// getting the url(img)
  static getbytes() => _PhotoPickerState.bytes; // getting the bytes(Ash img) 
  
  static bool Ispicked() { // method to check if the photo been pick yet 
    if (_PhotoPickerState.picked != null) {
      return true;
    } else {
      return false;
    }
  }
}

class _PhotoPickerState extends State<PhotoPicker> { 
  static String URL = " ";
  static Uint8List? bytes = [] as Uint8List? ; // ash 
  List<Widget> colchildren = [];
  bool flag = true ;
  @override
  Widget build(BuildContext context) {
    if(flag){
  colchildren.add(widget.img);
  flag = false ;}
    return GestureDetector(
      onTap: pickApic, // Trigger the image picker when the container is tapped
      child: 
      SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.all(0.0),
        width: widget.width,//MediaQuery.of(context).size.width * 0.16,
        height:widget.height ,//MediaQuery.of(context).size.height * 0.1,
      
        decoration: BoxDecoration(
        ),
        child: Column(children: colchildren
           
            ),
      )),
    );
  }

  // static Uint8List? bytes  ;
  static var picked;
  Future<void> pickApic() async { // the pickker  and display for the img
    picked = await FilePicker.platform.pickFiles(type: FileType.image);

    if (picked != null) {
      print(picked.files.first.name);
      var bytes = picked.files.first.bytes!;
      setState(() {
        colchildren = [];
        colchildren.add(Center (child:  Image.memory(
          bytes!,
          width: widget.width  ,
          height: widget.height,
          
        )));
      });
    } else {
      return;
    }
  }

  static Future<void> uploadBytes( String path) async { // store the img in the path 
    try {
      var bytes = picked.files.first.bytes;
      print("uploadBytes");
      print(bytes.length);
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("$path.png");
      await storageReference.putData(bytes!);
      print('Upload successful');
    } catch (e) {
      print('Error uploading bytes to Firebase Storage: $e');
    }
  }

  static Future<void> getImageurl(String imagePath) async { // get the img (set the url )
    var storage = FirebaseStorage.instance;
    var storageRef = storage.ref();
    URL = await storageRef.child("$imagePath.png").getDownloadURL();
    print("Url been set good " + URL);
   
  }


    static Future<void> getImagebytes(String imagePath) async {// get the img (set the bytes )
    var storage = FirebaseStorage.instance;
    var storageRef = storage.ref();
    bytes = await storageRef.child("$imagePath.png").getData();
    print("the bytes been set good" + bytes!.isEmpty.toString() );
  }
}
