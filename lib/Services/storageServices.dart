import 'package:firebase_storage/firebase_storage.dart';
import 'package:donate_kart/Services/authService.dart';
import 'dart:io';

class StorageService {
  FirebaseStorage storage =
      FirebaseStorage.instanceFor(bucket: "gs://donate-kart.appspot.com");

  var user = AuthService.getUser();

  Future<String> uploadFile(File file) async {
    var storageRef = storage.ref().child("users/profile/${user.uid}");
    var uploadTask = storageRef.putFile(file);
    var completedtask = await uploadTask.snapshot;
    String downloadUrl = await completedtask.ref.getDownloadURL();
    return downloadUrl;
  }

  // Stream uploadFile(File file) async {
  //   var storageRef = storage.ref().child("users/profile/${user.uid}");
  //   var uploadTask = storageRef.putFile(file);
  //   var completedtask = await uploadTask.snapshot;
  //   String downloadUrl = await completedtask.ref.getDownloadURL();
  //   return downloadUrl;
  // }

  Future<String> getProfile() async {
    var url = storage.ref().child("users/profile/${user.uid}");
    var profileUrl = url.getDownloadURL();
    return profileUrl;
  }

  Future<String> uploadPostMedia(File file) async {
    int count = await AuthService.userCount();
    var storageRef = storage.ref().child("users/media/${user.uid}${count}");
    var uploadTask = storageRef.putFile(file);
    var completedtask = await uploadTask.snapshot;
    String downloadUrl = await completedtask.ref.getDownloadURL();
    return downloadUrl;
  }

  // Stream uploadPostMedia(File file) async {
  //   int count = await AuthService.userCount();
  //   final var storageRef = storage.ref().child("users/media/${user.uid}${count}");
  // }
}
