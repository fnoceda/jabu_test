import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CustomListTileModel extends Equatable {
  final String id;
  final String title;
  final String status;
  final String subTitle;
  final Widget image;

  const CustomListTileModel({
    required this.id,
    required this.title,
    required this.status,
    required this.subTitle,
    required this.image,
  });
  @override
  List<Object?> get props => [title, status, subTitle, image];
}
