import 'package:tasker/core/types/either.dart';
import 'package:tasker/core/types/failure.dart';
import 'package:tasker/data/datasource/task_data_source.dart';
import 'package:tasker/data/models/task_dto.dart';
import 'package:tasker/domain/entities/task.dart';
import 'package:tasker/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl(this.taskDataSource);

  final TaskDataSource taskDataSource;

  @override
  Future<Either<Failure, bool>> insertTask(Task task) async {
    try {
      final res = await taskDataSource.insertTask(
        TaskDto(
          id: task.id,
          label: task.label,
          description: task.description,
          priority: task.priority,
          isCompleted: task.isCompleted,
        ),
      );

      return res.when(
        left: (left) => Left(Failed(message: left.message)),
        right: (taskDto) {
          return const Right(true);
        },
      );
    } catch (e) {
      return Left(Failed(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> editTask(Task task) async {
    try {
      final res = await taskDataSource.editTask(
        TaskDto(
          id: task.id,
          label: task.label,
          description: task.description,
          priority: task.priority,
          isCompleted: task.isCompleted,
        ),
      );

      return res.when(
        left: (left) => Left(Failed(message: left.message)),
        right: (taskDto) {
          return const Right(true);
        },
      );
    } catch (e) {
      return Left(Failed(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> getAllTasks() async {
    try {
      final res = await taskDataSource.getAllTasks();

      return res.when(
        left: (left) => Left(Failed(message: left.message)),
        right: (taskDto) {
          return Right([
            for (final item in taskDto)
              Task(
                id: item.id,
                label: item.label,
                description: item.description,
                priority: item.priority,
                isCompleted: item.isCompleted,
              )
          ]);
        },
      );
    } catch (e) {
      return Left(Failed(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> completeTask(int id) async {
    try {
      final res = await taskDataSource.completeTask(id);

      return res.when(
        left: (left) => Left(Failed(message: left.message)),
        right: (taskDto) {
          return const Right(true);
        },
      );
    } catch (e) {
      return Left(Failed(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTask(int id) async {
    try {
      final res = await taskDataSource.deleteTask(id);

      return res.when(
        left: (left) => Left(Failed(message: left.message)),
        right: (taskDto) {
          return const Right(true);
        },
      );
    } catch (e) {
      return Left(Failed(message: e.toString()));
    }
  }
}
