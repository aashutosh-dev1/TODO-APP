// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'home_bloc.dart';

enum FetchTasksStatus { initial, loading, success, failed }

enum InsertTasksStatus { initial, loading, success, failed }

enum EditTasksStatus { initial, loading, success, failed }

enum DeleteTasksStatus { initial, loading, success, failed }

enum UpdateTasksStatus { initial, loading, success, failed }

class HomeState extends Equatable {
  final FetchTasksStatus fetchTasksStatus;
  final InsertTasksStatus insertTasksStatus;
  final EditTasksStatus editTasksStatus;
  final DeleteTasksStatus deleteTasksStatus;
  final UpdateTasksStatus updateTasksStatus;
  final List<Task> tasksList;

  const HomeState({
    this.fetchTasksStatus = FetchTasksStatus.initial,
    this.insertTasksStatus = InsertTasksStatus.initial,
    this.editTasksStatus = EditTasksStatus.initial,
    this.deleteTasksStatus = DeleteTasksStatus.initial,
    this.updateTasksStatus = UpdateTasksStatus.initial,
    this.tasksList = const <Task>[],
  });

  @override
  List<Object> get props {
    return [
      fetchTasksStatus,
      insertTasksStatus,
      editTasksStatus,
      deleteTasksStatus,
      updateTasksStatus,
      tasksList,
    ];
  }

  HomeState copyWith({
    FetchTasksStatus? fetchTasksStatus,
    InsertTasksStatus? insertTasksStatus,
    EditTasksStatus? editTasksStatus,
    DeleteTasksStatus? deleteTasksStatus,
    UpdateTasksStatus? updateTasksStatus,
    List<Task>? tasksList,
  }) {
    return HomeState(
      fetchTasksStatus: fetchTasksStatus ?? this.fetchTasksStatus,
      insertTasksStatus: insertTasksStatus ?? this.insertTasksStatus,
      editTasksStatus: editTasksStatus ?? this.editTasksStatus,
      deleteTasksStatus: deleteTasksStatus ?? this.deleteTasksStatus,
      updateTasksStatus: updateTasksStatus ?? this.updateTasksStatus,
      tasksList: tasksList ?? this.tasksList,
    );
  }
}
