// Copyright 2022 The myAPFP Authors. All rights reserved.

import 'dart:io';

class Internet {
  /// Returns a [Future] boolean which evaluates to true if the device is connected
  /// to the internet and false if there is no connection.
  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
