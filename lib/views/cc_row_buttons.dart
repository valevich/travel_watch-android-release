import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

typedef onSaveCallBack = Function(int currentPageIndex);

class RowButtons extends StatelessWidget {
  final onSaveCallBack onSave;
  final int activePageIndex;

  RowButtons({this.onSave, this.activePageIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
        gradient: new LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                onSave(0);
              },
              child: singleButtonWidget("Converter",
                  activeColor:
                      activePageIndex == 0 ? Colors.white : Colors.black)),
          GestureDetector(
              onTap: () {
                onSave(1);
              },
              child: singleButtonWidget("Rates",
                  activeColor:
                      activePageIndex == 1 ? Colors.white : Colors.black)),
        ],
      ),
    );
  }

  Widget singleButtonWidget(String text, {Color activeColor = Colors.white}) {
    return Container(
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: activeColor),
      ),
    );
  }
}
