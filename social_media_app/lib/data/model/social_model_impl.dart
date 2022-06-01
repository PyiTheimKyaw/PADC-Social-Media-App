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
  Future<void> addNewPost(String description) {
    var currentMiliseconds = DateTime.now().millisecondsSinceEpoch;
    var newPost = NewsFeedVO(
        currentMiliseconds,
        description,
        "",
        "https://scontent-sin6-4.xx.fbcdn.net/v/t1.6435-9/91521846_730904297681781_7767512976893935616_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=OwDQxt9BVzsAX_3l0Cx&_nc_ht=scontent-sin6-4.xx&oh=00_AT8wDx_uQmzwhDyRStvBFq0TygYI-oFmqDOyMb9e_MPlCg&oe=62BC328A",
        "Pyi Theim Kyaw");
    return mDataAgent.addNewPost(newPost);
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
  Future<void> editPost(NewsFeedVO newsFeed) {
    return mDataAgent.addNewPost(newsFeed);
  }

}
