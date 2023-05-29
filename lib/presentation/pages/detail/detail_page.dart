import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jabu_test_bloc/domain/blocs/detail/detail_bloc.dart';
import 'package:jabu_test_bloc/presentation/models/list_view_model.dart';
import 'package:jabu_test_bloc/utils/enums.dart';

class DetailPage extends StatelessWidget {
  final String id;
  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<DetailBloc>().getCharacter(id: id);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: const Text("Sample"),
            centerTitle: true,
          ),
          body: BlocBuilder<DetailBloc, DetailState>(
            builder: (context, state) {
              switch (state.fetchStatus) {
                case FetchDataStatus.none:
                  return const Text('none...');
                case FetchDataStatus.fetching:
                  return const Text('loading...');
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

class DetailDataWidget extends StatelessWidget {
  final CustomListTileModel model;
  const DetailDataWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey,
      width: size.width * 0.9,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(child: model.image),
          Text(model.id),
          Text(model.title),
          Text(model.subTitle),
          Text(model.status),
        ],
      ),
    );
  }
}
