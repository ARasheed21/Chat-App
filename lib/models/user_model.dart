class UserModel {
  final String id; // email
  final String username;
  final String? photoUrl;

  UserModel({
    required this.id,
    required this.username,
    this.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['userId'],
      username: json['username'],
      photoUrl: json['photoUrl'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'username': username,
      'photoUrl': photoUrl,
    };
  }
}