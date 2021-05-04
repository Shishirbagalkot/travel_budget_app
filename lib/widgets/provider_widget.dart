import 'package:flutter/material.dart';
import 'package:travel_treasury/services/auth_service.dart';


//will alert all it's child widgets that the auth state has been changed
class Provider extends InheritedWidget{
  final AuthService auth;
  Provider({Key key, Widget child, this.auth}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget){
    return true;
  }

  //provider will let us know when something in the inherited widget changes
  static Provider of(BuildContext context) => (context.dependOnInheritedWidgetOfExactType<Provider>());
}