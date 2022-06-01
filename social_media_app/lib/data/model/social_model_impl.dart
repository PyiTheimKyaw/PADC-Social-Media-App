import 'package:social_media_app/data/model/social_model.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/network/real_time_database_data_agent_impl.dart';
import 'package:social_media_app/network/social_data_agent.dart';

class SocialModelImpl extends SocialModel{
  static final SocialModelImpl _singleton=SocialModelImpl._internaL();

  factory SocialModelImpl(){
    return _singleton;
  }

  SocialModelImpl._internaL();

  SocialDataAgent mDataAgent=RealTimeDatabaseDataAgentImpl();
  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    return mDataAgent.getNewsFeed();
  }

}