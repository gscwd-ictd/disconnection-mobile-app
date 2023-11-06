class ConsumerModel{
  final String idNumber;
  final int? id;
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
    required this.team,
    this.id});
  
  factory ConsumerModel.fromJson(Map<String, dynamic> json) {
    return ConsumerModel(
      id: json['id'] as int,
      idNumber: json['id_number'] as String, 
      accountNumber: json['acc_number'] as String, 
      meterNumber: json['meterNumber'] as int,
      matLoan: json['matLoan'] as double,
      numMonths: json['numMonths'] as double,
      prevReading: json['prevReading'] as int,
      status: json['status'] as bool,
      team: json['team1'] as int,
      unpaidBal: json['unpaidBal'] as double,
      zone: json['zone'] as String,
      address: json['address'] as String,
      name: json['first_name'] + " " + json['last_name'] as String
      );
  }
}