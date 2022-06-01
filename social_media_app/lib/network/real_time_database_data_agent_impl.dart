import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/network/social_data_agent.dart';

///Database Path
const newsFeedPath = "newsfeed";

class RealTimeDatabaseDataAgentImpl extends SocialDataAgent {
  static final RealTimeDatabaseDataAgentImpl _singleton =
      RealTimeDatabaseDataAgentImpl._internal();

  factory RealTimeDatabaseDataAgentImpl() {
    return _singleton;
  }

  RealTimeDatabaseDataAgentImpl._internal();

  ///Database
  var databaseRef = FirebaseDatabase.instance.reference();

  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    return databaseRef.child(newsFeedPath).onValue.map((event) {
      // List<Object> eventObj=event.snapshot.value as List<Object>;
      return event.snapshot.value.values.map<NewsFeedVO>((element) {
        // Map<dynamic,dynamic> elementMap=element as Map<dynamic,dynamic>;
        return NewsFeedVO.fromJson(Map<String, dynamic>.from(element));
      }).toList();
    });
  }
}
