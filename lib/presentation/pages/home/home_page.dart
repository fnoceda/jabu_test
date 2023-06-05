import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/home/home_bloc_bloc.dart';
import '../../widgets/list_builder.dart';
import '../../widgets/search_input.dart';
import '../../widgets/search_type_widget.dart';
import '../../widgets/status_filter_widget.dart';

final TextEditingController searchController = TextEditingController();

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.white,
      child: Scaffold(
        key: const Key('ScafoldHomePage.Key'),
        appBar: AppBar(),
        body: Container(
          width: size.width * 0.9,
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SearchTypeWidget(
                onChange: (String type) {
                  context
                      .read<HomeBlocBloc>()
                      .changeFilters(filterStringType: type);
                },
              ),
              SearchInput(
                searchController: searchController,
                onChange: (String text) {
                  context
                      .read<HomeBlocBloc>()
                      .changeFilters(filterString: text);
                },
              ),
              SizedBox(height: size.width * 0.05),
              StatusFilterWidget(onChange: (String value) {
                context.read<HomeBlocBloc>().changeFilters(filterStatus: value);
              }),
              SizedBox(height: size.width * 0.05),
              ListBuilder(
                loadMoreData: context.read<HomeBlocBloc>().getMoreData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
