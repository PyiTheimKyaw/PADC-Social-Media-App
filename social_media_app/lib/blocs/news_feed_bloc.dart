import 'package:flutter/widgets.dart';
import 'package:social_media_app/analytic/firebase_analytic_tracker.dart';
import 'package:social_media_app/data/model/authentication_model.dart';
import 'package:social_media_app/data/model/authentication_model_impl.dart';
import 'package:social_media_app/data/model/social_model.dart';
import 'package:social_media_app/data/model/social_model_impl.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';

class NewsFeedBloc extends ChangeNotifier {
  List<NewsFeedVO>? newsFeed;

  bool isDispose = false;

  ///Models
  final SocialModel _mSocialModel = SocialModelImpl();
  final AuthenticationModel mAuthenticationModel = AuthenticationModelImpl();

  NewsFeedBloc() {
    _mSocialModel.getNewsFeed().listen((newsFeedList) {
      newsFeed = newsFeedList;
      if (!isDispose) {
        notifyListeners();
      }
    });
    _sendAnalyticData();
  }
  void _sendAnalyticData()async{
    await FirebaseAnalyticTracker().logEvent(homeScreenReached, null);
  }
  void onTapDelete(int postId) async{
   await _mSocialModel.deletePost(postId);
  }
  Future onTapLogOut(){
    return mAuthenticationModel.logOut();
  }
  @override
  void dispose() {
    super.dispose();
    isDispose = true;
  }
}
