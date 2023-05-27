import 'package:equatable/equatable.dart';

class FailureModel extends Equatable {
  final int status;
  final String message;
  const FailureModel({
    required this.status,
    required this.message,
  });

  @override
  List<Object> get props => [status, message];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return "FailureModel(status: $status, message: $message )";
  }
}
