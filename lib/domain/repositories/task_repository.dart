import 'package:tasker/core/types/either.dart';
import 'package:tasker/core/types/failure.dart';
import 'package:tasker/domain/entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, bool>> insertTask(Task task);
  Future<Either<Failure, bool>> editTask(Task task);
  Future<Either<Failure, bool>> completeTask(int id);
  Future<Either<Failure, bool>> deleteTask(int id);
  Future<Either<Failure, List<Task>>> getAllTasks();
}
