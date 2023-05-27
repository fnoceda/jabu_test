import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jabu_test_bloc/domain/bloc/home_bloc_bloc.dart';
import 'package:jabu_test_bloc/presentation/models/list_view_model.dart';
import 'package:jabu_test_bloc/utils/extensions/debounce_text_field.dart';

import '../../utils/enums.dart';
import '../cubit/home_cubit_cubit.dart';
import '../widgets/custom_list_view_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  Future<List<ListViewModel>> _getMoreData() async {
    var result = context.read<HomeBlocBloc>().getMoreData();
    return result;
  }

  // _inputChange(String text) {
  //   context
  //       .read<HomeBlocBloc>()
  //       .changeFilters(filterName: searchController.text);
  // }

  // _typeChange(String type) {
  //   context.read<HomeBlocBloc>().changeFilters(filterSpecies: type);
  // }

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
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
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
              const SizedBox(height: 20),
              const StatusFilterWidget(),
              BlocBuilder<HomeBlocBloc, HomeBlocState>(
                builder: (context, state) {
                  switch (state.requestStatus) {
                    case RequestStatus.none:
                    case RequestStatus.loading:
                      return const Text('Loading');
                    case RequestStatus.error:
                      return const Text('Error');
                    case RequestStatus.more:
                    case RequestStatus.success:
                      // print('rebuild.length => ${state.listViewData.length}');
                      // print(state.listViewData);

                      return Expanded(
                        child: CustomListView(
                          initialData: state.listViewData,
                          loadMoreData: _getMoreData,
                        ),
                      );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTypeWidget extends StatelessWidget {
  final Function(String) onChange;

  const SearchTypeWidget({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Search By:   Name'),
        Radio<SearchType>(
          value: SearchType.name,
          groupValue: context.watch<HomeCubitCubit>().state.searchType,
          onChanged: (SearchType? value) {
            if (value != null) {
              context.read<HomeCubitCubit>().changeSearchType(value);
              onChange(value.name);
            }
          },
        ),
        const Text('Species'),
        Radio<SearchType>(
          // title: const Text('Species'),
          value: SearchType.species,
          groupValue: context.watch<HomeCubitCubit>().state.searchType,
          onChanged: (SearchType? value) {
            if (value != null) {
              context.read<HomeCubitCubit>().changeSearchType(value);
              onChange(value.name);
            }
          },
        ),
      ],
    );
  }
}

class SearchInput extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onChange;

  const SearchInput(
      {super.key, required this.searchController, required this.onChange});
  // final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField().withDebounce(
          decoration: const InputDecoration(
            hintText: 'Search...',
          ),
          controller: searchController,
          duration: const Duration(milliseconds: 500),
          onChanged: (String? value) {
            if (value != null) {
              onChange(value);

              FocusScope.of(context).unfocus();
            }
          }),
    );
  }
}

class StatusFilterWidget extends StatelessWidget {
  const StatusFilterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      segments: const [
        ButtonSegment(value: DataFilter.all, icon: Text('All')),
        ButtonSegment(value: DataFilter.dead, icon: Text('Dead')),
        ButtonSegment(value: DataFilter.alive, icon: Text('Alive')),
      ],
      selected: <DataFilter>{
        context.watch<HomeCubitCubit>().state.dataStatusFilter
      },
      onSelectionChanged: (value) {
        context.read<HomeCubitCubit>().changeDataStatusFilter(value.first);
        context
            .read<HomeBlocBloc>()
            .changeFilters(filterStatus: value.first.name);
      },
    );
  }
}
