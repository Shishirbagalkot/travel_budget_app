import 'package:flutter/material.dart';
import 'package:travel_treasury/models/trip.dart';

class NewTripLocationView extends StatelessWidget {

  final Trip trip;
  NewTripLocationView({Key key, @required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //for the text field
    TextEditingController _titleController = new TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Trip-Location'
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Enter a location"),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _titleController,
                autofocus: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                
              }, 
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}