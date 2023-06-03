import 'package:equatable/equatable.dart';

class FailureModel extends Equatable {
  final int status;
  final String message;
  const FailureModel({
    required this.status,
    required this.message,
  });

  @override // coverage:ignore-line
  List<Object> get props => [status, message];

  @override // coverage:ignore-line
  bool get stringify => true;

  @override // coverage:ignore-line
  String toString() {
    return "FailureModel(status: $status, message: $message )";
  }
}
