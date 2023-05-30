import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jabu_test_bloc/app/router.dart';
import 'package:jabu_test_bloc/domain/blocs/detail/detail_bloc.dart';

import '../domain/blocs/home/home_bloc_bloc.dart';
import '../domain/repository/character_repository.dart';
import '../presentation/pages/cubit/home_cubit_cubit.dart';
import '../presentation/widgets/cache_network_image_wrapper.dart';
import 'locator.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeBlocBloc(
            repo: Locator.sl.get<CharacterRepository>(),
            imageBuilder: Locator.sl.get<CachedNetworkImageWrapper>(),
          ),
        ),
        BlocProvider(create: (_) => HomeCubitCubit()),
        BlocProvider(
          create: (_) => DetailBloc(
            repo: Locator.sl.get<CharacterRepository>(),
            imageBuilder: Locator.sl.get<CachedNetworkImageWrapper>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        // navigatorKey: appNavigatorKey,
        onGenerateRoute: AppNavigator.router.generator,
      ),
    );
  }
}
