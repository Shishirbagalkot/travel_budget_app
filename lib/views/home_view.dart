import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //used to format date to be displayed 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_treasury/widgets/provider_widget.dart';

class HomeView extends StatelessWidget {

  @override

  //list view builder
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: getUsersTripStreamSnapshot(context),
        builder: (context, snapshot) {
          if(!snapshot.hasData) return const Text("Loading...");
          else{
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) => 
              buildTripCard(context, snapshot.data.docs[index])
            );
          }
        }
      ),
    );
  }

  Stream<QuerySnapshot> getUsersTripStreamSnapshot(BuildContext context) async*{
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* FirebaseFirestore.instance.collection('userData').doc(uid).collection('trips').snapshots();
  }

  //widget for showing location cards
  Widget buildTripCard (BuildContext context, DocumentSnapshot trip) {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(
                  children: <Widget>[
                    Text(trip['title'], style: TextStyle(fontSize: 30.0),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                child: Row(
                  children: <Widget>[
                    Text("${DateFormat('dd/MM/yyyy').format(trip['startDate'].toDate()).toString()} - ${DateFormat('dd/MM/yyyy').format(trip['endDate'].toDate()).toString()}"),  
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text("₹${(trip['budget'] == null)? "n/a" : trip['budget'].toStringAsFixed(2)}", style: TextStyle(fontSize: 35.0),),
                    Spacer(),
                    Icon(Icons.directions_car),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}