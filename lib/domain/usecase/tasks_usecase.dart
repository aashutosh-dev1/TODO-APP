import 'package:tasker/core/types/either.dart';
import 'package:tasker/core/types/failure.dart';
import 'package:tasker/domain/entities/task.dart';
import 'package:tasker/domain/repositories/task_repository.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class InsertTaskUseCase implements UseCase<bool, Task> {
  InsertTaskUseCase(this.taskRepository);

  final TaskRepository taskRepository;

  @override
  Future<Either<Failure, bool>> call(Task task) {
    return taskRepository.insertTask(task);
  }
}

class EditTaskUseCase implements UseCase<bool, Task> {
  EditTaskUseCase(this.taskRepository);

  final TaskRepository taskRepository;

  @override
  Future<Either<Failure, bool>> call(Task task) {
    return taskRepository.editTask(task);
  }
}

class CompleteTaskUseCase implements UseCase<bool, int> {
  CompleteTaskUseCase(this.taskRepository);

  final TaskRepository taskRepository;

  @override
  Future<Either<Failure, bool>> call(int id) {
    return taskRepository.completeTask(id);
  }
}

class DeleteTaskUseCase implements UseCase<bool, int> {
  DeleteTaskUseCase(this.taskRepository);

  final TaskRepository taskRepository;

  @override
  Future<Either<Failure, bool>> call(int id) {
    return taskRepository.deleteTask(id);
  }
}

class GetAllTasksUsecases implements UseCase<List<Task>, void> {
  GetAllTasksUsecases(this.taskRepository);

  final TaskRepository taskRepository;

  @override
  Future<Either<Failure, List<Task>>> call(void params) {
    return taskRepository.getAllTasks();
  }
}
