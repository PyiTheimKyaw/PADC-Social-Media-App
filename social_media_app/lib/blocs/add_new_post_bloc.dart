import 'package:flutter/material.dart';
import 'package:social_media_app/data/model/social_model.dart';
import 'package:social_media_app/data/model/social_model_impl.dart';

class AddNewPostBloc extends ChangeNotifier {
  String newPostDescription = "";
  bool isAddNewPostError = false;
  bool isDisposed = false;

  ///Model
  final SocialModel _model = SocialModelImpl();

  void onNewPostTextChanged(String newPostDescription){
    this.newPostDescription=newPostDescription;
    notifyListeners();
  }
  Future onTapAddNewPost(){
    if(newPostDescription.isEmpty){
      isAddNewPostError=true;
      if(!isDisposed){
        notifyListeners();
      }
      return Future.error("Error");
    }else{
      isAddNewPostError=true;
      return _model.addNewPost(newPostDescription);
    }
  }

  @override
  void dispose(){
    super.dispose();
    isDisposed=true;
  }
}
