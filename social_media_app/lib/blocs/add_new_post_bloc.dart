import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_app/data/model/authentication_model.dart';
import 'package:social_media_app/data/model/authentication_model_impl.dart';
import 'package:social_media_app/data/model/social_model.dart';
import 'package:social_media_app/data/model/social_model_impl.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';
import 'package:social_media_app/data/vos/user_vo.dart';

import '../analytic/firebase_analytic_tracker.dart';

class AddNewPostBloc extends ChangeNotifier {
  ///State
  bool isAddNewPostError = false;
  bool isDisposed = false;
  bool isLoading = false;

  ///Imge
  File? chosenImageFile;

  ///For Edit mode
  NewsFeedVO? mNewsFeed;
  bool isInEditMode = false;
  String? userName;
  String profilePicture="";
  String newPostDescription = "";
  String image = "";
  UserVO? _loggedInUser;

  ///Model
  final SocialModel _model = SocialModelImpl();
  final AuthenticationModel _authenticationModel = AuthenticationModelImpl();

  AddNewPostBloc({int? newsFeedId}) {
    _loggedInUser = _authenticationModel.getLoggedInUser();
    print("Profile pic => ${_loggedInUser?.profilePicture}");
    if (newsFeedId != null) {
      isInEditMode = true;
      _prePopulateDataForEditMode(newsFeedId);
    } else {
      _prePopulateDataForAddPostMode();
    }
    _sendAnalyticData(addNewPostScreenReached, null);
  }
  void _sendAnalyticData(String name,Map<String,dynamic>? parameters)async{
    await FirebaseAnalyticTracker().logEvent(name, parameters);
  }
  void onImageChosen(File imageFile) {
    chosenImageFile = imageFile;
    _notifySafely();
  }

  void onTapDeleteImage() {
    chosenImageFile = null;
    image = "";
    _notifySafely();
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
      isLoading = true;
      isAddNewPostError = false;
      _notifySafely();
      if (isInEditMode) {
        return _editNewsFeedPost().then((value) {
          isLoading = false;
          _notifySafely();
          _sendAnalyticData(editPostAction,{postId: mNewsFeed?.id.toString() ?? ""});
        });
      } else {
        return _createNewNewsFeedPost().then((value) {
          isLoading = false;
          _notifySafely();
          _sendAnalyticData(addNewPostAction, null);
        });
      }
    }
  }

  Future<dynamic> _editNewsFeedPost() {
    mNewsFeed?.description = newPostDescription;
    mNewsFeed?.postImage=image;
    if (mNewsFeed != null) {
      return _model.editPost(mNewsFeed!, chosenImageFile);
    } else {
      return Future.error("Error");
    }
  }

  Future<void> _createNewNewsFeedPost() =>
      _model.addNewPost(newPostDescription, chosenImageFile);

  void _prePopulateDataForEditMode(int newsFeedId) {
    _model.getNewsFeedById(newsFeedId).listen((event) {
      userName = event.userName ?? "";
      profilePicture = event.profilePicture ?? "";
      newPostDescription = event.description ?? "";
      image = event.postImage ?? "";
      mNewsFeed = event;
      _notifySafely();
    }).onError((error) {
      print("Get newsFeed id error => ${error.toString()}");
    });
  }

  void _prePopulateDataForAddPostMode() {
    userName = _loggedInUser?.userName ?? "";
    profilePicture = _loggedInUser?.profilePicture ?? "";
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
