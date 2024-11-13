// lib/database/user.dart

class User {
  final int? id;
  final String username;
  final String password;

  User({this.id, required this.username, required this.password});

  // Преобразование из Map в объект User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
    );
  }

  // Преобразование из объекта User в Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }
}
