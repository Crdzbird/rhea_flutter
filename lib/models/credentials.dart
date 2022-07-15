import 'dart:convert';

import 'package:equatable/equatable.dart';

class Credentials extends Equatable {
  const Credentials({this.email = '', this.password = ''});
  factory Credentials.fromJson(String source) =>
      Credentials.fromMap(json.decode(source) as Map<String, String>);

  factory Credentials.fromMap(Map<String, String> map) {
    return Credentials(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];

  Map<String, dynamic> get toMap => {
        'email': email,
        'password': password,
      };

  String get toJson => json.encode(toMap);

  Credentials copyWith({String? email, String? password}) => Credentials(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  String toString() => 'Credentials(email: $email, password: $password)';
}
