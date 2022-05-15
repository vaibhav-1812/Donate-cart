import 'package:flutter/material.dart';
import 'package:donate_kart/screens/profileScreen.dart';
import 'package:donate_kart/screens/addPostScreen.dart';
import 'package:donate_kart/screens/homeScreen.dart';
import 'package:flutter/cupertino.dart';

class FeedScreen extends StatefulWidget {
  static const String id = 'feed_screen';
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  int _selectedtab = 0;

  List<Widget> _feedScreens = [
    HomeScreen(),
    AddPostScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _feedScreens.elementAt(_selectedtab),
      backgroundColor: Colors.teal,
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          setState(() {
            _selectedtab = index;
          });
        },
        backgroundColor: Colors.teal.shade100,
        activeColor: Colors.teal,
        currentIndex: _selectedtab,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
            Icons.home,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.add_box_rounded,
          )),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.person,
          )),
        ],
      ),
    );
  }
}
