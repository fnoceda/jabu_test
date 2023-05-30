import 'package:flutter/material.dart';
import 'package:uikit/models/custom_list_tile_model.dart';

class DetailDataWidget extends StatelessWidget {
  final CustomListTileModel model;
  const DetailDataWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // color: Colors.grey,
      width: size.width * 0.9,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 100,
            child: model.image,
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            width: size.width * 0.9,
            height: size.height * 0.2,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: ${model.title}'),
                  Text('Specie: ${model.subTitle}'),
                  Text('Status: ${model.status}'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
