import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jabu_test/app/router.dart';
import 'package:jabu_test/domain/blocs/detail/detail_bloc.dart';

import '../domain/blocs/home/home_bloc_bloc.dart';
import '../domain/repository/character_repository.dart';
import '../presentation/cubit/home_cubit_cubit.dart';
import '../presentation/widgets/cache_network_image_wrapper.dart';
import 'locator.dart';

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
        debugShowCheckedModeBanner: false,
        title: 'Flutter App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff62cffc)),
          useMaterial3: true,
        ),
        initialRoute: '/',
        onGenerateRoute: AppNavigator.router.generator,
      ),
    );
  }
}
