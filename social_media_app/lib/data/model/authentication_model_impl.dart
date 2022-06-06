import 'dart:io';

import 'package:social_media_app/data/model/authentication_model.dart';
import 'package:social_media_app/data/vos/user_vo.dart';
import 'package:social_media_app/network/cloud_firestore_data_agent_impl.dart';
import 'package:social_media_app/network/real_time_database_data_agent_impl.dart';
import 'package:social_media_app/network/social_data_agent.dart';

class AuthenticationModelImpl extends AuthenticationModel {
  ///DataAgent
  SocialDataAgent mDataAgent = RealTimeDatabaseDataAgentImpl();

  @override
  Future<void> register(String email,String userName,String password,File? image){
    print("Image at model at register ${image?.path}");
    if (image != null) {
      return mDataAgent
          .uploadFileToFirebase(image)
          .then((downloadUrl) =>
              craftUserVO(email, userName, password, downloadUrl))
          .then((newUser) => mDataAgent.registerNewUser(newUser));
    } else {
      return craftUserVO(email, userName, password, "")
          .then((newUser) => mDataAgent.registerNewUser(newUser));
    }
  }

  Future<UserVO> craftUserVO(
      String email, String userName, String password, String? profilePicture) {
    var newUser = UserVO(
        id: "",
        userName: userName,
        email: email,
        password: password,
        profilePicture: profilePicture);
    return Future.value(newUser);
  }

  @override
  Future<void> login(String email, String password) {
    return mDataAgent.login(email, password);
  }

  @override
  UserVO getLoggedInUser() {
    return mDataAgent.getLoggedInUser();
  }

  @override
  bool isLoggedIn() {
    return mDataAgent.isLoggedIn();
  }

  @override
  Future<void> logOut() {
    return mDataAgent.logOut();
  }
}
