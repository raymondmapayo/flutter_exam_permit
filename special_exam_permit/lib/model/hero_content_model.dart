class HeroContentModel {
  final String badge;
  final String title;
  final String description;

  final String filingWindowLabel;
  final String filingWindowValue;

  final String processedByLabel;
  final String processedByValue;

  const HeroContentModel({
    required this.badge,
    required this.title,
    required this.description,
    required this.filingWindowLabel,
    required this.filingWindowValue,
    required this.processedByLabel,
    required this.processedByValue,
  });
}

const HeroContentModel heroContent = HeroContentModel(
  badge: 'Now accepting requests',
  title: 'Special exam permit\nfor UM students',
  description: 'Missed an exam for a valid reason? Request, track, and get approved — no queueing at the registrar.',
  filingWindowLabel: 'Filing window',
  filingWindowValue: 'Opens 5 days before term end',
  processedByLabel: 'Processed by',
  processedByValue: 'Instructor + Registrar',
);
