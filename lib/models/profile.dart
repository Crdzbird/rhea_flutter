// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  const Profile({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.trialStatus = '',
    this.birthday = 0,
  });
  factory Profile.fromMap(Map<String, dynamic> map) => Profile(
        id: (map['id'] as String?) ?? '',
        firstName: (map['first_name'] as String?) ?? '',
        lastName: (map['last_name'] as String?) ?? '',
        email: (map['email'] as String?) ?? '',
        trialStatus: (map['trial_status'] as String?) ?? '',
        birthday: (map['birthday'] as int?) ?? 0,
      );

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String trialStatus;
  final int birthday;

  Map<String, dynamic> get toMap => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'trial_status': trialStatus,
        'birthday': birthday,
      };

  String get toJson => json.encode(toMap);

  @override
  String toString() =>
      'Profile(id: $id, firstName: $firstName, lastName: $lastName, email: $email, trialStatus: $trialStatus, birthday: $birthday)';

  Profile copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? trialStatus,
    int? birthday,
  }) {
    return Profile(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      trialStatus: trialStatus ?? this.trialStatus,
      birthday: birthday ?? this.birthday,
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        trialStatus,
        birthday,
      ];
}
