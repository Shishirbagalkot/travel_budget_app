import 'package:flutter/material.dart';


/*this class creates a divider with the text specified for dividerText and places 
it in between the two dividers*/
class DividerWithText extends StatelessWidget {
  final dividerText;

  const DividerWithText({Key key, @required this.dividerText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Divider(),
        )),
        Text("Suggestions"),
        Expanded(child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Divider(),
        )),
      ],
    );
  }
}