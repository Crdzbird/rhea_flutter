import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:rhea_app/models/exercise.dart';

class VideoSection extends Equatable {
  const VideoSection({
    this.detail = '',
    this.exercises = const <Exercise>[],
    this.name = '',
  });

  factory VideoSection.fromJson(String source) =>
      VideoSection.fromMap(json.decode(source) as Map<String, dynamic>);

  factory VideoSection.fromMap(Map<String, dynamic> map) => VideoSection(
        detail: map['detail'] as String? ?? '',
        exercises: (map['exercises'] as List<dynamic>?)
                ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
                .toList() ??
            const [],
        name: map['name'] as String? ?? '',
      );

  final String detail;
  final List<Exercise> exercises;
  final String name;

  Map<String, dynamic> get toMap => {
        'detail': detail,
        'exercises': exercises.map((e) => e.toMap).toList(),
        'name': name,
      };

  String get toJson => json.encode(toMap);

  @override
  List<Object> get props => [detail, exercises, name];

  VideoSection copyWith({
    String? detail,
    List<Exercise>? exercises,
    String? name,
  }) =>
      VideoSection(
        detail: detail ?? this.detail,
        exercises: exercises ?? this.exercises,
        name: name ?? this.name,
      );

  @override
  String toString() =>
      'VideoSection(detail: $detail, exercises: $exercises, name: $name)';
}
