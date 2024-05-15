class PlayerModel{
  final String firstName;
  final String lastName;
  const PlayerModel({required this.firstName, required this.lastName});

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String
      );
  }
}