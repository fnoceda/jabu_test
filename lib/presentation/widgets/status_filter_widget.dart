import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/blocs/home/home_bloc_bloc.dart';
import '../../utils/enums.dart';
import '../cubit/home_cubit_cubit.dart';

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
