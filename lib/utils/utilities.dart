import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class Utilities {
  static bool get isIOS {
    if (kIsWeb) {
      return false; // or detect from user agent
    }
    return Platform.isIOS;
  }
}