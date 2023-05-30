import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jabu_test/domain/blocs/detail/detail_bloc.dart';
import 'package:jabu_test/utils/enums.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/detail_data_widget.dart';

class DetailPage extends StatelessWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<DetailBloc>().getCharacter(id: id);
    return Container(
      key: const Key('DetailPage.key'),
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: const CustomAppBar(),
          body: BlocBuilder<DetailBloc, DetailState>(
            builder: (context, state) {
              switch (state.fetchStatus) {
                case FetchDataStatus.none:
                  return const Center(child: Text('none...'));
                case FetchDataStatus.fetching:
                  return const Center(child: Text('loading...'));
                case FetchDataStatus.fail:
                  return Text(state.errorMessage ?? 'Error');
                case FetchDataStatus.success:
                  return DetailDataWidget(model: state.viewModel!);
              }
            },
          ),
        ),
      ),
    );
  }
}
