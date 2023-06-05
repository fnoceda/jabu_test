import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/enums.dart';
import '../cubit/home_cubit_cubit.dart';

class StatusFilterWidget extends StatelessWidget {
  final Function(String) onChange;

  const StatusFilterWidget({
    super.key,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      key: const Key('SegmentedButton.Key'),
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
        // context .read<HomeBlocBloc>() .changeFilters(filterStatus: value.first.name);
        onChange(value.first.name);
      },
    );
  }
}
