import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_treasury/home_widget.dart';
import 'package:travel_treasury/services/auth_service.dart';
import 'package:travel_treasury/views/first_view.dart';
import 'package:travel_treasury/views/sign_up_view.dart';
import 'package:travel_treasury/widgets/provider_widget.dart';



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
          '/anonymousSignIn' : (BuildContext context) => SignUpView(authFormType: AuthFormType.anonymous),
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


