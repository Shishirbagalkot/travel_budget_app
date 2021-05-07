import 'package:flutter/material.dart';
import 'package:travel_treasury/models/trip.dart';
import 'package:travel_treasury/models/places.dart';
import 'package:travel_treasury/widgets/divider_with_text_widget.dart';

class NewTripLocationView extends StatelessWidget {

  final Trip trip;
  NewTripLocationView({Key key, @required this.trip}) : super(key: key);

  final List<Place> _placesList = [
    Place("Bangalore", 5000.00),
    Place("Mangalore", 4000.00),
    Place("Mysore", 4000.00),
    Place("Mumbai", 6000.00),
    Place("Chennai", 4000.00),
  ];

  @override
  Widget build(BuildContext context) {

    //for the text field
    TextEditingController _titleController = new TextEditingController();

    _titleController.text = trip.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Trip-Location'
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Search"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: DividerWithText(dividerText:"Suggestions"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _placesList.length,
                itemBuilder: (BuildContext context, int index) => buildPlaceCard(context, index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlaceCard(BuildContext context, int index) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0, 
          right: 8.0),
          child: Card(
            child: InkWell(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(_placesList[index].name, style: TextStyle(fontSize: 20.0),),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("Average Budget ₹${_placesList[index].averageBudget.toStringAsFixed(2)}", style: TextStyle(fontSize: 20.0),),
                            ],
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}

