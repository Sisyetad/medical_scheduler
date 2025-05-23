// domain/usecases/queue/get_all_queues.dart
import '../../entities/response/queue.dart';
import '../../repository/queue_repo.dart';

class GetAllQueues{
  final DataQueueRepository repository;

  GetAllQueues(this.repository);

  Future<List<DataQueue>> call() => repository.getAllQueues();
}
