import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donate_kart/Services/storageServices.dart';
import 'dart:io';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _fireStore = FirebaseFirestore.instance;
  static var count = 1;

  static Future<bool> signUp(String name, String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User signedInUser = authResult.user;

      if (signedInUser != null) {
        _fireStore.collection('users').doc(signedInUser.uid).set({
          'name': name,
          'email': email,
          'profilePicture': '',
          'count': count,
        });
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static void logout() {
    try {
      _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  static Future<DocumentSnapshot> userData() async {
    try {
      User user = await _auth.currentUser;
      var ref = _fireStore.collection('users').doc(user.uid).get();
      return ref;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<String> userName() async {
    DocumentSnapshot dox = await userData();
    String name = dox?.get('name');
    return name;
  }

  static Future<String> userEmail() async {
    DocumentSnapshot dox = await userData();
    String name = dox?.get('email');
    return name;
  }

  static Future<int> userCount() async {
    DocumentSnapshot dox = await userData();
    count = dox?.get('count');
    return count;
  }

  static void updateName(String name) async {
    final user = await _auth.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'name': name});
    }
  }

  static void updateCount() async {
    final user = await _auth.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'count': count + 1});
    }
  }

  static User getUser() {
    final user = _auth.currentUser;
    return user;
  }

  static Future<void> uploadPost(String name, String email, String postText,
      File file, String profileUrl) async {
    String picture = await StorageService().uploadPostMedia(file);
    _fireStore.collection('posts').add({
      'name': name,
      'email': email,
      'postText': postText,
      // 'postUrl': postUrl,
      'postUrl': picture,
      'profileUrl': profileUrl,
    });
  }
}
