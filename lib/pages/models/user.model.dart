import 'dart:convert';

class User {
  String user;
  String password;
  String description;
  List modelData;

  User({
    this.user,
    this.password,
    this.description,
    this.modelData,
  });

  static User fromMap(Map<String, dynamic> user) {
    return new User(
      user: user['user'],
      password: user['password'],
      description: user['description'],
      modelData: jsonDecode(user['model_data']),
    );
  }

  toMap() {
    return {
      'user': user,
      'password': password,
      'description': description,
      'model_data': jsonEncode(modelData),
    };
  }
}
