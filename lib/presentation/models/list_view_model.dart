import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ListViewModel extends Equatable {
  final String id;
  final String title;
  final String status;
  final String subTitle;
  final Widget image;

  const ListViewModel({
    required this.id,
    required this.title,
    required this.status,
    required this.subTitle,
    required this.image,
  });
  @override
  List<Object?> get props => [title, status, subTitle, image];
}
