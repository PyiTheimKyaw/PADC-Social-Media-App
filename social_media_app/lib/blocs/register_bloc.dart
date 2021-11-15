import 'package:flutter/foundation.dart';

class RegisterBloc extends ChangeNotifier {
  String email = "";
  String password = "";
  String userName = "";

  void onTapRegister() {}

  void onEmailChanged(String email) {
    this.email = email;
  }

  void onPasswordChanged(String password) {
    this.password = password;
  }

  void onUserNameChanged(String userName) {
    this.userName = userName;
  }
}
