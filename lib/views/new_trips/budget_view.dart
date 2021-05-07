import 'package:flutter/material.dart';
import 'package:travel_treasury/models/trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_treasury/widgets/provider_widget.dart';

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
            Text("Location: ${trip.title}"),
            Text("Location ${trip.startDate}"),
            Text("Location ${trip.endDate}"),

            ElevatedButton(
              child: Text("Finish"),
              onPressed: () async{ 
                //save data to firebase, async to prevent lock-up of frontend
                final uid = await Provider.of(context).auth.getCurrentUID();
                //trip.toJson is added from Map from trip.dart
                await db.collection("userData").doc(uid).collection("trips").add(trip.toJson());

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