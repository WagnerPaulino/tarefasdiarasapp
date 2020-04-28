import 'package:flutter/material.dart';

class ToolBarComponent extends StatelessWidget {
  ToolBarComponent(this.title);

  String title = "";
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: EdgeInsets.only(top: 40, right: 15, left: 15),
        sliver: SliverAppBar(
          floating: true,
          expandedHeight: 10,
          leading: Container(
            height: 0,
            width: 0,
          ),
          primary: false,
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              side: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  style: BorderStyle.solid)),
          actions: <Widget>[
            Text(
              this.title,
              style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        ));
  }
}
