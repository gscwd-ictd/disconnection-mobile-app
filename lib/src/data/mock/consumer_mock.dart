import 'package:diconnection/src/data/models/consumer_model.dart';

class ConsumerMockData{
  static List<ConsumerModel> consumerList = [
    const ConsumerModel(
      idNumber: "1",
      accountNumber: "1233-MTR",
      matLoan: 0.00,
      meterNumber: 12233,
      numMonths: 2,
      status: false,
      unpaidBal: 1220.92,
      address: "General Santos City",
      name: "Juan Dela Cruz",
      prevReading: 122200,
      zone: "1",
      team: 0
      ),
      const ConsumerModel(
      idNumber: "2",
      accountNumber: "1234-MTR",
      matLoan: 0.00,
      meterNumber: 12234,
      numMonths: 1,
      status: true,
      unpaidBal: 1000.92,
      address: "General Santos City",
      name: "Mary Ann Santos",
      prevReading: 12232,
      zone: "2",
      team: 0
      ),
      const ConsumerModel(
      idNumber: "3",
      accountNumber: "1235-MTR",
      matLoan: 0.00,
      meterNumber: 12235,
      numMonths: 1,
      status: true,
      unpaidBal: 500.02,
      address: "General Santos City",
      name: "Ian Spencer Robleza",
      prevReading: 12232,
      zone: "1",
      team: 0
      )
  ];
}