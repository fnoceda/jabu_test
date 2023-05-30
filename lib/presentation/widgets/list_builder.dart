import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/models/custom_list_tile_model.dart';
import 'package:uikit/widgets/custom_list_view_widget.dart';

import '../../app/router.dart';
import '../../domain/blocs/home/home_bloc_bloc.dart';
import '../../utils/enums.dart';

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
            return const Text(key: Key('Loading.Key'), 'Loading');
          case RequestStatus.error:
            return const Text(key: Key('Error.Key'), 'Error');
          case RequestStatus.more:
          case RequestStatus.success:
            return Expanded(
              child: CustomListView(
                initialData: state.listViewData,
                loadMoreData: _getMoreData,
                onItemTap: (String id) {
                  print('navegate.to => detail/$id');
                  AppNavigator.router.navigateTo(context, 'detail/$id');
                },
              ),
            );
        }
      },
    );
  }
}
