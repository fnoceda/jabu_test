import 'dart:io';

class CheckInternetService {
  Future<bool> checkInternet() async {
    bool rta = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        rta = true;
      }
    } on SocketException catch (_) {
      rta = false;
    }
    return rta;
  }
}
