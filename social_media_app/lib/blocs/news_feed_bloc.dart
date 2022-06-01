import 'package:flutter/widgets.dart';
import 'package:social_media_app/data/model/social_model.dart';
import 'package:social_media_app/data/model/social_model_impl.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';

class NewsFeedBloc extends ChangeNotifier {
  List<NewsFeedVO>? newsFeed;
  final SocialModel _mSocialModel = SocialModelImpl();
  bool isDispose = false;

  NewsFeedBloc() {
    _mSocialModel.getNewsFeed().listen((newsFeedList) {
      newsFeed = newsFeedList;
      if (!isDispose) {
        notifyListeners();
      }
    });
  }

  void onTapDelete(int postId) async{
   await _mSocialModel.deletePost(postId);
  }

  @override
  void dispose() {
    super.dispose();
    isDispose = true;
  }
}
