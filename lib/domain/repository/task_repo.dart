import 'package:task_master/domain/entity/task/task_entity.dart';

///
abstract class TaskRepository {
  ///
  Future<void> addTask(TaskEntity task);
}
