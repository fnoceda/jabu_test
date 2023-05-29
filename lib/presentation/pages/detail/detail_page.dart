import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    print('id=>$id');
    return Container(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: Text('id: $id'),
        ),
      ),
    );
  }
}
