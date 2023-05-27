class MockCheckInternetService {
  Future<bool> checkInternet() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }
}
