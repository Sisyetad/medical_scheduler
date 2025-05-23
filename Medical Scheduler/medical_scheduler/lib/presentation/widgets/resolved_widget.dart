import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_scheduler/presentation/Provider/providers/queue_provider.dart';

class Resolved extends ConsumerWidget {
  const Resolved({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resolved = ref.watch(doctorQueueNotifierProvider.select((state) => state.resolvedPending));

    return Container(
      height: 100,
      width: 308,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 43, 95, 145),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text("Resolved Pending", style: TextStyle(fontSize: 30)),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text("$resolved", style: const TextStyle(fontSize: 30)),
            ),
          ),
        ],
      ),
    );
  }
}
