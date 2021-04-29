import 'package:flutter/material.dart';
import 'pages.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
      }
    }
    
class _HomeState extends State<Home> {
  
  int _currentIndex = 0;
  final List<Widget> _children = [ //list of widgets from page.dart file are imported and displayed
    HomePage(),
    ExplorePage(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Budget App"),
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

