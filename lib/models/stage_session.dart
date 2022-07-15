// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:rhea_app/extensions/category_type_extension.dart';
import 'package:rhea_app/extensions/feeling_type_extension.dart';

import 'package:rhea_app/models/enums/category_type.dart';
import 'package:rhea_app/models/enums/feelings_type.dart';
import 'package:rhea_app/models/sleep_question.dart';

class StageSession extends Equatable {
  const StageSession({
    this.id = '',
    this.additionalBreathworkSession = '',
    this.completedAdditionalBreathworkSession = '',
    this.isCompleted = false,
    this.isPending = false,
    this.isActive = false,
    this.completionDate = '',
    this.updateDate = 0,
    this.categoryType = CategoryType.base,
    this.feelingsType = FeelingsType.positive,
    this.recommendedTime = '',
    this.session = '',
    this.equipments = const <String>[],
    this.sleepQuestions = const <SleepQuestion>[],
  });

  factory StageSession.fromJson(String data) =>
      StageSession.fromMap(json.decode(data) as Map<String, dynamic>);

  factory StageSession.fromMap(Map<String, dynamic> data) => StageSession(
        id: data['id'] as String? ?? '',
        additionalBreathworkSession:
            data['additional_breathwork_session'] as String? ?? '',
        completedAdditionalBreathworkSession:
            data['completed_additional_breathwork_session'] as String? ?? '',
        isCompleted: data['is_completed'] as bool? ?? false,
        isPending: data['is_pending'] as bool? ?? false,
        isActive: data['is_active'] as bool? ?? false,
        completionDate: data['completion_date'] as String? ?? '',
        updateDate: data['update_date'] as int? ?? 0,
        categoryType: toCategoryEnum(data['category_type'] as String? ?? ''),
        feelingsType: toFeelingEnum(data['feelings_type'] as String? ?? ''),
        recommendedTime: data['recommended_time'] as String? ?? '',
        session: data['session'] as String? ?? '',
        equipments: (data['equipments'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        sleepQuestions: (data['sleep_questions'] as List<dynamic>?)
                ?.map((e) => SleepQuestion.fromMap(e as Map<String, dynamic>))
                .toList() ??
            const [],
      );

  Map<String, dynamic> get toMap => {
        'id': id,
        'additional_breathwork_session': additionalBreathworkSession,
        'completed_additional_breathwork_session':
            completedAdditionalBreathworkSession,
        'is_completed': isCompleted,
        'is_pending': isPending,
        'is_active': isActive,
        'completion_date': completionDate,
        'update_date': updateDate,
        'category_type': categoryType.toString(),
        'feelings_type': feelingsType.toString(),
        'recommended_time': recommendedTime,
        'session': session,
        'equipments': equipments,
        'sleep_questions': sleepQuestions,
      };

  String get toJson => json.encode(toMap);

  final String id;
  final String additionalBreathworkSession;
  final String completedAdditionalBreathworkSession;
  final bool isCompleted;
  final bool isPending;
  final bool isActive;
  final String completionDate;
  final int updateDate;
  final CategoryType categoryType;
  final FeelingsType feelingsType;
  final String recommendedTime;
  final String session;
  final List<String> equipments;
  final List<SleepQuestion> sleepQuestions;

  @override
  List<Object> get props => [
        id,
        additionalBreathworkSession,
        completedAdditionalBreathworkSession,
        isCompleted,
        isPending,
        isActive,
        completionDate,
        updateDate,
        categoryType,
        feelingsType,
        recommendedTime,
        session,
        equipments,
        sleepQuestions,
      ];

  StageSession copyWith({
    String? id,
    String? additionalBreathworkSession,
    String? completedAdditionalBreathworkSession,
    bool? isCompleted,
    bool? isPending,
    bool? isActive,
    String? completionDate,
    int? updateDate,
    CategoryType? categoryType,
    FeelingsType? feelingsType,
    String? recommendedTime,
    String? session,
    List<String>? equipments,
    List<SleepQuestion>? sleepQuestions,
  }) {
    return StageSession(
      id: id ?? this.id,
      additionalBreathworkSession:
          additionalBreathworkSession ?? this.additionalBreathworkSession,
      completedAdditionalBreathworkSession:
          completedAdditionalBreathworkSession ??
              this.completedAdditionalBreathworkSession,
      isCompleted: isCompleted ?? this.isCompleted,
      isPending: isPending ?? this.isPending,
      isActive: isActive ?? this.isActive,
      completionDate: completionDate ?? this.completionDate,
      updateDate: updateDate ?? this.updateDate,
      categoryType: categoryType ?? this.categoryType,
      feelingsType: feelingsType ?? this.feelingsType,
      recommendedTime: recommendedTime ?? this.recommendedTime,
      session: session ?? this.session,
      equipments: equipments ?? this.equipments,
      sleepQuestions: sleepQuestions ?? this.sleepQuestions,
    );
  }

  @override
  String toString() {
    return 'StageSession(id: $id, additionalBreathworkSession: $additionalBreathworkSession, completedAdditionalBreathworkSession: $completedAdditionalBreathworkSession, isCompleted: $isCompleted, isPending: $isPending, isActive: $isActive, completionDate: $completionDate, updateDate: $updateDate, categoryType: $categoryType, feelingsType: $feelingsType, recommendedTime: $recommendedTime, session: $session, equipments: $equipments, sleepQuestions: $sleepQuestions)';
  }
}
