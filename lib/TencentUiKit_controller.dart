import 'package:flutter/material.dart';
import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';

class TIMUIKITService {
  //singleton instance
  static final TIMUIKITService _instance = TIMUIKITService._internal();

  //coreServices instance
  final CoreServicesImpl _coreServices = TIMUIKitCore.getInstance();

  //private constructor
  TIMUIKITService._internal();

  //factory method to return the singleton instance
  factory TIMUIKITService() {
    return _instance;
  }

  //initialization method
  void initTIMUIKIT() {
    _coreServices.init(
      sdkAppID: 20020673,
      loglevel: LogLevelEnum.V2TIM_LOG_DEBUG,
      listener: V2TimSDKListener(
        onConnecting: () {
          print('Connecting...');
        },
        onConnectSuccess: () {
          print('Connected');
        },
        onConnectFailed: (code, error) {
          print('Connect failed: $code, $error');
        },
        onKickedOffline: () {
          print('Kicked offline');
        },
        onUserSigExpired: () {
          print('UserSig expired');
        },
      ),
    );
  }

  //login method
  Future<void> login(String userID, String userSig) async {
    try {
      final res = await _coreServices.login(userID: userID, userSig: userSig);
      debugPrint("login successful: ${res.toJson()}");
    } catch (e) {
      print('Login failed: $e');
    }
  }
}
