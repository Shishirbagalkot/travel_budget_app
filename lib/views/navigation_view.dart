import 'package:flutter/material.dart';
import 'package:travel_treasury/models/trip.dart';
import 'package:travel_treasury/services/auth_service.dart';
import 'package:travel_treasury/views/home_view.dart';
import 'package:travel_treasury/views/new_trips/location_view.dart';
import 'package:travel_treasury/views/sign_up_view.dart';
import '../pages.dart';
import 'package:travel_treasury/widgets/provider_widget.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }

}
    
class _HomeState extends State<Home> {
  
  int _currentIndex = 0;
  //for the bottom navigation bar
  final List<Widget> _children = [ //list of widgets from page.dart file are imported and displayed
    HomeView(),
    ExplorePage(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {

    final newTrip = new Trip(null, null, null, null, null);

    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Budget App"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  //this will be passed onto the location_view page
                  builder: (context) => NewTripLocationView(trip: newTrip)
                )
              );
            }
          ),
          IconButton(
            icon: Icon(Icons.undo), 
            onPressed: () async {
              try {
                AuthService auth = Provider.of(context).auth;
                await auth.signOut();
                print("Signed Out!");
              } catch (e) {
                print(e);
              }
            }
          ),
          //iconbutton should be displayed depending if anonymous user
          IconButton(
            icon: Icon(Icons.account_circle), 
            onPressed: () {
              Navigator.of(context).pushNamed('/convertUser');      
            }
          ),
        ],
      ),

      body: _children[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(

        onTap: onTabTapped,

        currentIndex: _currentIndex, //tells app which tab is pressed
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.explore),
            label: "Explore"
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.history),
            label: "History"
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}


