import 'package:flutter/material.dart';
import 'package:uikit/models/custom_list_tile_model.dart';

class DetailDataWidget extends StatelessWidget {
  final CustomListTileModel model;
  const DetailDataWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.9,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            child: CircleAvatar(
              backgroundColor: Colors.amber,
              radius: size.width * 0.24,
              child: model.image,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 24),
            padding: const EdgeInsets.only(top: 8),
            width: size.width * 0.9,
            height: size.height * 0.15,
            child: Card(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Name: ${model.title}'),
                      Text('Specie: ${model.subTitle}'),
                      Text('Status: ${model.status}'),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
