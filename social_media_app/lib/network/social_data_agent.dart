import 'dart:io';

import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/data/vos/user_vo.dart';

abstract class SocialDataAgent{
  ///News Feed
  Stream<List<NewsFeedVO>> getNewsFeed();
  Future<void> addNewPost(NewsFeedVO newsFeed);
  Future<void> deletePost(int postId);
  Stream<NewsFeedVO> getNewsFeedById(int newsFeedId);
  Future<String> uploadFileToFirebase(File image);


  ///Authentication
  Future registerNewUser(UserVO user);
}