import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/list_view_model.dart';
import 'custom_list_view_item.dart';

class CustomListView extends StatefulWidget {
  final List<CustomListTileModel> initialData;
  final Future<List<CustomListTileModel>> Function(BuildContext)? loadMoreData;
  final Function(String)? onItemTap;
  const CustomListView({
    super.key,
    required this.initialData,
    this.loadMoreData,
    this.onItemTap,
  });

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  ScrollController scrollController = ScrollController();
  late List<CustomListTileModel> data;
  var loadingMoreData = false;

  @override
  void initState() {
    super.initState();
    data = widget.initialData;
    if (widget.loadMoreData != null) {
      scrollController.addListener(_scrollListener);
    }
  }

  _scrollListener() {
    scrollController.addListener(() async {
      var nextPageTrigger =
          0.8 * scrollController.position.maxScrollExtent - 10;
      var position = scrollController.position.pixels;
      if (position > nextPageTrigger) {
        if (!loadingMoreData) {
          loadingMoreData = true;
          List<CustomListTileModel> result =
              await widget.loadMoreData!(context);
          data.addAll(result);
          loadingMoreData = false;
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('rebuild CustomListView');
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Flexible(
          flex: 2,
          child: ListView.separated(
            controller: scrollController,
            primary: false,
            shrinkWrap: true,
            itemCount: data.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, i) {
              return CustomListItem(
                item: data[i],
                onItemTap: widget.onItemTap,
              );
            },
          ),
        ),
        Visibility(
          visible: loadingMoreData,
          child: Container(
            color: Colors.white,
            width: size.width * 0.9,
            height: 100,
            child: const CupertinoActivityIndicator(),
          ),
        )
      ],
    );
  }
}
