// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  const Exercise({
    this.duration = 0,
    this.name = '',
    this.previewDescription = const [],
    this.previewImageUrl = '',
    this.previewUrl = '',
    this.type = '',
    this.videoUrl = '',
  });

  factory Exercise.fromJson(String data) =>
      Exercise.fromMap(json.decode(data) as Map<String, dynamic>);

  factory Exercise.fromMap(Map<String, dynamic> data) => Exercise(
        duration: data['duration'] as int? ?? 0,
        name: data['name'] as String? ?? '',
        previewDescription: (data['preview_description'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        previewImageUrl: data['preview_image_url'] as String? ?? '',
        previewUrl: data['preview_url'] as String? ?? '',
        type: data['type'] as String? ?? '',
        videoUrl: data['video_url'] as String? ?? '',
      );

  static List<Exercise> fromString(String data) =>
      (json.decode(data) as List<dynamic>)
          .map((e) => Exercise.fromMap(e as Map<String, dynamic>))
          .toList();

  static String toStringList(List<Exercise> exercises, int start, int end) {
    return json.encode(
      exercises.sublist(start, end).map((e) => e.toMap).toList(),
    );
  }

  static String toFullString(List<Exercise> exercises) =>
      json.encode(exercises.map((e) => e.toMap).toList());

  Map<String, dynamic> get toMap => {
        'duration': duration,
        'name': name,
        'preview_description': previewDescription,
        'preview_image_url': previewImageUrl,
        'preview_url': previewUrl,
        'type': type,
        'video_url': videoUrl,
      };

  String get toJson => json.encode(toMap);

  //Convert a string into a list of exercise.

  final int duration;
  final String name;
  final List<String> previewDescription;
  final String previewImageUrl;
  final String previewUrl;
  final String type;
  final String videoUrl;

  @override
  List<Object> get props => [
        duration,
        name,
        previewDescription,
        previewImageUrl,
        previewUrl,
        type,
        videoUrl,
      ];

  Exercise copyWith({
    int? duration,
    String? name,
    List<String>? previewDescription,
    String? previewImageUrl,
    String? previewUrl,
    String? type,
    String? videoUrl,
  }) {
    return Exercise(
      duration: duration ?? this.duration,
      name: name ?? this.name,
      previewDescription: previewDescription ?? this.previewDescription,
      previewImageUrl: previewImageUrl ?? this.previewImageUrl,
      previewUrl: previewUrl ?? this.previewUrl,
      type: type ?? this.type,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }

  @override
  String toString() =>
      'Exercise(duration: $duration, name: $name, previewDescription: $previewDescription, previewImageUrl: $previewImageUrl, previewUrl: $previewUrl, type: $type, videoUrl: $videoUrl)';
}
