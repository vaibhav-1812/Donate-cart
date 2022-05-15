import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:donate_kart/Services/paymentService.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

// final _auth = FirebaseAuth.instance;
// late User loggedInUser;
final _fireStore = FirebaseFirestore.instance;

class _HomeScreenState extends State<HomeScreen> {
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getCurrentUser();
  // }

  // void getCurrentUser() {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user != null) {
  //       loggedInUser = user;
  //       print(loggedInUser.email);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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
          child: PostStream(),
        ),
      ),
    );
  }
}

class PostStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('posts').snapshots(),
      builder: (context, snapshot) {
        List<Posts> postWidgets = [];
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;
        for (var message in messages) {
          final postText = message.get('postText');
          final postSender = message.get('name');
          final postUrl = message.get('postUrl');
          final senderUrl = message.get('profileUrl');

          final post = Posts(
            name: postSender,
            text: postText,
            profileUrl: senderUrl,
            postUrl: postUrl,
          );
          postWidgets.add(post);
        }
        return ListView(
          padding: EdgeInsets.all(10.0),
          children: postWidgets,
        );
      },
    );
  }
}

class Posts extends StatelessWidget {
  Posts({this.name, this.text, this.profileUrl, this.postUrl});
  final name;
  final text;
  final profileUrl;
  final postUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.teal.shade600,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Column(
        children: [
          Row(
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
                      image: NetworkImage(profileUrl) as ImageProvider,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                name,
                style: TextStyle(
                  color: Colors.teal.shade100,
                  fontFamily: 'Source Sans Pro',
                  fontSize: 23.0,
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
          Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Column(
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                Image(image: NetworkImage(postUrl)),
                // Image.network(
                //   postUrl,
                //   errorBuilder: (BuildContext context, Object exception,
                //       StackTrace stackTrace) {
                //     return Icon(Icons.do_not_disturb);
                //   },
                // ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                color: Colors.teal.shade100,
                height: 45.0,
                padding: EdgeInsets.all(5.0),
                onPressed: () {
                  Navigator.pushNamed(context, PaymentService.id);
                },
                child: Text(
                  'DONATE',
                  style: TextStyle(
                    color: Colors.teal.shade900,
                    fontFamily: 'Source Sans Pro',
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
