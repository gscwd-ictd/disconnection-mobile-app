class UserModel{
  final String employeeId;
  final String username;
  final String password;
  final String? name;
  final int authLevel;
  const UserModel({required this.employeeId, required this.username, required this.password, this.name, required this.authLevel});
}