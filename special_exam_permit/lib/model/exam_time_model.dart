class ExamTimeModel {
  final String id;
  final DateTime? examDate;
  final String startTime;
  final String endTime;

  const ExamTimeModel({
    required this.id,
    required this.examDate,
    required this.startTime,
    required this.endTime,
  });

  String get displayTime {
    return '$startTime - $endTime';
  }

  factory ExamTimeModel.fromFirestore(String id, Map<String, dynamic> data) {
    return ExamTimeModel(
      id: id,
      examDate: data['examDate'] != null ? data['examDate'].toDate() : null,
      startTime: data['startTime'] ?? '',
      endTime: data['endTime'] ?? '',
    );
  }
}
