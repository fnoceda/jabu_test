import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/enums.dart';
import '../cubit/home_cubit_cubit.dart';

class SearchTypeWidget extends StatelessWidget {
  final Function(String) onChange;

  const SearchTypeWidget({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Flexible(child: Text('Search By:   Name')),
        Flexible(
          child: Radio<SearchType>(
            key: const Key('SearchType.name'),
            value: SearchType.name,
            groupValue: context.watch<HomeCubitCubit>().state.searchType,
            onChanged: (SearchType? value) {
              if (value != null) {
                context.read<HomeCubitCubit>().changeSearchType(value);
                onChange(value.name);
              }
            },
          ),
        ),
        const Flexible(child: Text('Species')),
        Flexible(
          child: Radio<SearchType>(
            key: const Key('SearchType.species'),
            value: SearchType.species,
            groupValue: context.watch<HomeCubitCubit>().state.searchType,
            onChanged: (SearchType? value) {
              if (value != null) {
                context.read<HomeCubitCubit>().changeSearchType(value);
                onChange(value.name);
              }
            },
          ),
        ),
      ],
    );
  }
}
