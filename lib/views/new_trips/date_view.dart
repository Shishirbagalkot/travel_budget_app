import 'package:flutter/material.dart';
import 'package:travel_treasury/models/trip.dart';
import 'package:travel_treasury/views/new_trips/budget_view.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';
import 'dart:async'; //for Future functions

class NewTripDateView extends StatefulWidget {

  final Trip trip;
  NewTripDateView({Key key, @required this.trip}) : super(key: key);

  @override
  _NewTripDateViewState createState() => _NewTripDateViewState();
}

class _NewTripDateViewState extends State<NewTripDateView> {

  DateTime _startDate = new DateTime.now();
  DateTime _endDate = new DateTime.now().add(Duration(days: 7));

  Future displayDateRangePicker(BuildContext context) async {
    final List<DateTime> picked = await DateRangePicker.showDatePicker(
      context: context, 
      initialFirstDate: _startDate, 
      initialLastDate: _endDate, 
      firstDate: new DateTime(2020), 
      lastDate: new DateTime(2022)
    );

    //picked length min 2, start and end date
    if (picked != null && picked.length == 2) {
      setState(() {
        _startDate = picked[0];
        _endDate = picked[1];
      });
    }
  }

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
            buildSelectedDetails(context, widget.trip),

            Spacer(),
            Text("Location ${widget.trip.title}"),

            //date picker
            ElevatedButton(
              onPressed: () async{
                await displayDateRangePicker(context);
              }, 
              child: Text("Select Date")
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Start Date: ${DateFormat('dd/MM/yyyy').format(_startDate).toString()}"),
                Text("End Date: ${DateFormat('dd/MM/yyyy').format(_endDate).toString()}"),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                widget.trip.startDate = _startDate;
                widget.trip.endDate = _endDate;
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => NewTripBudgetView(trip: widget.trip)
                  ),
                );
              }, 
              child: Text("Continue"),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  //this widget is displayed at the top of date view page
  Widget buildSelectedDetails(BuildContext context, Trip trip) {
    return Hero(
      tag: "SelectedTrip-${trip.title}",
      transitionOnUserGestures: true,
        child: Container(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0
          ),
          child: SingleChildScrollView(
              child: Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0 ,left: 16.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                            Text(trip.title, style: TextStyle(fontSize: 20.0)),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Average Budget -- Not setup yet"),
                            ]
                          ),
                          Row(
                            children: <Widget>[
                              Text("Trip Dates"),
                            ]
                          ),
                          Row(
                            children: <Widget>[
                              Text("Trip Budget"),
                            ]
                          ),
                          Row(
                            children: <Widget>[
                              Text("Trip Type"),
                            ]
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Placeholder(
                        fallbackHeight: 100,
                        fallbackWidth: 100,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}