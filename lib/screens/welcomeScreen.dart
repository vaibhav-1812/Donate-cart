import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'registrationScreen.dart';
import 'loginScreen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'icon',
              child: CircleAvatar(
                radius: animation.value * 50,
                backgroundImage: AssetImage('images/icon.jpg'),
              ),
            ),
            Text(
              'Donate Kart',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontWeight: FontWeight.bold,
                fontSize: animation.value * 40,
                color: Colors.white,
              ),
            ),
            Text(
              'MAKE EARTH A BETTER PLACE',
              style: TextStyle(
                fontFamily: 'Source Sans Pro',
                color: Colors.teal.shade100,
                fontSize: animation.value * 15,
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
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
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
            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              child: Card(
                color: Colors.teal.shade100,
                margin: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 70.0,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.app_registration,
                    color: Colors.teal.shade900,
                  ),
                  title: Text(
                    'REGISTER',
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
    );
  }
}
