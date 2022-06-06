import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_installations/firebase_installations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_app/data/model/authentication_model.dart';
import 'package:social_media_app/data/model/authentication_model_impl.dart';
import 'package:social_media_app/fcm/fcm_service.dart';
import 'package:social_media_app/fcm/fcm_service.dart';
import 'package:social_media_app/pages/login_page.dart';
import 'package:social_media_app/pages/news_feed_page.dart';
import 'package:social_media_app/pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FCMService().listenForMessages();
  var firebaseInstallationId=await FirebaseInstallations.id ?? "Unknown installation id";
  debugPrint("Firebase installation id => $firebaseInstallationId");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ///Auth model
    final AuthenticationModel mModel = AuthenticationModelImpl();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.ubuntu().fontFamily),
      home: (mModel.isLoggedIn()) ? const NewsFeedPage() : const LoginPage(),
    );
  }
}
