import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jabu_test_bloc/data/repository/character_repository.dart';
import 'package:jabu_test_bloc/locator.dart';
import 'domain/bloc/home_bloc_bloc.dart';
import 'presentation/cubit/home_cubit_cubit.dart';
import 'presentation/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                HomeBlocBloc(repo: Locator.sl.get<CharacterRepository>()),
          ),
          BlocProvider(create: (_) => HomeCubitCubit())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(),
        ));
  }
}
