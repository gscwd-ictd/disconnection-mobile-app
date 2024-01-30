enum StatusEnum { ongoing, done, cancelled, mlOngoing, mlDone }

extension StatusExtension on StatusEnum {
  int get getIntVal {
    switch (this) {
      case StatusEnum.ongoing:
        return 0;
      case StatusEnum.done:
        return 1;
      case StatusEnum.cancelled:
        return 2;
      case StatusEnum.mlOngoing:
        return 3;
      case StatusEnum.mlDone:
        return 4;
      default:
        return 0;
    }
  }

  String get getStringVal {
    switch (this) {
      case StatusEnum.ongoing:
        return 'Ongoing';
      case StatusEnum.done:
        return 'Done';
      case StatusEnum.cancelled:
        return 'Cancelled';
      case StatusEnum.mlOngoing:
        return 'MainLine Ongoing';
      case StatusEnum.mlDone:
        return 'Mainline Done';
      default:
        return 'Error';
    }
  }
}
