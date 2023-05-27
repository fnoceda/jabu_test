import 'dart:io';

import 'package:flutter/foundation.dart';

class CheckInternetService {
  Future<bool> checkInternet() async {
    bool rta = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      // final result = await InternetAddress.lookup('10.150.10.91');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        rta = true;
        if (kDebugMode) print('tiene internet');
        if (kDebugMode) print(result);
      }
    } on SocketException catch (_) {
      if (kDebugMode) print(_.message);
      if (kDebugMode) print('no hay internet');
      rta = false;
    }
    return rta;
  }
}
