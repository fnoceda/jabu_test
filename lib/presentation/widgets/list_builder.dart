import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/models/custom_list_tile_model.dart';
import 'package:uikit/widgets/custom_list_view_widget.dart';

import '../../app/router.dart';
import '../../domain/blocs/home/home_bloc_bloc.dart';
import '../../utils/enums.dart';

class ListBuilder extends StatelessWidget {
  // final Future<List<CustomListTileModel>>  getMoreData;
  final Future<List<CustomListTileModel>> Function()? loadMoreData;

  const ListBuilder({super.key, required this.loadMoreData});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBlocBloc, HomeBlocState>(
      builder: (context, state) {
        switch (state.requestStatus) {
          case RequestStatus.none:
          case RequestStatus.loading:
            return CupertinoActivityIndicator(
              radius: size.width * 0.1,
            );
          case RequestStatus.error:
            return Text(
                key: const Key('Error.Key'), state.errorMessage ?? 'Error');
          case RequestStatus.more:
          case RequestStatus.success:
            return Expanded(
              child: CustomListView(
                initialData: state.listViewData,
                loadMoreData: loadMoreData,
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
