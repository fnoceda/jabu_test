import 'package:equatable/equatable.dart';

class ListViewModel extends Equatable {
  final String id;
  final String title;
  final String status;
  final String subTitle;
  final String imageUrl;

  const ListViewModel({
    required this.id,
    required this.title,
    required this.status,
    required this.subTitle,
    required this.imageUrl,
  });
  @override
  List<Object?> get props => [title, status, subTitle, imageUrl];
}
