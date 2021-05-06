import 'package:flutter/material.dart';
import 'package:travel_treasury/services/auth_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:travel_treasury/widgets/provider_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

final primaryColor = const Color(0xFF75A2EA);

//to determine if signed in or not
enum AuthFormType{signIn, signUp, reset, anonymous, convert}

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
  String _email, _password, _name, _verifypassword, _warning;

  //to return to sign in page from sign up page
  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else if(state == "home") {
      Navigator.of(context).pop();
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  //if form is validated, the form is submitted
  bool validate() {
    //if form is not saved then the db cannot be updated
    final form = formKey.currentState;
    if(form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  //function for build buttons
  //to main state change consistently throughout the app
  void submit() async{
    
    if(validate()) {  
      try {
        final auth = Provider.of(context).auth;

        switch (authFormType) {
          case AuthFormType.signIn:
            await auth.signInWithEmailAndPassword(_email, _password);
            Navigator.of(context).pushReplacementNamed("/home");
            break;
          //to send password reset link to mail
          case AuthFormType.reset:
            await auth.sendPasswordResetEmail(_email);
            _warning = "Password reset link has been sent to $_email";
            setState(() {
              authFormType = AuthFormType.signIn;
            });
            break;
          case AuthFormType.signUp:
            await auth.createUserWithEmailAndPassword(_email, _password, _name);
            Navigator.of(context).pushReplacementNamed("/home");
            break;
          case AuthFormType.anonymous:
            await auth.signInAnonymously();
            //once user is created, naigate to homepage
            Navigator.of(context).pushReplacementNamed("/home");
            break;
          case AuthFormType.convert:
            break;
          default:
        }
      } catch (e) {
          print(e);
          setState(() {
            _warning = e.message; //the error message sent from firebase
          });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    if (authFormType == AuthFormType.anonymous) {
      submit();
      return Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitFadingCircle(
              color: Colors.white,
            ),
            Text("Loading", style: TextStyle(color: Colors.white),),
          ],
        ),
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: primaryColor,
          height: _height,
          width: _width,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(height: _height * 0.025),
                showAlert(),
                SizedBox(height: _height * 0.025),
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
  }

  ///////////to display error sent by firebase ///////////
  
  Widget showAlert () {
    if(_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(child: AutoSizeText(_warning, maxLines: 3)),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close), 
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                }
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox(height: 0);
  }

  /////////// for displaying header text in each page ///////////
  
  AutoSizeText buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.signIn) {
      _headerText = "Sign In";
    } else if(authFormType == AuthFormType.reset) {
      _headerText = "Reset Password";
    } else {
      _headerText = "Create New Account";
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30,
        color: Colors.white,
      ),
    );
  }

  //////////form widgets///////////

  List<Widget> buildInputs() {
    List<Widget> textFields = [];
    //for resetting password
    if(authFormType == AuthFormType.reset) {
      textFields.add(
        TextFormField(
          validator: EmailValidator.validate, //defined in auth_service
          style: TextStyle(fontSize: 20.0),
          decoration: buildSignUpInputDecoration("Email"),
          onSaved: (value) => _email = value,
        )
      );
      textFields.add(SizedBox(height: 10));
      return textFields; //want to return only this form field instead of all 
    }
    //if in signup state add name
    if ([AuthFormType.signUp , AuthFormType.convert].contains(authFormType)) {
      textFields.add(
        TextFormField(
          validator: NameValidator.validate, //defined in auth_service
          style: TextStyle(fontSize: 20.0),
          decoration: buildSignUpInputDecoration("Name"),
          onSaved: (value) => _name = value,
        )
      );
      textFields.add(SizedBox(height: 10));
    }
    //add email and password
    textFields.add(
      TextFormField(
        validator: EmailValidator.validate, //defined in auth_service
        style: TextStyle(fontSize: 20.0),
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (value) => _email = value,
      )
    );
    textFields.add(SizedBox(height: 10));
    textFields.add(
      TextFormField(
        validator: (String value) {
          _verifypassword = value;
          if(value.isEmpty) {
            return "Password can't be empty";
          }
          if(value.length < 6) {
            return "Password should be a min of 6 characters";
          }
          return null;
        }, //defined in auth_service
        style: TextStyle(fontSize: 20.0),
        decoration: buildSignUpInputDecoration("Password"),
        obscureText: true,
        onSaved: (value) => _password = value,
      )
    );
    textFields.add(SizedBox(height: 10));
    //appears only in signup state
    if (authFormType == AuthFormType.signUp) {
      textFields.add(
        TextFormField(
          validator: (value) {
            if(value.isEmpty) {
              return "Password cannot be empty";
            }
            if(value != _verifypassword){
              return "Passwords don't match";
            }
            return null;
          },
          style: TextStyle(fontSize: 20.0),
          decoration: buildSignUpInputDecoration("Re-enter password"),
          obscureText: true,
          onSaved: (value) => _verifypassword = value,
        )
      );
    }
    textFields.add(SizedBox(height: 15));
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

  ///////////button widgets///////////

  List<Widget> buildButtons () {
    String _switchButtonText, _newFormState, _submitButtonText;
    bool _showForgotPassword = false;
    bool _showSocial = true;

    if (authFormType == AuthFormType.signIn) {
      _switchButtonText = "Create new account";
      _newFormState = "signUp";
      _submitButtonText = "Sign In";
      _showForgotPassword = true;
    } else if(authFormType == AuthFormType.reset){
      _switchButtonText = "Return to Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Submit";
      _showSocial = false;
    } else if(authFormType == AuthFormType.convert) {
      _switchButtonText = "Cancel";
      _newFormState = "home";
      _submitButtonText = "Sign Up";
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
      showForgotPassword(_showForgotPassword),
      TextButton(
        child: Text(_switchButtonText, style: TextStyle(color: Colors.white),),
        onPressed: () {
          switchFormState(_newFormState);
        },
      ),
      buildSocialIcons(_showSocial),
    ];
  }


  //for resetting password
  Widget showForgotPassword(bool visible) {
    return Visibility(
      child: TextButton(
        onPressed: () {
          setState(() {
            authFormType = AuthFormType.reset;
          });
        }, 
        child: Text("Forgot Password?", style: TextStyle(color: Colors.white),)
      ),
      visible: visible,
    );
  }

  //social account signin
  Widget buildSocialIcons(bool visible) {

    final _auth = Provider.of(context).auth;

    return Visibility(
      child: Column(
        children: <Widget>[
          Divider(color: Colors.white),
          SizedBox(height: 10.0),
          GoogleSignInButton(
            onPressed: () async{
              try {
                await _auth.signInWithGoogle();
                Navigator.of(context).pushReplacementNamed('/home');
              } catch (e) {
                setState(() {
                  _warning = e.message;
                });
              }
            }
          ),
        ],
      ),
      visible: visible,
    );
  } 
}