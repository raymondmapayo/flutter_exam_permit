class ExamReasonModel {
  final String id;
  final String name;

  const ExamReasonModel({required this.id, required this.name});

  factory ExamReasonModel.fromFirestore(String id, Map<String, dynamic> data) {
    return ExamReasonModel(id: id, name: data['name'] ?? '');
  }
}
