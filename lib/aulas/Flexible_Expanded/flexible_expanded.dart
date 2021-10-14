import 'package:flutter/material.dart';

class FlexibleExpanded extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          height: 100,
          child: Text('Item 1 - pretty big!'),
          color: Colors.red,
        ),
        Expanded(
          flex: 4,
          // fit: FlexFit.tight,
          child: Container(
            height: 100,
            child: Text('Item 2'),
            color: Colors.blue,
          ),
        ),
        Flexible(
          fit: FlexFit.loose,
          child: Container(
            height: 100,
            child: Text('Item 3'),
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}