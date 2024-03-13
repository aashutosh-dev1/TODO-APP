// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class InsertTaskEvent extends HomeEvent {
  final Task task;

  InsertTaskEvent({
    required this.task,
  });
}

class EditTaskEvent extends HomeEvent {
  final Task task;

  EditTaskEvent({
    required this.task,
  });
}

class CompleteTaskEvent extends HomeEvent {
  final int id;
  CompleteTaskEvent({
    required this.id,
  });
}

class DeleteTaskEvent extends HomeEvent {
  final int id;
  DeleteTaskEvent({
    required this.id,
  });
}

class GetAllTasksEvent extends HomeEvent {}
