///
extension TaskDelegationCatExtension on TaskDelegationCat {
  ///
  String get label {
    switch (this) {
      case TaskDelegationCat.jeane:
        return 'Jeane - UX Writer';
      case TaskDelegationCat.max:
        return 'Max - UX Designer';
      case TaskDelegationCat.tom:
        return 'Tom - UI Designer';
      case TaskDelegationCat.lerm:
        return 'Lerm - Flutter Developer';
      case TaskDelegationCat.sasha:
        return 'Sasha - UI/UX Designer';
      case TaskDelegationCat.claudia:
        return 'Claudia - Full Stack Developer';
      case TaskDelegationCat.john:
        return 'John - Lead Flutter';
      case TaskDelegationCat.unknown:
        return 'Unknown';
    }
  }
}

///
enum TaskDelegationCat {
  ///
  jeane,

  ///
  max,

  ///
  tom,

  ///
  lerm,

  ///
  sasha,

  ///
  claudia,

  ///
  john,

  ///
  unknown,
}
