class StepModel {
  final String title;
  final String description;

  const StepModel({required this.title, required this.description});
}

final List<StepModel> stepList = [
  StepModel(
    title: 'Fill out the request',
    description: 'Select your subject, reason, and preferred date/time.',
  ),
  StepModel(
    title: 'Attach your proof',
    description: 'Upload a certificate, memo, or supporting document.',
  ),
  StepModel(
    title: 'Wait for approval',
    description: 'Instructor reviews first, registrar confirms next.',
  ),
  StepModel(
    title: 'Take your exam',
    description: 'Show your digital permit at the approved venue.',
  ),
];
