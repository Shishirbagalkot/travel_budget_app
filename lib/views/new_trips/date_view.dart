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
          ],
        ),
      ),
    );
  }
}