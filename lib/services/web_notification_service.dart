import 'package:flutter/foundation.dart';
import 'dart:js_interop';

@JS('getFirebaseToken')
external JSPromise<JSString?> _getFirebaseToken();

@JS('Notification.permission')
external String get _notificationPermission;

@JS('Notification.requestPermission')
external JSPromise<JSString> _requestNotificationPermission();

class WebNotificationService {
  static Future<bool> requestPermission() async {
    if (!kIsWeb) return false;
    
    try {
      final result = await _requestNotificationPermission().toDart;
      return result.toDart == 'granted';
    } catch (e) {
      debugPrint('Error requesting notification permission: $e');
      return false;
    }
  }

  static bool get isPermissionGranted {
    if (!kIsWeb) return false;
    try {
      return _notificationPermission == 'granted';
    } catch (e) {
      return false;
    }
  }

  static Future<String?> getToken() async {
    if (!kIsWeb) return null;
    
    try {
      final token = await _getFirebaseToken().toDart;
      return token?.toDart;
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      return null;
    }
  }
}
