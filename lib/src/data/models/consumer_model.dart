class ConsumerModel{
  final String idNumber;
  final String accountNumber;
  final int meterNumber;
  final String? name;
  final String? address;
  final int prevReading;
  final double unpaidBal;
  final bool status;
  final double matLoan;
  final double numMonths;
  final String zone;
  final int team;
  const ConsumerModel({
    required this.idNumber, 
    required this.accountNumber, 
    required this.meterNumber, 
    this.name, 
    this.address, 
    required this.prevReading, 
    required this.unpaidBal, 
    required this.status,
    required this.matLoan,
    required this.numMonths,
    required this.zone,
    required this.team});
}