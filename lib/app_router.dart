// ignore_for_file: strict_raw_type, public_member_api_docs, avoid_unused_constructor_parameters, lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasker/domain/entities/task.dart';
import 'package:tasker/features/home/home_screen.dart';
import 'package:tasker/features/splash/splash_screen.dart';
import 'package:tasker/features/tasks/create_task_screen.dart';
import 'package:tasker/features/tasks/edit_task_screen.dart';
import 'package:tasker/locator.dart';

///
class AppRouter {
  ///
  AppRouter({
    required RouteObserver<PageRoute> routeObserver,
  }) {
    router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      observers: [locator<RouteObserver<PageRoute>>()],
      errorBuilder: (context, state) => Text(state.error.toString()),
      // redirect: (context, state) {},
      routes: [
        GoRoute(
          name: splash,
          path: splash,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          name: home,
          path: home,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          name: taskCreate,
          path: taskCreate,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) => const CreateTaskScreen(),
        ),
        GoRoute(
          name: taskEdit,
          path: taskEdit,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;

            return EditTaskScreen(
              task: args['task'] as Task,
            );
          },
        ),
      ],
    );
  }

  ///
  late final GoRouter router;

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static const splash = '/';
  static const home = '/home';
  static const taskCreate = '/task-create';
  static const taskEdit = '/task-edit';
}
