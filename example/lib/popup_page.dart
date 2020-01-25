import 'package:flutter/material.dart';
import 'package:flutter_page_tracker/flutter_page_tracker.dart';
import 'dart:math';

class PopupPage extends StatelessWidget {

  const PopupPage({
    Key key,
  }): super(key: key);

  Widget _button(String text, VoidCallback onTap) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.amber[500 + 100 * Random().nextInt(4)],
          height: 50,
          child: Center(
            child: Text(text),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      children: <Widget>[
        ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Container(
            child: TrackerDialogWrapper(
              didPageView: () {
                print('dialog didPageView');
              },
              didPageExit: () {
                print('dialog didPageExit');
              },
              child: Container(
                width: 400,
                color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text("When you show a dialog, only PageView event will be trigged. "),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text("You can see 'dialog didPageView' in the console. "),
                    ),
                    Container(height: 10,),
                    _button("Go to anther PageRoute, will not trigger PageExit on this dialog", () {
                      Navigator.of(context).pushNamed("detail");
                    }),
                    _button("Close dialog, will not trigger PageView on Previous route", () {
                      Navigator.of(context).pop();
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}