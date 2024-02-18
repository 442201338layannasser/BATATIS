import 'package:batatis/RestaurantBranch_Screens/RBRegisterFirst.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:batatis/main.dart';

/*
class MENUdropdown extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final void Function(String?)? onChanged;
  final String Function(String?)? validator;

  MENUdropdown({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
   required this.validator,
  });

  Color gg = Color.fromRGBO(127, 128, 129, 1);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
     validator:validator,
      value: selectedValue,
      items: ['Burgers', 'Sweats & Coffee', 'Bakery', 'Juice'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged ,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        fillColor: grey_light,
        filled: true,
        hintStyle: TextStyle(
          color: Color.fromRGBO(127, 128, 129, 1),
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
        
      ),
    );
  }
}
* */

class MENUdropdown extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final Function(String) onChanged;
  final StateSetter  setState ; 

  MENUdropdown({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.setState
    
  });
Color gg = Color.fromRGBO(127, 128, 129, 1) ; 
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(

      itemBuilder: (BuildContext context) {
        return items.map<PopupMenuEntry<String>>((String value) {
      
          return PopupMenuItem<String>(
          //  textStyle: TextStyle(color: Colors.red),
            //labelTextStyle: TextStyle(color: Colors.green) ,
            value: value,
            child: Text(value),
          );
        }).toList();
      },
      onSelected: (String newValue,) {
       setState((){
        gg = Colors.black ;});
        
        onChanged(newValue);
        
       
      },
      
       elevation: 0,
       tooltip: "",
       
      child: Container(
        //  width:   0.40 * Batatis.Swidth,
        //   height: 0.09 * Batatis.Sheight ,
        width: MediaQuery.of(context).size.width * 0.40,
        height: MediaQuery.of(context).size.height * 0.09,
        margin: EdgeInsets.only(bottom: 15),
      
        
        
        decoration: BoxDecoration(
          color: grey_light,
          borderRadius: BorderRadius.circular(30),
          
        ),
        
      child: Center(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              selectedValue,
              style: TextStyle(
                color:gg ,  //Color.fromRGBO(127, 128, 129, 1),
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
         ),
    
    );
  }
}
