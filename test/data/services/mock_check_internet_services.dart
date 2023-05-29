import 'package:jabu_test_bloc/data/services/check_internet_service.dart';
import 'package:mockito/mockito.dart';

class MockCheckInternetServiceTrue extends Mock
    implements CheckInternetService {
  @override
  Future<bool> checkInternet() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true;
  }
}

class MockCheckInternetServiceFalse extends Mock
    implements CheckInternetService {
  @override
  Future<bool> checkInternet() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return false;
  }
}
