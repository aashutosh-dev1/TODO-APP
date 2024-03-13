import 'package:sqflite/sqflite.dart';
import 'package:tasker/core/types/either.dart';
import 'package:tasker/core/types/failure.dart';
import 'package:tasker/data/models/task_dto.dart';
import 'package:tasker/locator.dart';

abstract class TaskDataSource {
  Future<Either<Failure, bool>> insertTask(TaskDto taskDto);

  Future<Either<Failure, bool>> editTask(TaskDto taskDto);

  Future<Either<Failure, bool>> completeTask(int id);

  Future<Either<Failure, bool>> deleteTask(int id);

  Future<Either<Failure, List<TaskDto>>> getAllTasks();
}

class TaskDataSourceImpl implements TaskDataSource {
  @override
  Future<Either<Failure, bool>> insertTask(TaskDto taskDto) async {
    try {
      final db = locator<Database>();

      final res = await db.rawInsert(
        'INSERT INTO tasks(id, label, description, priority, completed) VALUES(?, ?, ?, ?, ?)',
        [
          taskDto.id,
          taskDto.label,
          taskDto.description,
          taskDto.priority,
          taskDto.isCompleted
        ],
      ).onError((error, stackTrace) => 0);

      if (res != 0) {
        return const Right(true);
      } else {
        return Left(Failed(message: 'Failed to insert ${taskDto.id}'));
      }
    } catch (e) {
      return Left(Failed(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> editTask(TaskDto taskDto) async {
    try {
      final db = locator<Database>();

      final res = await db.rawUpdate(
        'UPDATE tasks SET label = ?, description = ? , priority = ? , completed = ? WHERE id = ?',
        [
          taskDto.label,
          taskDto.description,
          taskDto.priority,
          taskDto.isCompleted,
          taskDto.id,
        ],
      ).onError((error, stackTrace) => 0);

      if (res != 0) {
        return const Right(true);
      } else {
        return Left(Failed(message: 'Failed to insert ${taskDto.id}'));
      }
    } catch (e) {
      return Left(Failed(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskDto>>> getAllTasks() async {
    try {
      final db = locator<Database>();

      final tasks = await db.query('tasks');

      if (tasks.isNotEmpty) {
        return Right([
          for (final items in tasks)
            TaskDto(
              id: items['id'] as int,
              label: items['label'] as String,
              description: items['description'] as String,
              priority: items['priority'] as int,
              isCompleted: items['completed'] as int,
            )
        ]);
      } else {
        return const Right([]);
      }
    } catch (e) {
      return Left(Failed(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> completeTask(int id) async {
    try {
      final db = locator<Database>();

      await db
          .rawUpdate('UPDATE tasks SET completed = ? WHERE id = ?', [1, id]);

      return const Right(true);
    } catch (e) {
      return Left(Failed(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteTask(int id) async {
    try {
      final db = locator<Database>();

      await db.rawDelete('DELETE FROM tasks WHERE id = ?', [id]);

      return const Right(true);
    } catch (e) {
      return Left(Failed(message: e.toString()));
    }
  }
}
