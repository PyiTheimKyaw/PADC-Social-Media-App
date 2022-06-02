import 'package:flutter/material.dart';

class LoginBloc extends ChangeNotifier {
  ///State
  bool isLoading = false;
  String email = "";
  String password = "";
  bool isDisposed = false;

  void onEmailChanged(String email) {
    this.email = email;
    _notifySafely();
  }

  void onPasswordChanged(String password) {
    this.password = password;
    _notifySafely();
  }

  void _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }

  void _showLoading() {
    isLoading = true;
    _notifySafely();
  }

  void _hideLoading() {
    isLoading = false;
    _notifySafely();
  }
  @override
  void dispose(){
    super.dispose();
    isDisposed=true;
  }
}
