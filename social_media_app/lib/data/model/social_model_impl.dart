import 'dart:io';

import 'package:social_media_app/data/model/social_model.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/network/cloud_firestore_data_agent_impl.dart';
import 'package:social_media_app/network/real_time_database_data_agent_impl.dart';
import 'package:social_media_app/network/social_data_agent.dart';

class SocialModelImpl extends SocialModel {
  static final SocialModelImpl _singleton = SocialModelImpl._internaL();

  factory SocialModelImpl() {
    return _singleton;
  }

  SocialModelImpl._internaL();

  SocialDataAgent mDataAgent = CloudFirestoreDataAgentImpl();

  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    return mDataAgent.getNewsFeed();
  }

  @override
  Future<void> addNewPost(String description, File? image) {
    if (image != null) {
      return mDataAgent
          .uploadFileToFirebase(image)
          .then((downloadUrl) => craftNewsFeedVO(description, downloadUrl))
          .then((newPost) => mDataAgent.addNewPost(newPost));
    } else {
      return craftNewsFeedVO(description, "")
          .then((newPost) => mDataAgent.addNewPost(newPost));
    }
  }

  Future<NewsFeedVO> craftNewsFeedVO(String description, String imageUrl) {
    var currentMilliseconds = DateTime.now().millisecondsSinceEpoch;
    var newPost = NewsFeedVO(
        currentMilliseconds,
        description,
        imageUrl,
        "https://sm.askmen.com/t/askmen_in/article/f/facebook-p/facebook-profile-picture-affects-chances-of-gettin_fr3n.1200.jpg",
        "Pyi Theim Kyaw");
    return Future.value(newPost);
  }

  Future<NewsFeedVO> editNewsFeedVO(NewsFeedVO newVO, String imageUrl) {
    NewsFeedVO newPost = newVO;
    newPost.postImage=imageUrl;
    return Future.value(newPost);
  }

  @override
  Future<void> deletePost(int postId) {
    return mDataAgent.deletePost(postId);
  }

  @override
  Stream<NewsFeedVO> getNewsFeedById(int newsFeedId) {
    return mDataAgent.getNewsFeedById(newsFeedId);
  }

  @override
  Future<void> editPost(NewsFeedVO newsFeed, File? image) {
    if (image != null) {
      return mDataAgent
          .uploadFileToFirebase(image)
          .then((downloadUrl) => editNewsFeedVO(newsFeed, downloadUrl))
          .then((editPost) => mDataAgent.addNewPost(editPost));
    } else {
      return mDataAgent.addNewPost(newsFeed);
    }
  }
}
