import 'package:flutter/material.dart';
import 'package:travel_treasury/models/trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewTripBudgetView extends StatelessWidget {

  final db = FirebaseFirestore.instance;

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
            Text("Location ${trip.title}"),
            Text("Location ${trip.startDate}"),
            Text("Location ${trip.endDate}"),

            ElevatedButton(
              child: Text("Finish"),
              onPressed: () async{ 
                //save data to firebase, async to prevent lock-up of frontend
                await db.collection("trips").add(
                  {
                    'title': trip.title,
                    'startDate': trip.startDate,
                    'endDate': trip.endDate,
                  }
                );
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