import 'package:flutter/material.dart';
import 'package:medical_scheduler/domain/entities/response/queue.dart'; // import your DataQueue entity

class DoctorQueueWidget extends StatelessWidget {
  final List<DataQueue> queues;
  final Function(int queueId) onViewHistory;
  final Function(int queueId) onPend;
  final Function(int queueId) onComplete;

  const DoctorQueueWidget({
    super.key,
    required this.queues,
    required this.onViewHistory,
    required this.onPend,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingRowColor: WidgetStateProperty.resolveWith<Color?>(
        (states) => const Color.fromARGB(255, 43, 95, 145),
      ),
      headingRowHeight: 40,
      dataRowHeight: 120,
      columns: const [
        DataColumn(label: Text('Name', style: TextStyle(color: Colors.white))),
        DataColumn(
          label: Text('Status', style: TextStyle(color: Colors.white)),
        ),
        DataColumn(
          label: Text('Actions', style: TextStyle(color: Colors.white)),
        ),
      ],
      rows:
          queues.map((queue) {
            return DataRow(
              cells: [
                DataCell(
                  Text(queue.patient.firstName),
                ), // Assuming DataQueue has patient with name
                DataCell(Text(_statusText(queue.status))),
                DataCell(
                  SizedBox(
                    height: 100, // match your row height
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 26,
                          child: ElevatedButton(
                            onPressed: () => onPend(queue.queueId),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2B5F91),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              textStyle: const TextStyle(fontSize: 12),
                            ),
                            child: Text(
                              queue.status == 1 ? 'Resolved' : 'Pend',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 26,
                          child: ElevatedButton(
                            onPressed: () => onViewHistory(queue.queueId),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2B5F91),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              textStyle: const TextStyle(fontSize: 12),
                            ),
                            child: const Text(
                              'View History',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 26,
                          child: ElevatedButton(
                            onPressed: () => onComplete(queue.queueId),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2B5F91),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              textStyle: const TextStyle(fontSize: 12),
                            ),
                            child: const Text(
                              'Complete',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
      border: TableBorder.all(color: Colors.grey, width: 1),
    );
  }

  String _statusText(int status) {
    switch (status) {
      case 1:
        return 'Pending';
      case 2:
        return 'Resolved';
      case 3:
        return 'Completed';
      default:
        return 'Unknown';
    }
  }
}
