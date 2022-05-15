import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'feedScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:donate_kart/Services/authService.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Colors.teal,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'icon',
                child: CircleAvatar(
                  radius: (!isKeyboard) ? 50.0 : 0.0,
                  backgroundImage: AssetImage('images/icon.jpg'),
                ),
              ),
              Text(
                'Donate Kart',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                  color: Colors.white,
                ),
              ),
              Text(
                'MAKE EARTH A BETTER PLACE',
                style: TextStyle(
                  fontFamily: 'Source Sans Pro',
                  color: Colors.teal.shade100,
                  fontSize: 15.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 250.0,
                child: Divider(
                  color: Colors.teal.shade100,
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 25.0,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.teal.shade900,
                  ),
                  title: TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 18.0,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 25.0,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.password,
                    color: Colors.teal.shade900,
                  ),
                  title: TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    textAlign: TextAlign.center,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 18.0,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                    ),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  // try {
                  //   final user = await _auth.signInWithEmailAndPassword(
                  //       email: email, password: password);
                  //   if (user != null) {
                  //     Navigator.pushNamed(context, FeedScreen.id);
                  //   }
                  //   setState(() {
                  //     showSpinner = false;
                  //   });
                  // }
                  try {
                    bool user = await AuthService.login(email, password);
                    if (user) {
                      Navigator.pushNamed(context, FeedScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                child: Card(
                  color: Colors.teal.shade100,
                  margin: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 70.0,
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.login,
                      color: Colors.teal.shade900,
                    ),
                    title: Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
