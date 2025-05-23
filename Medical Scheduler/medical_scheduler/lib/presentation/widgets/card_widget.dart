import 'package:flutter/material.dart';
import 'package:medical_scheduler/domain/entities/response/diagnosis_history.dart';

class GreenBook extends StatelessWidget {
  final DiagnosisHistory diagnosis;

  const GreenBook({super.key, required this.diagnosis});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 323,
      height: 426,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 43, 95, 145),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Diagnosis Name: ${diagnosis.diagnosisName}",
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
            const SizedBox(height: 8),
            Text(
              "Date: ${diagnosis.createdTime}",
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(height: 8),
            Text(
              "Doctor's Name: ${diagnosis.doctor.username}",
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(height: 8),
            Text(
              "Medication: ${diagnosis.medication}",
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(height: 8),
            Text(
              "Comments: ${diagnosis.comment}",
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
