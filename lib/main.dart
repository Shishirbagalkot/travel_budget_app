import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_treasury/home_widget.dart';
import 'package:travel_treasury/services/auth_service.dart';
import 'package:travel_treasury/views/first_view.dart';
import 'package:travel_treasury/views/sign_up_view.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Travel Budget App",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/signUp' : (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp),
          '/signIn' : (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn),
          '/home' : (BuildContext context) => HomeController(),
        },
      ),
    );
  }
}


//will control whether home / sign in page is to be displayed
class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*used to listen to stream of state change and show first view or home view accordingly*/
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Home() : FirstView(); 
        }
        return CircularProgressIndicator();
      }
    );
  }
}


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