import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jabu_test_bloc/presentation/cubit/home_cubit_cubit.dart';

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
  bool visible = false;
  late HomeCubitCubit cubit;

  @override
  void initState() {
    super.initState();
    data = widget.initialData;
    if (widget.loadMoreData != null) {
      scrollController.addListener(_scrollListener);
    }
    cubit = context.read<HomeCubitCubit>();
  }

  void _scrollListener() {
    scrollController.addListener(() async {
      var nextPageTrigger = 0.8 * scrollController.position.maxScrollExtent;
      if (scrollController.position.pixels > nextPageTrigger) {
        if (!cubit.state.loadingMoreData) {
          cubit.changeLoadingMoreData(loading: true);
          List<ListViewModel> result = await widget.loadMoreData!();
          data.addAll(result);
          cubit.changeLoadingMoreData(loading: false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
          visible: context.watch<HomeCubitCubit>().state.loadingMoreData,
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
