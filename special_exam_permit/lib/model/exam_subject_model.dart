class ExamSubjectModel {
  final String id;
  final String name;

  const ExamSubjectModel({required this.id, required this.name});

  factory ExamSubjectModel.fromFirestore(String id, Map<String, dynamic> data) {
    return ExamSubjectModel(id: id, name: data['name'] ?? '');
  }
}
