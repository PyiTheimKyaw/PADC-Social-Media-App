import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/data/vos/user_vo.dart';
import 'package:social_media_app/network/social_data_agent.dart';
import 'package:firebase_auth/firebase_auth.dart';

///Database Path
const newsFeedPath = "newsfeed";
const fileUploadRef = "uploads";
const userRef = "users";

class RealTimeDatabaseDataAgentImpl extends SocialDataAgent {
  static final RealTimeDatabaseDataAgentImpl _singleton =
      RealTimeDatabaseDataAgentImpl._internal();

  factory RealTimeDatabaseDataAgentImpl() {
    return _singleton;
  }

  RealTimeDatabaseDataAgentImpl._internal();

  ///Database
  var databaseRef = FirebaseDatabase.instance.reference();

  ///Storage
  var firebaseStorage = FirebaseStorage.instance;

  ///Auth
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    return databaseRef.child(newsFeedPath).onValue.map((event) {
      // List<Object> eventObj=event.snapshot.value as List<Object>;
      // event.snapshot.value => Map<String,dynamic> => values => List<Map<String,dynamic>> => NewsFeedVO.fromJson() => List<NewsFeedVO>
      return event.snapshot.value.values.map<NewsFeedVO>((element) {
        // Map<dynamic,dynamic> elementMap=element as Map<dynamic,dynamic>;
        return NewsFeedVO.fromJson(Map<String, dynamic>.from(element));
      }).toList();
    });
  }

  @override
  Future<void> addNewPost(NewsFeedVO newPost) {
    return databaseRef
        .child(newsFeedPath)
        .child(newPost.id.toString())
        .set(newPost.toJson());
  }

  @override
  Future<void> deletePost(int postId) {
    return databaseRef.child(newsFeedPath).child(postId.toString()).remove();
  }

  @override
  Stream<NewsFeedVO> getNewsFeedById(int newsFeedId) {
    return databaseRef
        .child(newsFeedPath)
        .child(newsFeedId.toString())
        .once()
        .asStream()
        .map((snapShot) {
      return NewsFeedVO.fromJson(Map<String, dynamic>.from(snapShot.value));
    });
  }

  @override
  Future<String> uploadFileToFirebase(File image) {
    return firebaseStorage
        .ref(fileUploadRef)
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(image)
        .then((taskSnapshot) => taskSnapshot.ref.getDownloadURL());
  }

  @override
  Future registerNewUser(UserVO user) {
    return auth
        .createUserWithEmailAndPassword(
            email: user.email ?? "", password: user.password ?? "")
        .then(
            (credential) => credential.user?..updateDisplayName(user.userName))
        .then((newUser) {
      user.id = newUser?.uid ?? "";
      _addNewUser(user);
    });
  }

  Future<void> _addNewUser(UserVO user) {
    return databaseRef
        .child(userRef)
        .child(user.id.toString())
        .set(user.toJson());
  }

  @override
  Future login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  UserVO getLoggedInUser() {
    return UserVO(
        id: auth.currentUser?.uid,
        userName: auth.currentUser?.displayName,
        email: auth.currentUser?.email);
  }

  @override
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  @override
  Future logOut() {
    return auth.signOut();
  }
}
