import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasker/app_router.dart';
import 'package:tasker/core/db/local_storage_service.dart';
import 'package:tasker/data/datasource/task_data_source.dart';
import 'package:tasker/data/repositories/task_repository_impl.dart';
import 'package:tasker/domain/repositories/task_repository.dart';
import 'package:tasker/domain/usecase/tasks_usecase.dart';
import 'package:tasker/features/home/bloc/home_bloc.dart';

/// GET_IT instance
final locator = GetIt.instance;

/// DI initialization
Future<void> init() async {
  /// Datasource
  locator.registerLazySingleton<TaskDataSource>(() => TaskDataSourceImpl());

  /// Repositories
  locator.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(locator()),
  );

  /// Usecases
  locator.registerLazySingleton<InsertTaskUseCase>(
    () => InsertTaskUseCase(locator()),
  );
  locator.registerLazySingleton<EditTaskUseCase>(
    () => EditTaskUseCase(locator()),
  );
  locator.registerLazySingleton<CompleteTaskUseCase>(
    () => CompleteTaskUseCase(locator()),
  );

  locator.registerLazySingleton<DeleteTaskUseCase>(
    () => DeleteTaskUseCase(locator()),
  );
  locator.registerLazySingleton<GetAllTasksUsecases>(
    () => GetAllTasksUsecases(locator()),
  );

  /// Blocs
  locator.registerFactory(() => HomeBloc(
        insertTaskUseCase: locator(),
        editTaskUseCase: locator(),
        completeTaskUseCase: locator(),
        deleteTaskUseCase: locator(),
        getAllTasksUsecases: locator(),
      ));

  /// Routes
  locator
    ..registerSingleton<RouteObserver<PageRoute>>(RouteObserver<PageRoute>())
    ..registerSingleton(
      AppRouter(
        routeObserver: locator<RouteObserver<PageRoute>>(),
      ),
    )
    ..registerSingleton<GoRouter>(locator<AppRouter>().router);

  /// Local DB
  locator.registerLazySingleton<LocalStorageService>(
      () => LocalStorageServiceImpl());

  final database = await locator<LocalStorageService>().initializeDB();
  locator.registerLazySingleton<Database>(() => database);

  /// External
}
