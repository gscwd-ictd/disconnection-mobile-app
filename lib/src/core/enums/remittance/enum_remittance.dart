// ignore_for_file: constant_identifier_names
enum Remittance{
  Unremitted,
  RemitInProgress,
  Remitted,
  Unpaid,
  Paid,
}

String enumRemittanceValue(Remittance val){
  switch(val){
    case Remittance.Unremitted:
      return 'Unremitted';
    case Remittance.RemitInProgress:
      return 'Remit In Progress';
    case Remittance.Remitted:
      return 'Remitted';
    case Remittance.Unpaid:
      return 'Unpaid';
    case Remittance.Paid:
      return 'Completed';
    default:
      return 'Unknown';
  }
}

class EnumRemittance{
  static List<String> remittanceLabel = ["Unremitted", "Remit in Progress", "Remitted"];
  static List<String> remitStatusLabel = ["Unpaid", "Remit in Progress", "Completed", "Override Remittance"];
}