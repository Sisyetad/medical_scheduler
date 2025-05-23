abstract class PatientHistoryEvent {}

class FetchPatientHistory extends PatientHistoryEvent {
  final int patientId;
  FetchPatientHistory(this.patientId);
}

class NavigateToDiagnosisDetails extends PatientHistoryEvent {
  final int diagnosisId;
  NavigateToDiagnosisDetails(this.diagnosisId);
}

class NavigateToAddDiagnosis extends PatientHistoryEvent {}