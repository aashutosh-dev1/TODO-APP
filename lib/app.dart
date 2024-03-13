import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tasker/core/theme/theme.dart';
import 'package:tasker/features/home/bloc/home_bloc.dart';
import 'package:tasker/locator.dart';

///
class App extends StatelessWidget {
  ///
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator<HomeBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Tasker',
        debugShowCheckedModeBanner: false,
        theme: themeData,
        routerConfig: locator<GoRouter>(),
      ),
    );
  }
}
