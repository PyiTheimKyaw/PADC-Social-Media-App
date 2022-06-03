
import 'package:firebase_analytics/firebase_analytics.dart';
const homeScreenReached="home_screen_reached";
const addNewPostScreenReached="add_new_post_screen_reached";
const addNewPostAction="add_new_post_action";
const editPostAction="edit_post_action";

///Parameters
const postId="post_id";
class FirebaseAnalyticTracker{
  static final FirebaseAnalyticTracker _singleton=FirebaseAnalyticTracker._internal();
  factory FirebaseAnalyticTracker(){
    return _singleton;
  }
  FirebaseAnalyticTracker._internal();

  ///Firebase analytic instance
  final FirebaseAnalytics analytic=FirebaseAnalytics.instance;



  Future logEvent(String name,Map<String,dynamic>? parameters){
    return analytic.logEvent(name: name,parameters: parameters);
  }



}