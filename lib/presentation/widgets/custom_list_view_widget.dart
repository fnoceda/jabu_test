import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/list_view_model.dart';
import 'custom_list_view_item.dart';

class CustomListView extends StatefulWidget {
  final List<ListViewModel> initialData;
  final Future<List<ListViewModel>> Function()? loadMoreData;

  const CustomListView(
      {super.key, required this.initialData, this.loadMoreData});

  @override
  State<CustomListView> createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  ScrollController scrollController = ScrollController();
  late List<ListViewModel> data;
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
          List<ListViewModel> result = await widget.loadMoreData!();
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
    print('rebuild CustomListView');
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
              return CustomListItem(item: data[i]);
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
