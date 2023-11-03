

import 'package:flutter/cupertino.dart';
import 'package:rise_and_grow/utils/sp_util.dart';

import '../base/constants/app_widgets.dart';
import '../screens/login/login_screen.dart';

const String keyLogin = "login";
const String keyPrivacy = "privacy";
const String keyUserID = "userId";
const String keyUserName = "userName";
const String keyUserType = "userType";
const String keyToken = "token";
const String keyBasicToken = "BasicToken";
const String keyBearerToken = "BearerToken";
const String keyMobileNumber = "MobileNumber";
const String keyBothAccount = "bothAccount";
const String keyVersionCode = "versionCode";
const String userEmail = "email";

void onLogout() {
  setLogin(false);
  setToken("");
  setBearerToken("");
  setBasicToken("");
  setMobileNumber("");
  setUserID("");
  setUserType("");
  setBothAccount(false);
  setEmail("");
  setPrivacyAccepted(false);
  // setVersionCode("");
  Navigator.pushAndRemoveUntil(globalContext, LoginScreen.route(), (route) => false);
}

/// Login
void setLogin(bool isLogin) {
  SpUtil.putBool(keyLogin, isLogin);
}

bool isLogin() {
  return SpUtil.getBool(keyLogin, defValue: false);
}

/// Privacy Accepted or Not
void setPrivacyAccepted(bool isLogin) {
  SpUtil.putBool(keyPrivacy, isLogin);
}

bool isPrivacyAccepted() {
  return SpUtil.getBool(keyPrivacy, defValue: true);
}

/// Bearer Token
void setBearerToken(String token) {
  SpUtil.putString(keyBearerToken, token);
}

String getBearerToken() {
  return SpUtil.getString(keyBearerToken, defValue: "");
}

/// Basic Token
void setBasicToken(String token) {
  SpUtil.putString(keyBasicToken, token);
}

String getBasicToken() {
  return SpUtil.getString(keyBasicToken, defValue: "");
}

/// Mobile Number
void setMobileNumber(String token) {
  SpUtil.putString(keyMobileNumber, token);
}

String getMobileNumber() {
  return SpUtil.getString(keyMobileNumber, defValue: "");
}

/// User Id
void setUserID(String token) {
  SpUtil.putString(keyUserID, token);
}

String getUserID() {
  return SpUtil.getString(keyUserID, defValue: "");
}

void setUserName(String name) {
  SpUtil.putString(keyUserName, name);
}

String getUserName() {
  return SpUtil.getString(keyUserName, defValue: "");
}


/// User Type
void setUserType(String token) {
  SpUtil.putString(keyUserType, token);
}

String getUserType() {
  return SpUtil.getString(keyUserType, defValue: "");
}

/// Bearer Token
void setToken(String token) {
  SpUtil.putString(keyToken, token);
}

String getToken() {
  return SpUtil.getString(keyToken, defValue: "");
}

/// Both Accounts
void setBothAccount(bool isBothAccount) {
  SpUtil.putBool(keyBothAccount, isBothAccount);
}

bool isBothAccount() {
  return SpUtil.getBool(keyBothAccount, defValue: false);
}

/// Version Code
void setVersionCode(String code){
  SpUtil.putString(keyVersionCode, code);
}

String getVersionCode(){
  return SpUtil.getString(keyVersionCode ,defValue: "");
}

//Email Save
void setEmail(String email){
  SpUtil.putString(userEmail, email);
}

String getEmail(){
  return SpUtil.getString(userEmail, defValue: "");
}
