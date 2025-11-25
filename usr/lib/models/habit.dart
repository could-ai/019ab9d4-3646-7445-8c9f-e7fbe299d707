class Habit {
  final String id;
  final String title;
  final String emoji;
  final String? note; // Journal-like aspect
  bool isCompleted;
  final DateTime createdAt;

  Habit({
    required this.id,
    required this.title,
    required this.emoji,
    this.note,
    this.isCompleted = false,
    required this.createdAt,
  });
}
