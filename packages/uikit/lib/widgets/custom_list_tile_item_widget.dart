import 'package:flutter/material.dart';

import '../models/custom_list_tile_model.dart';

class CustomListTileItem extends StatelessWidget {
  final CustomListTileModel item;
  final Function(String)? onItemTap;

  const CustomListTileItem({
    super.key,
    required this.item,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.yellow,
        child: item.image,
      ),
      title: Text(item.title),
      subtitle: Text(item.subTitle),
      trailing: (item.status.toLowerCase() == 'alive')
          ? const Icon(Icons.check)
          : const Icon(Icons.cancel),
      onTap: () {
        if (onItemTap != null) {
          onItemTap!(item.id);
        }
        // context.goNamed('character', pathParameters: {'id': item.id});
      },
    );
  }
}
