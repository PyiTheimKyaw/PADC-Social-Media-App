import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_app/data/model/authentication_model.dart';
import 'package:social_media_app/data/model/authentication_model_impl.dart';

class RegisterBloc extends ChangeNotifier {
  ///State
  bool isLoading = false;
  String email = "";
  String password = "";
  String userName = "";
  bool isDisposed = false;
  File? chosenImageFile;
  ///Model
  AuthenticationModel mModel = AuthenticationModelImpl();

  Future onTapRegister() {
    _showLoading();
    return mModel
        .register(email, userName, password,chosenImageFile)
        .whenComplete(() => _hideLoading());
  }
  void onImageChosen(File image){
    chosenImageFile=image;
    _notifySafely();
  }
  void onEmailChanged(String email) {
    this.email = email;
    _notifySafely();
  }

  void onUserNameChange(String userName) {
    this.userName = userName;
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
