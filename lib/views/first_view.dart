import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';


class FirstView extends StatelessWidget {

  final primaryColor = const Color(0xFF75A2EA);

  @override
  Widget build(BuildContext context) {

    //scales the conatiner to suit size of screen
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: primaryColor,

        //maintains all the widgets within the safe boundary
        child: SafeArea( 
          child: Column(
            children: <Widget>[
              Text(
                'Welcome', 
                style: TextStyle(
                  fontSize: 44.0, 
                  color: Colors.white)
              ),

              //Autosize text (external package for interactive design)
              AutoSizeText(
                "Let's start planning your trip",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0, 
                  color: Colors.white)
              ),
            ],
          ),
        ),
      ),
    );
  }
}