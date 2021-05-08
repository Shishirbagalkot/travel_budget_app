import 'package:flutter/material.dart';
import 'package:travel_treasury/models/trip.dart';
import 'package:travel_treasury/models/places.dart';
import 'package:travel_treasury/views/new_trips/date_view.dart';
import 'package:travel_treasury/widgets/divider_with_text_widget.dart';
import 'package:travel_treasury/credentials.dart';
import 'package:dio/dio.dart';

class NewTripLocationView extends StatefulWidget {

  final Trip trip;
  NewTripLocationView({Key key, @required this.trip}) : super(key: key);

  @override
  _NewTripLocationViewState createState() => _NewTripLocationViewState();
}

class _NewTripLocationViewState extends State<NewTripLocationView> {
  String _heading;

  final List<Place> _placesList = [
    Place("Bangalore", 5000.00),
    Place("Mangalore", 4000.00),
    Place("Mysore", 4000.00),
    Place("Mumbai", 6000.00),
    Place("Chennai", 4000.00),
  ];

  @override
  void initState() {
    super.initState();
    _heading = "Suggestions";
  }

  void getLocationResults(String input) async{
    if(input.isEmpty) {
      setState(() {
        _heading = "Suggestions";
      });
      return;
    } 
    
    //requires billing hence try to use plugin
    //google places api call
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String type = '(regions)';
    String request = '$baseURL?input=$input&key=$PLACES_API_KEY&type=$type';
    Response response = await Dio().get(request);

    print(response);

    setState(() {
      _heading = "Results";
    });
  }

  @override
  Widget build(BuildContext context) {

    //for the text field
    // TextEditingController _titleController = new TextEditingController();
    // _titleController.text = widget.trip.title;

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
                //controller: _titleController,
                decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Search"),
                //take the text entered into this field ans display results from places api
                onChanged: (text) {
                  getLocationResults(text);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                //dividerithtext widget not working hence using this
                children: [
                  Expanded(child: Divider()),
                  Text(_heading),
                  Expanded(child: Divider()),
                ],
              ),
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
    //hero widget for the animation after selecting a location from suggested
    return Hero(
      tag: "SelectedTrip-${_placesList[index].name}",
      transitionOnUserGestures: true,
        child: Container(
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

                    Column(
                      children: <Widget>[
                        Placeholder(
                          fallbackHeight: 80,
                          fallbackWidth: 80,
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  //the place of the card selected is saved to trip.title
                  widget.trip.title = _placesList[index].name;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewTripDateView(trip: widget.trip)),
                  );
                },
              ),
            ),
          ),
      ),
    );
  }
}

