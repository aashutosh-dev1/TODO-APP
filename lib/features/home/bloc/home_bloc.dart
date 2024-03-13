// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tasker/domain/entities/task.dart';
import 'package:tasker/domain/usecase/tasks_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllTasksUsecases getAllTasksUsecases;
  final InsertTaskUseCase insertTaskUseCase;
  final CompleteTaskUseCase completeTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final EditTaskUseCase editTaskUseCase;

  HomeBloc({
    required this.getAllTasksUsecases,
    required this.insertTaskUseCase,
    required this.completeTaskUseCase,
    required this.deleteTaskUseCase,
    required this.editTaskUseCase,
  }) : super(const HomeState()) {
    /// Insert task
    on<InsertTaskEvent>((event, emit) async {
      try {
        final res = await insertTaskUseCase.call(event.task);

        res.when(
          left: (failure) {
            log(failure.message);
            emit(state.copyWith(insertTasksStatus: InsertTasksStatus.failed));
          },
          right: (tasks) {
            emit(state.copyWith(insertTasksStatus: InsertTasksStatus.success));
            add(GetAllTasksEvent());
          },
        );
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(insertTasksStatus: InsertTasksStatus.failed));
      }
    });

    /// Edit Task
    on<EditTaskEvent>((event, emit) async {
      try {
        final res = await editTaskUseCase.call(event.task);

        res.when(
          left: (failure) {
            log(failure.message);
            emit(state.copyWith(editTasksStatus: EditTasksStatus.failed));
          },
          right: (tasks) {
            emit(state.copyWith(editTasksStatus: EditTasksStatus.success));
            add(GetAllTasksEvent());
          },
        );
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(editTasksStatus: EditTasksStatus.failed));
      }
    });

    /// Complete Tasks
    on<CompleteTaskEvent>((event, emit) async {
      try {
        final res = await completeTaskUseCase.call(event.id);

        res.when(
          left: (failure) {
            log(failure.message);
            emit(state.copyWith(updateTasksStatus: UpdateTasksStatus.failed));
          },
          right: (tasks) {
            emit(state.copyWith(updateTasksStatus: UpdateTasksStatus.success));
            add(GetAllTasksEvent());
          },
        );
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(updateTasksStatus: UpdateTasksStatus.failed));
      }
    });

    /// Delete Tasks
    on<DeleteTaskEvent>((event, emit) async {
      try {
        final res = await deleteTaskUseCase.call(event.id);

        res.when(
          left: (failure) {
            log(failure.message);
            emit(state.copyWith(deleteTasksStatus: DeleteTasksStatus.failed));
          },
          right: (tasks) {
            emit(state.copyWith(deleteTasksStatus: DeleteTasksStatus.success));
            add(GetAllTasksEvent());
          },
        );
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(deleteTasksStatus: DeleteTasksStatus.failed));
      }
    });

    /// Fetch all tasks
    on<GetAllTasksEvent>((event, emit) async {
      try {
        emit(
          state.copyWith(
            insertTasksStatus: InsertTasksStatus.initial,
            deleteTasksStatus: DeleteTasksStatus.initial,
            updateTasksStatus: UpdateTasksStatus.initial,
            editTasksStatus: EditTasksStatus.initial,
            fetchTasksStatus: FetchTasksStatus.loading,
          ),
        );

        final res = await getAllTasksUsecases.call(null);

        res.when(
          left: (failure) {
            log(failure.message);
            emit(state.copyWith(fetchTasksStatus: FetchTasksStatus.failed));
          },
          right: (tasks) {
            emit(state.copyWith(
              fetchTasksStatus: FetchTasksStatus.success,
              tasksList: tasks,
            ));
            log('Tasks fetch success');
          },
        );
      } catch (e) {
        log(e.toString());
        emit(state.copyWith(fetchTasksStatus: FetchTasksStatus.failed));
      }
    });
  }
}
