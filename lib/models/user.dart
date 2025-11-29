enum UserType {
  student,
  driver,
}

class User {
  final String id;
  final String name;
  final String email;
  final UserType userType;
  final String? phoneNumber;
  final String? profileImageUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
    this.phoneNumber,
    this.profileImageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      userType: UserType.values.firstWhere(
        (e) => e.toString() == 'UserType.${json['userType']}',
      ),
      phoneNumber: json['phoneNumber'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'userType': userType.toString().split('.').last,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
    };
  }
}

