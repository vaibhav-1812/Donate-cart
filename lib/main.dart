import 'package:donate_kart/screens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'screens/welcomeScreen.dart';
import 'screens/loginScreen.dart';
import 'screens/registrationScreen.dart';
import 'screens/feedScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:donate_kart/screens/editProfileScreen.dart';
import 'package:donate_kart/Services/paymentService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DonateKart());
}

class DonateKart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        FeedScreen.id: (context) => FeedScreen(),
        EditProfileScreen.id: (context) => EditProfileScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        PaymentService.id: (context) => PaymentService(),
      },
    );
  }
}
