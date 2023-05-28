import 'package:flutter/material.dart';
import '../models/list_view_model.dart';
import 'cache_network_image_wrapper.dart';

class CustomListItem extends StatelessWidget {
  final ListViewModel item;

  const CustomListItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    // print('${item.title} => ${item.status.toLowerCase()}');
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.yellow,
        child: CachedNetworkImageWrapper.getImage(imgUrl: item.imageUrl),
      ),
      title: Text(item.title),
      subtitle: Text(item.subTitle),
      trailing: (item.status.toLowerCase() == 'alive')
          ? const Icon(Icons.check)
          : const Icon(Icons.cancel),
    );
  }
}
