import 'package:flutter/material.dart';
import 'package:travel_treasury/models/trip.dart';

class NewTripBudgetView extends StatelessWidget {

  final Trip trip;
  NewTripBudgetView({Key key, @required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Trip-Budget'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Finish"),
            ElevatedButton(
              child: Text("Finish"),
              onPressed: () { //save data to firebase
                //removes all pages from stack and goes to first page
                Navigator.of(context).popUntil((route) => route.isFirst);
              }, 
            ),
          ],
        ),
      ),
    );
  }
}