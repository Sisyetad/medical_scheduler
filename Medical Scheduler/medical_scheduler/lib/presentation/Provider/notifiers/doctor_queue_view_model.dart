import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/core/usecases/params.dart';
import 'package:medical_scheduler/domain/usecases/Queue/getQueues.dart';
import 'package:medical_scheduler/domain/usecases/Queue/update_queue.dart';
import 'package:medical_scheduler/presentation/Provider/states/queue_state.dart';
import 'package:medical_scheduler/presentation/events/queue_events.dart';

class DoctorQueueNotifier extends StateNotifier<QueueUiState> {
  final UpdateQueue updateQueueUseCase;
  final GetAllQueues getAllQueues;
  DoctorQueueNotifier(this.updateQueueUseCase, this.getAllQueues)
    : super(QueueUiState());

  Future<void> mapEventToState(DoctorQueueEvent event) async {
    if (event is FetchQueues) {
      await _fetchQueues();
    } else if (event is UpdateQueueStatus) {
      await _updateQueueStatus(event.queueId, event.status);
    } else if (event is NavigateToPatientHistory) {

    }
  }

  Future<void> _fetchQueues() async {
    try {
      state = state.copyWith(isLoading: true);

      final result = await getAllQueues();

      final queues = result; 
      final completed = queues.where((q) => q.status == 3).length;
      final pending = queues.where((q) => q.status == 1).length;
      final resolvedPending = queues.where((q) => q.status == 2).length;

      state = state.copyWith(
        isLoading: false,
        queues: queues,
        completed: completed,
        pending: pending,
        resolvedPending: resolvedPending,
        isSuccess: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        isSuccess: false,
      );
    }
  }

  Future<void> _updateQueueStatus(int queueId, int newStatus) async {
    try {
      state = state.copyWith(isLoading: true);

      await updateQueueUseCase(
        UpdateQueueParams(queueId: queueId, status: newStatus),
      );

      final updatedQueues =
          state.queues.map((queue) {
            if (queue.queueId == queueId) {
              return queue.copyWith(status: newStatus);
            }
            return queue;
          }).toList();
          
      final completed = updatedQueues.where((q) => q.status == 3).length;
      final pending = updatedQueues.where((q) => q.status == 1).length;
      final resolvedPending = updatedQueues.where((q) => q.status == 2).length;

      state = state.copyWith(
        isLoading: false,
        queues: updatedQueues,
        completed: completed,
        pending: pending,
        resolvedPending: resolvedPending,
        isSuccess: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        isSuccess: false,
      );
    }
  }
}
