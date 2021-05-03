import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_treasury/home_widget.dart';
import 'package:travel_treasury/views/first_view.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Travel Budget App",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FirstView(),
      routes: <String, WidgetBuilder>{
        '/signUp' : (BuildContext context) => Home(),
        '/home' : (BuildContext context) => Home(),
      },
    );
  }
}