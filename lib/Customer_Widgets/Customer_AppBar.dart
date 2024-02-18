import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final actions;
  final wantback;

  CustomAppBar({this.actions = null, this.wantback = false  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
        actionsIconTheme: IconThemeData(color: white),
        leading: wantback  ? BackButton(color: white ) : null,
        automaticallyImplyLeading: wantback, //true,
        backgroundColor: Batatis_Dark,
        title: Container(
          alignment: Alignment.bottomLeft,
          //  transformAlignment:
          child: Image.asset(
            'assets/Images/BatatisLogo.jpeg',
            alignment: Alignment.bottomLeft,
            width: 120,
            height: 145,
          ),
        ),
        actions: actions);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
