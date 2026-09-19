class Reason {
  final String title;
  final String description;

  const Reason({required this.title, required this.description});
}

final List<Reason> reasonList = [
  Reason(
    title: 'Medical reasons',
    description: 'Illness or hospitalization, with a medical certificate.',
  ),
  Reason(
    title: 'Schedule conflict',
    description: 'Two exams overlapping in the same time slot.',
  ),
  Reason(
    title: 'Official school activity',
    description: 'Representing UM in a sanctioned event.',
  ),
  Reason(
    title: 'Family emergency',
    description: "A documented emergency you can't avoid.",
  ),
];
