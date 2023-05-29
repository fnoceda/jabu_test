import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/enums.dart';
import '../pages/home/cubit/home_cubit_cubit.dart';

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
