// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:equatable/equatable.dart';

class Plan extends Equatable {
  const Plan({
    this.id = '',
    this.created = 0,
    this.userId = '',
    this.planCategory = '',
    this.previousStages = const <String>[],
    this.currentStage = '',
    this.nextStages = const <String>[],
    this.injuryDate = '',
    this.startDate = '',
    this.lastStageChangeDate = '',
    this.lastSessionChangeDate = '',
    this.exerciseActivity = const <String, String>{},
  });

  factory Plan.fromMap(Map<String, dynamic> data) => Plan(
        id: data['id'] as String? ?? '',
        created: data['created'] as int? ?? 0,
        userId: data['user_id'] as String? ?? '',
        planCategory: data['plan_category'] as String? ?? '',
        previousStages: (data['previous_stages'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const <String>[],
        currentStage: data['current_stage'] as String? ?? '',
        nextStages: (data['next_stages'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const <String>[],
        injuryDate: data['injury_date'] as String? ?? '',
        startDate: data['start_date'] as String? ?? '',
        lastStageChangeDate: data['last_stage_change_date'] as String? ?? '',
        lastSessionChangeDate:
            data['last_session_change_date'] as String? ?? '',
        exerciseActivity:
            data['exercise_activity'] as dynamic ?? const <String, String>{},
      );

  factory Plan.fromJson(String data) =>
      Plan.fromMap(json.decode(data) as Map<String, dynamic>);

  final String id;
  final int created;
  final String userId;
  final String planCategory;
  final List<String> previousStages;
  final String currentStage;
  final List<String> nextStages;
  final String injuryDate;
  final String startDate;
  final String lastStageChangeDate;
  final String lastSessionChangeDate;
  final dynamic exerciseActivity;

  Map<String, dynamic> toMap() => {
        'id': id,
        'created': created,
        'user_id': userId,
        'plan_category': planCategory,
        'previous_stages': previousStages,
        'current_stage': currentStage,
        'next_stages': nextStages,
        'injury_date': injuryDate,
        'start_date': startDate,
        'last_stage_change_date': lastStageChangeDate,
        'last_session_change_date': lastSessionChangeDate,
        'exercise_activity': exerciseActivity,
      };

  String get toJson => json.encode(toMap());

  Plan copyWith({
    String? id,
    int? created,
    String? userId,
    String? planCategory,
    List<String>? previousStages,
    String? currentStage,
    List<String>? nextStages,
    String? injuryDate,
    String? startDate,
    String? lastStageChangeDate,
    String? lastSessionChangeDate,
    dynamic exerciseActivity,
  }) =>
      Plan(
        id: id ?? this.id,
        created: created ?? this.created,
        userId: userId ?? this.userId,
        planCategory: planCategory ?? this.planCategory,
        previousStages: previousStages ?? this.previousStages,
        currentStage: currentStage ?? this.currentStage,
        nextStages: nextStages ?? this.nextStages,
        injuryDate: injuryDate ?? this.injuryDate,
        startDate: startDate ?? this.startDate,
        lastStageChangeDate: lastStageChangeDate ?? this.lastStageChangeDate,
        lastSessionChangeDate:
            lastSessionChangeDate ?? this.lastSessionChangeDate,
        exerciseActivity: exerciseActivity ?? this.exerciseActivity,
      );

  @override
  List<Object?> get props {
    return [
      id,
      created,
      userId,
      planCategory,
      previousStages,
      currentStage,
      nextStages,
      injuryDate,
      startDate,
      lastStageChangeDate,
      lastSessionChangeDate,
      exerciseActivity,
    ];
  }

  @override
  String toString() =>
      'Plan(id: $id, created: $created, userId: $userId, planCategory: $planCategory, previousStages: $previousStages, currentStage: $currentStage, nextStages: $nextStages, injuryDate: $injuryDate, startDate: $startDate, lastStageChangeDate: $lastStageChangeDate, lastSessionChangeDate: $lastSessionChangeDate, exerciseActivity: $exerciseActivity)';
}
