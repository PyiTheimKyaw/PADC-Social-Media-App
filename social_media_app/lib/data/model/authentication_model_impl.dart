import 'package:social_media_app/data/model/authentication_model.dart';
import 'package:social_media_app/data/vos/user_vo.dart';
import 'package:social_media_app/network/real_time_database_data_agent_impl.dart';
import 'package:social_media_app/network/social_data_agent.dart';

class AuthenticationModelImpl extends AuthenticationModel {
  ///DataAgent
  SocialDataAgent mDataAgent = RealTimeDatabaseDataAgentImpl();

  @override
  Future<void> register(String email, String userName, String password) {
    return craftUserVO(email, userName, password)
        .then((newUser) => mDataAgent.registerNewUser(newUser));
  }

  Future<UserVO> craftUserVO(String email, String userName, String password) {
    var newUser = UserVO("", userName, email, password);
    return Future.value(newUser);
  }
}
