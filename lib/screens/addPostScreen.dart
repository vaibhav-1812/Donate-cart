import 'package:flutter/material.dart';
import 'package:donate_kart/Services/authService.dart';
import 'package:donate_kart/Services/storageServices.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'feedScreen.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  String _name = 'name';
  String _profilePicture = null;
  String _email = 'email';
  String _postText = null;
  String _postUrl = null;
  File _file;

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
      _profilePicture = url;
    });
  }

  // void wait() async {
  //   await AuthService.uploadPost(
  //       _name, _email, _postText, _postUrl, _profilePicture);
  // }

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
      appBar: AppBar(
        leading: null,
        centerTitle: true,
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
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade600,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 10.0,
                            ),
                            CircleAvatar(
                              radius: 25.0,
                              backgroundColor: Colors.teal.shade900,
                              child: ClipOval(
                                child: SizedBox(
                                  width: 130.0,
                                  height: 130.0,
                                  child: Image(
                                    image: (_profilePicture == null)
                                        ? AssetImage('images/icon.jpg')
                                        : NetworkImage(_profilePicture)
                                            as ImageProvider,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Text(
                              _name,
                              style: TextStyle(
                                color: Colors.teal.shade100,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 23.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                        width: 250.0,
                        child: Divider(
                          color: Colors.teal.shade100,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            onChanged: (value) {
                              _postText = value;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter your cause',
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
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                XFile image = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                // File file = File(image.path);
                                _file = File(image.path);
                                print(image.path);
                                // String picture = await StorageService()
                                //     .uploadPostMedia(file);
                                // print(picture);
                                // setState(() async {
                                //   print(_postUrl);
                                //   _postUrl = await picture;
                                // });
                              },
                              icon: Icon(
                                Icons.add_a_photo,
                                color: Colors.teal.shade900,
                              ),
                            ),
                            SizedBox(
                              width: 170.0,
                            ),
                            FlatButton(
                              color: Colors.teal.shade100,
                              height: 45.0,
                              padding: EdgeInsets.all(5.0),
                              onPressed: () {},
                              child: Text(
                                'DONATE',
                                style: TextStyle(
                                  color: Colors.teal.shade900,
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton(
                        color: Colors.teal.shade100,
                        height: 45.0,
                        padding: EdgeInsets.all(5.0),
                        onPressed: () {
                          AuthService.updateCount();
                          print(_postUrl);
                          AuthService.uploadPost(
                              _name, _email, _postText, _file, _profilePicture);
                          // await wait();
                          Navigator.popAndPushNamed(context, FeedScreen.id);
                        },
                        child: Text(
                          'POST',
                          style: TextStyle(
                            color: Colors.teal.shade900,
                            fontFamily: 'Source Sans Pro',
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
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
