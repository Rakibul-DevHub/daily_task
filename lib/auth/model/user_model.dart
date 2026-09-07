class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? profileImageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id']?.toString() ??
          json['_userId']?.toString() ??
          json['profileId']?.toString() ??
          '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      profileImageUrl: json['profileImage'] != null
          ? json['profileImage']['imageUrl']
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'role': role,
      'profileImage': profileImageUrl != null ? {'imageUrl': profileImageUrl} : null,
    };
  }
}