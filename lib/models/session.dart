import 'dart:convert';

import 'package:equatable/equatable.dart';

class Session extends Equatable {
  const Session({this.authToken = '', this.refreshToken = ''});

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Session.fromMap(Map<String, dynamic> map) => Session(
        authToken: (map['auth_token'] as String?) ?? '',
        refreshToken: (map['refresh_token'] as String?) ?? '',
      );

  final String authToken;
  final String refreshToken;

  Map<String, dynamic> get toMap => {
        'auth_token': authToken,
        'refresh_token': refreshToken,
      };

  String get toJson => json.encode(toMap);

  @override
  List<Object> get props => [authToken, refreshToken];

  Session copyWith({String? authToken, String? refreshToken}) => Session(
        authToken: authToken ?? this.authToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );

  @override
  String toString() =>
      'Session(authToken: $authToken, refreshToken: $refreshToken)';
}
