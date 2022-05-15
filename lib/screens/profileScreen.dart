import 'package:flutter/material.dart';
import 'package:donate_kart/Services/authService.dart';
import 'package:donate_kart/Services/storageServices.dart';
import 'welcomeScreen.dart';
import 'package:donate_kart/screens/editProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = 'name';
  String _email = 'email';
  String profilePicture = null;

  void getName() async {
    String name = await AuthService.userName();
    setState(() {
      _name = name;
    });
  }

  void getEmail() async {
    String email = await AuthService.userEmail();
    setState(() {
      _email = email;
    });
  }

  void getProfilePic() async {
    String url = await StorageService().getProfile();
    setState(() {
      profilePicture = url;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
    getEmail();
    getProfilePic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: null,
        backgroundColor: Colors.teal.shade100,
        title: Text(
          'Donate Kart',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, EditProfileScreen.id);
            },
            icon: Icon(
              Icons.edit,
              color: Colors.teal,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 70.0,
              backgroundColor: Colors.teal.shade900,
              // backgroundImage: AssetImage('images/icon.jpg'),
              child: ClipOval(
                child: SizedBox(
                  width: 130.0,
                  height: 130.0,
                  child: Image(
                    image: (profilePicture == null)
                        ? AssetImage('images/icon.jpg')
                        : NetworkImage(profilePicture) as ImageProvider,
                  ),
                ),
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
              color: Colors.white70,
              margin: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 25.0,
              ),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.teal.shade900,
                ),
                title: Text(
                  _name,
                  style: TextStyle(
                    color: Colors.teal.shade900,
                    fontFamily: 'Source Sans Pro',
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.white70,
              margin: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 25.0,
              ),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.teal.shade900,
                ),
                title: Text(
                  _email,
                  style: TextStyle(
                    color: Colors.teal.shade900,
                    fontFamily: 'Source Sans Pro',
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                AuthService.logout();
                Navigator.pushNamed(context, WelcomeScreen.id);
              },
              child: Card(
                color: Colors.teal.shade100,
                margin: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 70.0,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.teal.shade900,
                  ),
                  title: Text(
                    'SIGN OUT',
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
