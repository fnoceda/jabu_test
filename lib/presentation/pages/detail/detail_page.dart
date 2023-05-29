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
            title: const Text("Character Detail"),
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: 60.2,
            toolbarOpacity: 0.8,

            /*
           leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              tooltip: 'Menu Icon',
              onPressed: () {
                // Navigator.pop(context);
                // Navigator.of(context).pop();
                // GoRouter.of(context).pop();
                // GoRouter.of(context).push(CategoryDetail.routeName);
                context.goNamed('home');
                // GoRouter.of(context).canPop();
                // context.pop(true);
              },
            ),
           */

            // shape: const RoundedRectangleBorder(
            //   borderRadius: BorderRadius.only(
            //       bottomRight: Radius.circular(25),
            //       bottomLeft: Radius.circular(25)),
            // ),
            elevation: 0.00,
            // backgroundColor: Colors.greenAccent[400],
          ),
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

class DetailDataWidget extends StatelessWidget {
  final CustomListTileModel model;
  const DetailDataWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // color: Colors.grey,
      width: size.width * 0.9,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 100,
            child: model.image,
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            width: size.width * 0.9,
            height: size.height * 0.2,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: ${model.title}'),
                  Text('Specie: ${model.subTitle}'),
                  Text('Status: ${model.status}'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
