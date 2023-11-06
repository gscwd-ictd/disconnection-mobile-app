import 'package:diconnection/src/data/models/user_model.dart';

class AuthMock{
  static List<UserModel> authList = [
    const UserModel(employeeId: "120", username: "ian", password: "123qwe", authLevel: 0),
    const UserModel(employeeId: "121", username: "jane", password: "123qwe", authLevel: 0),
    const UserModel(employeeId: "122", username: "borloloy", password: "123qwe", authLevel: 1),
    const UserModel(employeeId: "123", username: "dodong", password: "123qwe", authLevel: 2),
    const UserModel(employeeId: "124", username: "bemaks", password: "123qwe", authLevel: 3),
    const UserModel(employeeId: "125", username: "jay", password: "123qwe", authLevel: 4),
    const UserModel(employeeId: "126", username: "nicole", password: "123qwe", authLevel: 5)
  ];
}