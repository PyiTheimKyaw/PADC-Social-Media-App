import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_app/data/model/social_model.dart';
import 'package:social_media_app/data/model/social_model_impl.dart';
import 'package:social_media_app/data/vos/news_feed_vo.dart';

class AddNewPostBloc extends ChangeNotifier {
  ///State
  bool isAddNewPostError = false;
  bool isDisposed = false;
  bool isLoading=false;

  ///Imge
  File? chosenImageFile;


  ///For Edit mode
  NewsFeedVO? mNewsFeed;
  bool isInEditMode = false;
  String? userName;
  String? profilePicture;
  String newPostDescription = "";

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
  void onImageChosen(File imageFile){
    chosenImageFile=imageFile;
    _notifySafely();
  }
  void onTapDeleteImage(){
    chosenImageFile=null;
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
      isLoading=true;
      isAddNewPostError = false;
      _notifySafely();
      if (isInEditMode) {
        return _editNewsFeedPost().then((value) {
          isLoading=false;
          _notifySafely();
        });
      } else {
        return _createNewNewsFeedPost().then((value) {
          isLoading=false;
          _notifySafely();
        });
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
      _model.addNewPost(newPostDescription,chosenImageFile);

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
        "https://sm.askmen.com/t/askmen_in/article/f/facebook-p/facebook-profile-picture-affects-chances-of-gettin_fr3n.1200.jpg";
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
