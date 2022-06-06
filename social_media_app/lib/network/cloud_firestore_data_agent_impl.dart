import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/data/vos/user_vo.dart';
import 'package:social_media_app/network/social_data_agent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///News Feed Collection
const newsFeedCollection = "newsFeed";
const fileUploadRef = "uploads";
const userCollectionsPath = "users";

class CloudFirestoreDataAgentImpl extends SocialDataAgent {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  var firebaseStorage = FirebaseStorage.instance;

  ///Auth
  FirebaseAuth auth = FirebaseAuth.instance;

  ///Database
  var databaseRef = FirebaseDatabase.instance.reference();

  @override
  Future<void> addNewPost(NewsFeedVO newsFeed) {
    return _fireStore
        .collection(newsFeedCollection)
        .doc(newsFeed.id.toString())
        .set(newsFeed.toJson());
  }

  @override
  Future<void> deletePost(int postId) {
    return _fireStore
        .collection(newsFeedCollection)
        .doc(postId.toString())
        .delete();
  }

  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    /// snapShot() => querySnapShot => querySnapShot.docs =>  List<QueryDocumentSnapshot> => data() => List<Map<String,dynamic>> => NewsFeedVo.fromJson() => List<NewsFeedVO>
    return _fireStore
        .collection(newsFeedCollection)
        .snapshots()
        .map((querySnapShot) {
      return querySnapShot.docs.map<NewsFeedVO>((document) {
        return NewsFeedVO.fromJson(document.data());
      }).toList();
    });
  }

  @override
  Stream<NewsFeedVO> getNewsFeedById(int newsFeedId) {
    return _fireStore
        .collection(newsFeedCollection)
        .doc(newsFeedId.toString())
        .get()
        .asStream()
        .where((documentSnapShot) => documentSnapShot.data() != null)
        .map((documentSnapShot) =>
            NewsFeedVO.fromJson(documentSnapShot.data()!));
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
        .then((credential) {
      return credential.user
        ?..updateDisplayName(user.userName)
        ..updatePhotoURL(user.profilePicture);
    }).then((newUser) {
      user.id = newUser?.uid ?? "";
      _addNewUser(user);
    });
  }

  Future<void> _addNewUser(UserVO user) {
    return _fireStore
        .collection(userCollectionsPath)
        .doc(user.id.toString())
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
      email: auth.currentUser?.email,
      profilePicture: auth.currentUser?.photoURL,
    );
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
