class ExamReasonModel {
  final String name;

  const ExamReasonModel({required this.name});
}

const List<ExamReasonModel> examReasonList = [
  ExamReasonModel(name: 'Medical reasons'),
  ExamReasonModel(name: 'Schedule conflict'),
  ExamReasonModel(name: 'Official school activity'),
  ExamReasonModel(name: 'Family emergency'),
];
