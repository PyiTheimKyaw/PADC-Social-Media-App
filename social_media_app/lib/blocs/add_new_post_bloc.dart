import 'package:flutter/material.dart';
import 'package:social_media_app/data/model/social_model.dart';
import 'package:social_media_app/data/model/social_model_impl.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';

class AddNewPostBloc extends ChangeNotifier {
  String newPostDescription = "";
  bool isAddNewPostError = false;
  bool isDisposed = false;
  bool isInEditMode = false;
  String? userName;
  String? profilePicture;

  ///States
  NewsFeedVO? mNewsFeed;

  ///Model
  final SocialModel _model = SocialModelImpl();

  AddNewPostBloc({int? newsFeedId}) {
    if (newsFeedId != null) {
      isInEditMode = true;
      _prePopulateDataForEditMode(newsFeedId);
    } else {
      _prePopulateDataForAddPostMode();
    }
  }

  void onNewPostTextChanged(String newPostDescription) {
    this.newPostDescription = newPostDescription;
    notifyListeners();
  }

  Future onTapAddNewPost() {
    if (newPostDescription.isEmpty) {
      isAddNewPostError = true;
      _notifySafely();
      return Future.error("Error");
    } else {
      isAddNewPostError = false;
      _notifySafely();
      if (isInEditMode) {
        return _editNewsFeedPost();
      } else {
        return _createNewNewsFeedPost();
      }
    }
  }

  Future<dynamic> _editNewsFeedPost() {
    mNewsFeed?.description = newPostDescription;
    if (mNewsFeed != null) {
      return _model.editPost(mNewsFeed!);
    } else {
      return Future.error("Error");
    }
  }

  Future<void> _createNewNewsFeedPost() =>
      _model.addNewPost(newPostDescription);

  void _prePopulateDataForEditMode(int newsFeedId) {
    _model.getNewsFeedById(newsFeedId).listen((event) {
      userName = event.userName ?? "";
      profilePicture = event.profilePicture ?? "";
      newPostDescription = event.description ?? "";
      mNewsFeed = event;
      _notifySafely();
    }).onError((error) {
      print("Get newsFeed id error => ${error.toString()}");
    });
  }

  void _prePopulateDataForAddPostMode() {
    userName = "Pyi Theim Kyaw";
    profilePicture =
        "https://scontent-sin6-4.xx.fbcdn.net/v/t1.6435-9/91521846_730904297681781_7767512976893935616_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=OwDQxt9BVzsAX_3l0Cx&_nc_ht=scontent-sin6-4.xx&oh=00_AT8wDx_uQmzwhDyRStvBFq0TygYI-oFmqDOyMb9e_MPlCg&oe=62BC328A";
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
