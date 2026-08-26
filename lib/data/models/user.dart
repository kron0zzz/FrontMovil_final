class User {
  final int userId;
  final String userEmail;
  final String userName;

  User({required this.userId, required this.userEmail, required this.userName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] ?? json['userId'] ?? 0,
      userEmail: json['user_email'] ?? json['userEmail'] ?? '',
      userName: json['user_name'] ?? json['userName'] ?? '',
    );
  }
}
