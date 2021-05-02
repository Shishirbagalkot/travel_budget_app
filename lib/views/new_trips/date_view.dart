import 'package:flutter/material.dart';
import 'package:travel_treasury/models/trip.dart';
import 'package:travel_treasury/views/new_trips/budget_view.dart';

class NewTripDateView extends StatelessWidget {

  final Trip trip;
  NewTripDateView({Key key, @required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Trip-Date'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Enter start Date"),
                Text("Enter end Date"),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => NewTripBudgetView(trip: trip)
                  ),
                );
              }, 
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}