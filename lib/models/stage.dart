// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:rhea_app/models/stage_session.dart';

class Stage extends Equatable {
  const Stage({
    this.id = '',
    this.created = 0,
    this.userId = '',
    this.stageCategory = '',
    this.types = const <String, String>{},
    this.headerImageUrl = '',
    this.name = '',
    this.averageDuration = '',
    this.equipment = const <String>[],
    this.previousSessions = const <String>[],
    this.currentSession = '',
    this.additionalBreathworkSession = '',
    this.completedAdditionalBreathworkSessions = const <String>[],
    this.nextSessions = const <String>[],
    this.motivationalText = '',
    this.closingMotivationalText = '',
  });

  factory Stage.fromMap(Map<String, dynamic> data) => Stage(
        id: data['id'] as String? ?? '',
        created: data['created'] as int? ?? 0,
        userId: data['user_id'] as String? ?? '',
        stageCategory: data['stage_category'] as String? ?? '',
        types: data['types'] as dynamic ?? const <String, String>{},
        headerImageUrl: data['header_image_url'] as String? ?? '',
        name: data['name'] as String? ?? '',
        averageDuration: data['average_duration'] as String? ?? '',
        equipment: (data['equipment'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const <String>[],
        previousSessions: (data['previous_sessions'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const <String>[],
        currentSession: data['current_session'] as String? ?? '',
        additionalBreathworkSession:
            data['additional_breathwork_session'] as String? ?? '',
        completedAdditionalBreathworkSessions:
            (data['completed_additional_breathwork_sessions'] as List<dynamic>?)
                    ?.map((e) => e as String)
                    .toList() ??
                const <String>[],
        nextSessions: (data['next_sessions'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const <String>[],
        motivationalText: data['motivational_text'] as String? ?? '',
        closingMotivationalText:
            data['closing_motivational_text'] as String? ?? '',
      );

  factory Stage.fromJson(String data) =>
      Stage.fromMap(json.decode(data) as Map<String, dynamic>);

  final String id;
  final int created;
  final String userId;
  final String stageCategory;
  final dynamic types;
  final String headerImageUrl;
  final String name;
  final String averageDuration;
  final List<String> equipment;
  final List<String> previousSessions;
  final String currentSession;
  final String additionalBreathworkSession;
  final List<String> completedAdditionalBreathworkSessions;
  final List<String> nextSessions;
  final String motivationalText;
  final String closingMotivationalText;

  Map<String, dynamic> toMap() => {
        'id': id,
        'created': created,
        'user_id': userId,
        'stage_category': stageCategory,
        'types': types,
        'header_image_url': headerImageUrl,
        'name': name,
        'average_duration': averageDuration,
        'equipment': equipment,
        'previous_sessions': previousSessions,
        'current_session': currentSession,
        'additional_breathwork_session': additionalBreathworkSession,
        'completed_additional_breathwork_sessions':
            completedAdditionalBreathworkSessions,
        'next_sessions': nextSessions,
        'motivational_text': motivationalText,
        'closing_motivational_text': closingMotivationalText,
      };

  String get toJson => json.encode(toMap());

  Stage copyWith({
    String? id,
    int? created,
    String? userId,
    String? stageCategory,
    dynamic types,
    String? headerImageUrl,
    String? name,
    String? averageDuration,
    List<String>? equipment,
    List<String>? previousSessions,
    String? currentSession,
    String? additionalBreathworkSession,
    List<String>? completedAdditionalBreathworkSessions,
    List<String>? nextSessions,
    String? motivationalText,
    String? closingMotivationalText,
  }) =>
      Stage(
        id: id ?? this.id,
        created: created ?? this.created,
        userId: userId ?? this.userId,
        stageCategory: stageCategory ?? this.stageCategory,
        types: types ?? this.types,
        headerImageUrl: headerImageUrl ?? this.headerImageUrl,
        name: name ?? this.name,
        averageDuration: averageDuration ?? this.averageDuration,
        equipment: equipment ?? this.equipment,
        previousSessions: previousSessions ?? this.previousSessions,
        currentSession: currentSession ?? this.currentSession,
        additionalBreathworkSession:
            additionalBreathworkSession ?? this.additionalBreathworkSession,
        completedAdditionalBreathworkSessions:
            completedAdditionalBreathworkSessions ??
                this.completedAdditionalBreathworkSessions,
        nextSessions: nextSessions ?? this.nextSessions,
        motivationalText: motivationalText ?? this.motivationalText,
        closingMotivationalText:
            closingMotivationalText ?? this.closingMotivationalText,
      );

  @override
  List<Object?> get props {
    return [
      id,
      created,
      userId,
      stageCategory,
      types,
      headerImageUrl,
      name,
      averageDuration,
      equipment,
      previousSessions,
      currentSession,
      additionalBreathworkSession,
      completedAdditionalBreathworkSessions,
      nextSessions,
      motivationalText,
      closingMotivationalText,
    ];
  }

  List<StageSession> get allSessions => <StageSession>[
        ...previousSessions.map(
          (sessionId) => StageSession(
            isCompleted: true,
            additionalBreathworkSession: additionalBreathworkSession,
            updateDate: created,
            recommendedTime: averageDuration,
            session: sessionId,
          ),
        ),
        StageSession(
          additionalBreathworkSession: additionalBreathworkSession,
          isPending: true,
          isActive: true,
          updateDate: created,
          recommendedTime: averageDuration,
          session: currentSession,
        ),
        ...nextSessions.map(
          (sessionId) => StageSession(
            additionalBreathworkSession: additionalBreathworkSession,
            isPending: true,
            updateDate: created,
            recommendedTime: averageDuration,
            session: sessionId,
          ),
        ),
      ];

  @override
  String toString() =>
      'Stage(id: $id, created: $created, userId: $userId, stageCategory: $stageCategory, types: $types, headerImageUrl: $headerImageUrl, name: $name, averageDuration: $averageDuration, equipment: $equipment, previousSessions: $previousSessions, currentSession: $currentSession, additionalBreathworkSession: $additionalBreathworkSession, completedAdditionalBreathworkSessions: $completedAdditionalBreathworkSessions, nextSessions: $nextSessions, motivationalText: $motivationalText, closingMotivationalText: $closingMotivationalText)';
}
