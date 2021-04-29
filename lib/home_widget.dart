import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
      }
    }
    
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Budget App"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, //tells app which tab is pressed
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
}

