// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:rhea_app/models/sleep_question.dart';
import 'package:rhea_app/models/video_section.dart';

//convert WorkSession to

class WorkSession extends Equatable {
  const WorkSession({
    this.id = '',
    this.brief = '',
    this.completedTime = '',
    this.created = 0,
    this.description = '',
    this.duration = 0,
    this.feeling = '',
    this.motivationalText = '',
    this.name = '',
    this.no = 0,
    this.sessionType = '',
    this.sleepQuestions = const <SleepQuestion>[],
    this.equipments = const <String>[],
    this.targetHeartRate = 0,
    this.totalDuration = 0,
    this.userId = '',
    this.videoSections = const <VideoSection>[],
  });

  factory WorkSession.fromJson(String data) =>
      WorkSession.fromMap(json.decode(data) as Map<String, dynamic>);

  factory WorkSession.fromMap(Map<String, dynamic> data) => WorkSession(
        id: data['id'] as String? ?? '',
        brief: data['brief'] as String? ?? '',
        completedTime: data['completed_time'] as String? ?? '',
        created: data['created'] as int? ?? 0,
        description: data['description'] as String? ?? '',
        duration: data['duration'] as int? ?? 0,
        feeling: data['feeling'] as String? ?? '',
        motivationalText: data['motivational_text'] as String? ?? '',
        name: data['name'] as String? ?? '',
        no: data['no'] as int? ?? 0,
        sessionType: data['session_type'] as String? ?? '',
        sleepQuestions: (data['sleep_questions'] as List<dynamic>?)
                ?.map((e) => SleepQuestion.fromMap(e as Map<String, dynamic>))
                .toList() ??
            const [],
        equipments: (data['equipment'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        targetHeartRate: data['target_heart_rate'] as int? ?? 0,
        totalDuration: data['total_duration'] as int? ?? 0,
        userId: data['user_id'] as String? ?? '',
        videoSections: (data['video_sections'] as List<dynamic>?)
                ?.map((e) => VideoSection.fromMap(e as Map<String, dynamic>))
                .toList() ??
            const [],
      );

  Map<String, dynamic> get toMap => {
        'id': id,
        'brief': brief,
        'completed_time': completedTime,
        'created': created,
        'description': description,
        'duration': duration,
        'feeling': feeling,
        'motivational_text': motivationalText,
        'name': name,
        'no': no,
        'session_type': sessionType,
        'sleep_questions': sleepQuestions.map((e) => e.toMap).toList(),
        'equipment': equipments,
        'target_heart_rate': targetHeartRate,
        'total_duration': totalDuration,
        'user_id': userId,
        'video_sections': videoSections.map((e) => e.toMap).toList(),
      };

  String get toJson => json.encode(toMap);

  final String id;
  final String brief;
  final String completedTime;
  final int created;
  final String description;
  final int duration;
  final String feeling;
  final String motivationalText;
  final String name;
  final int no;
  final String sessionType;
  final List<String> equipments;
  final List<SleepQuestion> sleepQuestions;
  final int targetHeartRate;
  final int totalDuration;
  final String userId;
  final List<VideoSection> videoSections;

  @override
  List<Object> get props => [
        id,
        brief,
        completedTime,
        created,
        description,
        duration,
        feeling,
        motivationalText,
        name,
        no,
        sessionType,
        sleepQuestions,
        equipments,
        targetHeartRate,
        totalDuration,
        userId,
        videoSections,
      ];

  WorkSession copyWith({
    String? id,
    String? brief,
    String? completedTime,
    int? created,
    String? description,
    int? duration,
    String? feeling,
    String? motivationalText,
    String? name,
    int? no,
    String? sessionType,
    List<String>? equipments,
    List<SleepQuestion>? sleepQuestions,
    int? targetHeartRate,
    int? totalDuration,
    String? userId,
    List<VideoSection>? videoSections,
  }) {
    return WorkSession(
      id: id ?? this.id,
      brief: brief ?? this.brief,
      completedTime: completedTime ?? this.completedTime,
      created: created ?? this.created,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      feeling: feeling ?? this.feeling,
      motivationalText: motivationalText ?? this.motivationalText,
      name: name ?? this.name,
      no: no ?? this.no,
      sessionType: sessionType ?? this.sessionType,
      equipments: equipments ?? this.equipments,
      sleepQuestions: sleepQuestions ?? this.sleepQuestions,
      targetHeartRate: targetHeartRate ?? this.targetHeartRate,
      totalDuration: totalDuration ?? this.totalDuration,
      userId: userId ?? this.userId,
      videoSections: videoSections ?? this.videoSections,
    );
  }

  @override
  String toString() {
    return 'WorkSession(id: $id, brief: $brief, completedTime: $completedTime, created: $created, description: $description, duration: $duration, feeling: $feeling, motivationalText: $motivationalText, name: $name, no: $no, sessionType: $sessionType, equipments: $equipments, sleepQuestions: $sleepQuestions, targetHeartRate: $targetHeartRate, totalDuration: $totalDuration, userId: $userId, videoSections: $videoSections)';
  }
}
