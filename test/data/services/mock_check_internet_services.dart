import 'package:jabu_test/data/services/check_internet_service.dart';
import 'package:mockito/mockito.dart';

class MockCheckInternetServiceTrue extends Mock
    implements CheckInternetService {
  @override
  Future<bool> checkInternet() async {
    return true;
  }
}

class MockCheckInternetServiceFalse extends Mock
    implements CheckInternetService {
  @override
  Future<bool> checkInternet() async {
    return false;
  }
}
