/// --- DIFFICULTY LEVEL (Very Easy -> Advanced)
enum DifficultyLevel {
  ///
  veryEasy,

  ///
  easy,

  ///
  medium,

  ///
  hard,

  ///
  advanced,
}

///
extension DifficultyLevelExtension on DifficultyLevel {
  ///
  String get label {
    switch (this) {
      case DifficultyLevel.veryEasy:
        return 'Very Easy (Less Than a Day)';
      case DifficultyLevel.easy:
        return 'Easy (1-2 Days)';
      case DifficultyLevel.medium:
        return 'Medium (2-3 Days)';
      case DifficultyLevel.hard:
        return 'Hard (3-5 Days)';
      case DifficultyLevel.advanced:
        return 'Advanced (1 Week)';
    }
  }
}
