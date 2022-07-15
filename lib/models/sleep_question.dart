import 'dart:convert';

import 'package:equatable/equatable.dart';

class SleepQuestion extends Equatable {
  const SleepQuestion({
    this.id = '',
    this.title = '',
    this.subtitle = '',
  });

  factory SleepQuestion.fromJson(String source) =>
      SleepQuestion.fromMap(json.decode(source) as Map<String, dynamic>);

  factory SleepQuestion.fromMap(Map<String, dynamic> map) => SleepQuestion(
        id: map['id'] as String? ?? '',
        title: map['title'] as String? ?? '',
        subtitle: map['subtitle'] as String? ?? '',
      );

  final String id;
  final String title;
  final String subtitle;

  Map<String, dynamic> get toMap => {
        'id': id,
        'title': title,
        'subtitle': subtitle,
      };

  String get toJson => json.encode(toMap);

  @override
  List<Object> get props => [id, title, subtitle];

  SleepQuestion copyWith({String? id, String? title, String? subtitle}) =>
      SleepQuestion(
        id: id ?? this.id,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
      );

  @override
  String toString() =>
      'SleepQuestion(id: $id, title: $title, subtitle: $subtitle)';
}
