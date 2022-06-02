import 'package:flutter/material.dart';
import 'package:social_media_app/data/model/authentication_model.dart';
import 'package:social_media_app/data/model/authentication_model_impl.dart';

class LoginBloc extends ChangeNotifier {
  ///State
  bool isLoading = false;
  String email = "";
  String password = "";
  bool isDisposed = false;

  ///Model
  final AuthenticationModel mModel = AuthenticationModelImpl();

  Future onTapLogin() {
    _showLoading();
    return mModel.login(email, password).whenComplete(() => _hideLoading());
  }

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
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}
