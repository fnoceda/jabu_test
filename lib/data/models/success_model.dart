import 'package:equatable/equatable.dart';

class SuccessModel extends Equatable {
  final int status;
  final String message;
  final dynamic data;
  const SuccessModel({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List<Object> get props => [status, message, data];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return "SuccessModel(status: $status, message: $message, data: $data )";
  }
}
