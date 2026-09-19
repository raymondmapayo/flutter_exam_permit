class ExamTimeModel {
  final String time;

  const ExamTimeModel({required this.time});
}

const List<ExamTimeModel> examTimeList = [
  ExamTimeModel(time: '8:00 AM - 10:00 AM'),
  ExamTimeModel(time: '10:00 AM - 12:00 PM'),
  ExamTimeModel(time: '1:00 PM - 3:00 PM'),
  ExamTimeModel(time: '3:00 PM - 5:00 PM'),
];
