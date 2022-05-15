import 'dart:ui';
import 'dart:io';
import 'package:donate_kart/screens/feedScreen.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:donate_kart/Services/authService.dart';
import 'package:donate_kart/Services/storageServices.dart';

class EditProfileScreen extends StatefulWidget {
  static const String id = 'editprofile_screen';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String _name = 'name';
  String profilePicture = null;

  // void getProfilePicture

  void getName() async {
    String name = await AuthService.userName();
    setState(() {
      _name = name;
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
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              // textBaseline: TextBaseline.alphabetic,
              children: [
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
                IconButton(
                  onPressed: () async {
                    XFile image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    File file = File(image.path);
                    print(image.path);
                    String picture = await StorageService().uploadFile(file);
                    print(picture);
                    setState(() {
                      profilePicture = picture;
                    });
                  },
                  icon: Icon(
                    Icons.add_a_photo,
                    color: Colors.teal.shade900,
                  ),
                ),
              ],
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
                title: TextFormField(
                  controller: TextEditingController()..text = _name,
                  onChanged: (value) {
                    _name = value;
                  },
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.teal.shade900,
                    fontFamily: 'Source Sans Pro',
                    fontSize: 18.0,
                  ),
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.edit,
                      color: Colors.teal.shade900,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
              width: 250.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  color: Colors.teal.shade100,
                  height: 55.0,
                  padding: EdgeInsets.all(10.0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'CANCEL',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                FlatButton(
                  color: Colors.teal.shade100,
                  height: 55.0,
                  padding: EdgeInsets.all(10.0),
                  onPressed: () {
                    AuthService.updateName(_name);
                    Navigator.popAndPushNamed(context, FeedScreen.id);
                  },
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
