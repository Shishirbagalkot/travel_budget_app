import 'package:flutter/material.dart';
import 'package:travel_treasury/trip.dart';
import 'package:intl/intl.dart'; //used to format date to be displayed 

class HomeView extends StatelessWidget {

  final List<Trip> tripsList = [
    Trip("Bangalore", DateTime.now(), DateTime.now(), 10000.00, "Car"),
    Trip("Mumbai", DateTime.now(), DateTime.now(), 5000.00, "Bike"),
    Trip("Delhi", DateTime.now(), DateTime.now(), 6000.00, "Train"),
    Trip("Hyderabad", DateTime.now(), DateTime.now(), 12000.00, "Bus"),
  ]; 

  @override

  //list view builder
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: tripsList.length,
        itemBuilder: (BuildContext context, int index) => buildTripCard(context, index)
      ),
    );
  }

  //widget for showing location cards
  Widget buildTripCard (BuildContext context, int index) {

    final trip = tripsList[index];

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
                    Text(trip.title, style: TextStyle(fontSize: 30.0),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                child: Row(
                  children: <Widget>[
                    Text("${DateFormat('dd/MM/yyyy').format(trip.startDate).toString()} - ${DateFormat('dd/MM/yyyy').format(trip.endDate).toString()}"),  
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text("₹${trip.budget.toStringAsFixed(2)}", style: TextStyle(fontSize: 35.0),),
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