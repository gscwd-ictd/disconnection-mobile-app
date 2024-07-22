enum StatusEnum {
  ongoing,
  done,
  cancelled,
  mlOngoing,
  mlDone,
  transferredML,
  hasPN
}

class StatusClass {
  StatusEnum getStatus(int input) {
    switch (input) {
      case 0:
        return StatusEnum.ongoing;
      case 1:
        return StatusEnum.done;
      case 2:
        return StatusEnum.cancelled;
      case 3:
        return StatusEnum.mlOngoing;
      case 4:
        return StatusEnum.mlDone;
      case 5:
        return StatusEnum.transferredML;
      case 6:
        return StatusEnum.hasPN;
      default:
        return StatusEnum.ongoing;
    }
  }
}

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
      case StatusEnum.transferredML:
        return 5;
      case StatusEnum.hasPN:
        return 6;
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
      case StatusEnum.transferredML:
        return 'Transferred';
      case StatusEnum.hasPN:
        return 'Has Promissory Note';
      default:
        return 'Error';
    }
  }
}
