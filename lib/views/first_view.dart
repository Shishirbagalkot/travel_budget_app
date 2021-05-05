import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:travel_treasury/widgets/custom_dialog.dart';


class FirstView extends StatelessWidget {

  final primaryColor = const Color(0xFF75A2EA);

  @override
  Widget build(BuildContext context) {

    //scales the conatiner to suit size of screen
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        color: primaryColor,

        //maintains all the widgets within the safe boundary
        child: SafeArea( 
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                //adding sized box dimensions relative to size of screen
                SizedBox(height: _height * .10),
                Text(
                  'Welcome', 
                  style: TextStyle(
                    fontSize: 45.0, 
                    color: Colors.white)
                ),
                SizedBox(height: _height * .10),
                //Autosize text (external package for interactive design)
                AutoSizeText(
                  "Your next trip's plan starts here",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35.0, 
                    color: Colors.white)
                ),
                SizedBox(height: _height * .15),
                // ignore: deprecated_member_use
                RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  //redirect to dialog box
                  onPressed: () {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) => CustomDialog(
                        title: "Would you like to create a free account?", 
                        description: "With an account created, your data will be secure and can be accessed from multiple devices", 
                        primaryButtonText: "Create My Account", 
                        primaryButtonRoute: "/signUp",
                        secondaryButtonText: "Maybe Later", 
                        secondaryButtonRoute: "/anonymousSignIn",
                      )
                    );
                  }, 
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 30.0, right: 30.0),
                    child: Text("Get Started", style: TextStyle(color: primaryColor, fontSize: 28.0, fontWeight: FontWeight.w300)),
                  ),
                ),
                SizedBox(height: _height * .05),
                TextButton(
                  //redirect to sign in page
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/signIn');
                  }, 
                  child: Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 25.0,))
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}