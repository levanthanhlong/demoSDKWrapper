import 'package:flutter/services.dart';

class KalapaSDKService {
  static const platform = MethodChannel('sdk_channel');

  Future<bool> setupSDK1() async {
    try {
      final result = await platform.invokeMethod('setupSDK1');
      print("SDK setup result: $result");
      return result == true;
    } on PlatformException catch (e) {
      print("Error calling setupSDK: ${e.message}");
      return false;
    }
  }
  Future<dynamic> setupSDK() async {
    try {
      final result = await platform.invokeMethod('setupSDK');
      print("SDK setup result: $result");
      return result;
    } on PlatformException catch (e) {
      print("Error calling setupSDK: ${e.message}");
      return 0;
    }
  }

}
