import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/network/social_data_agent.dart';

/// News Feed Collection
const newsFeedCollection = "newsfeed";

class CloudFireStoreDataAgentImpl extends SocialDataAgent {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<void> addNewPost(NewsFeedVO newPost) {
    // TODO: implement addNewPost
    throw UnimplementedError();
  }

  @override
  Future<void> deletePost(int postId) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
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
    // TODO: implement getNewsFeedById
    throw UnimplementedError();
  }
}
