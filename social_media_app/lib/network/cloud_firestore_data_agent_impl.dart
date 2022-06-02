import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/data/vos/user_vo.dart';
import 'package:social_media_app/network/social_data_agent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///News Feed Collection
const newsFeedCollection = "newsFeed";
const fileUploadRef = "uploads";
class CloudFirestoreDataAgentImpl extends SocialDataAgent {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  var firebaseStorage = FirebaseStorage.instance;

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
    // TODO: implement registerNewUser
    throw UnimplementedError();
  }

  @override
  Future login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  UserVO getLoggedInUser() {
    // TODO: implement getLoggedInUser
    throw UnimplementedError();
  }

  @override
  bool isLoggedIn() {
    // TODO: implement isLoggedIn
    throw UnimplementedError();
  }

  @override
  Future logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

}
