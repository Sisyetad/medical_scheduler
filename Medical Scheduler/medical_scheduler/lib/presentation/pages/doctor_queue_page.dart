import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medical_scheduler/presentation/Provider/providers/queue_provider.dart';
import 'package:medical_scheduler/presentation/widgets/completed_widget.dart';
import 'package:medical_scheduler/presentation/widgets/pending_widget.dart';
import 'package:medical_scheduler/presentation/widgets/popup_menu.dart';
import 'package:medical_scheduler/presentation/widgets/resolved_widget.dart';
import 'package:medical_scheduler/presentation/widgets/side_bar.dart';
import 'package:medical_scheduler/presentation/widgets/doctor_queue_widget.dart';
import 'package:medical_scheduler/presentation/events/queue_events.dart';

class DoctorPage extends ConsumerStatefulWidget {
  const DoctorPage({super.key});

  @override
  ConsumerState<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends ConsumerState<DoctorPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(doctorQueueNotifierProvider.notifier)
          .mapEventToState(FetchQueues());
    });
  }

  void _handlePend(int queueId) {
    final queue = ref
        .read(doctorQueueNotifierProvider)
        .queues
        .firstWhere((q) => q.queueId == queueId);

    final newStatus =
        queue.status == 1 ? 2 : 1; 

    ref
        .read(doctorQueueNotifierProvider.notifier)
        .mapEventToState(UpdateQueueStatus(queueId, newStatus));
  }

  void _handleComplete(int queueId) {
    ref
        .read(doctorQueueNotifierProvider.notifier)
        .mapEventToState(UpdateQueueStatus(queueId, 3));
  }

  void _handleViewHistory(int queueId) {
    
    final queue = ref
        .read(doctorQueueNotifierProvider)
        .queues
        .firstWhere((q) => q.queueId == queueId);
    context.go('/patient_history/${queue.patient.patientId}');
  }

  @override
  Widget build(BuildContext context) {
    final queueState = ref.watch(doctorQueueNotifierProvider);

    return SafeArea(
      child: Scaffold(
        drawer: const SideBar(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          actions: const [PopupMenu()],
        ),
        body:
            queueState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : queueState.error != null
                ? Center(child: Text('Error: ${queueState.error}'))
                : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Doctor Queue",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Completed(),
                      const SizedBox(height: 20),
                      Pending(),
                      const SizedBox(height: 20),
                      Resolved(),
                      const SizedBox(height: 20),
                      const SearchBar(hintText: "Search for Users..."),
                      const SizedBox(height: 20),
                      DoctorQueueWidget(
                        queues: queueState.queues,
                        onPend: _handlePend,
                        onComplete: _handleComplete,
                        onViewHistory: _handleViewHistory,
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
