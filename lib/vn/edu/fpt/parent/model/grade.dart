class GradeItem {
  final String category;
  final String name;
  final int weight;
  final double score;

  GradeItem({
    required this.category,
    required this.name,
    required this.weight,
    required this.score,
  });
}

class SubjectGrade {
  final String subject;
  final double average;
  final String status;
  final List<GradeItem> gradeItems;

  SubjectGrade({
    required this.subject,
    required this.average,
    required this.status,
    required this.gradeItems,
  });
}