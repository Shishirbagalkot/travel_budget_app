import 'package:flutter/material.dart';
import 'package:travel_treasury/services/auth_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:travel_treasury/widgets/provider_widget.dart';


// TODO move this to tone location
final primaryColor = const Color(0xFF75A2EA);

//to determine if signed in or not
enum AuthFormType{signIn, signUp}

class SignUpView extends StatefulWidget {

  final AuthFormType authFormType;

  SignUpView({Key key, @required this.authFormType}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {

  AuthFormType authFormType;
  _SignUpViewState({this.authFormType});

  final formKey = GlobalKey<FormState>();
  String _email, _password, _name;

  //to return to sign in page from sign up page
  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  //function for build buttons
  //to main state change consistently throughout the app
  void submit() async{

    //if form is not saved then the db cannot be updated
    final form = formKey.currentState;
    form.save();

    try {
      final auth = Provider.of(context).auth;
      if(authFormType == AuthFormType.signIn) {
        String uid = await auth.signInWithEmailAndPassword(_email, _password);
        print("Signed in with $uid");
        Navigator.of(context).pushReplacementNamed("/home");
      } else {
        String uid = await auth.createUserWithEmailAndPassword(_email, _password, _name);
        print("Signed up with new ID $uid");
        Navigator.of(context).pushReplacementNamed("/home");
      }
    } catch (e) {
          print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: primaryColor,
        height: _height,
        width: _width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: _height * 0.05),
              buildHeaderText(),
              SizedBox(height: _height * 0.05),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: buildInputs() + buildButtons(),
                  )
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  AutoSizeText buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.signUp) {
      _headerText = "Create New Account";
    } else {
      _headerText = "Sign In";
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 35,
        color: Colors.white,
      ),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    //if in signup state add name
    if (authFormType == AuthFormType.signUp) {
      textFields.add(
      TextFormField(
        style: TextStyle(fontSize: 20.0),
        decoration: buildSignUpInputDecoration("Name"),
        onSaved: (value) => _name = value,
      )
    );
    textFields.add(SizedBox(height: 20));
  }

    //add email and password
    textFields.add(
      TextFormField(
        style: TextStyle(fontSize: 20.0),
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (value) => _email = value,
      )
    );
    textFields.add(SizedBox(height: 20));
    textFields.add(
      TextFormField(
        style: TextStyle(fontSize: 20.0),
        decoration: buildSignUpInputDecoration("Password"),
        obscureText: true,
        onSaved: (value) => _password = value,
      )
    );
    textFields.add(SizedBox(height: 20));

    return textFields;
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 0.0)),
        contentPadding: const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
      );
  }

  List<Widget> buildButtons () {
    String _switchButtonText, _newFormState, _submitButtonText;

    if (authFormType == AuthFormType.signIn) {
      _switchButtonText = "Create new account";
      _newFormState = "signUp";
      _submitButtonText = "Sign In";
    } else {
      _switchButtonText = "Have an account? Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Sign Up";
    }

    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        // ignore: deprecated_member_use
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: Colors.white,
          textColor: primaryColor,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(_submitButtonText,style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300)),
          ),
          onPressed: submit,
        ),
      ),
      TextButton(
        child: Text(_switchButtonText, style: TextStyle(color: Colors.white),),
        onPressed: () {
          switchFormState(_newFormState);
        }, 
      )
    ];
  
  }
}