import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/blocs/home/home_bloc_bloc.dart';
import '../../router.dart';
import '../../utils/enums.dart';
import '../models/list_view_model.dart';
import 'custom_list_view_widget.dart';

class ListBuilder extends StatelessWidget {
  const ListBuilder({super.key});

  Future<List<CustomListTileModel>> _getMoreData(BuildContext context) async {
    var result = context.read<HomeBlocBloc>().getMoreData();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBlocBloc, HomeBlocState>(
      builder: (context, state) {
        switch (state.requestStatus) {
          case RequestStatus.none:
          case RequestStatus.loading:
            return const Text('Loading');
          case RequestStatus.error:
            return const Text('Error');
          case RequestStatus.more:
          case RequestStatus.success:
            return Expanded(
              child: CustomListView(
                initialData: state.listViewData,
                loadMoreData: _getMoreData,
                onItemTap: (String id) {
                  AppNavigator.router.navigateTo(context, 'detail/$id');
                },
              ),
            );
        }
      },
    );
  }
}
