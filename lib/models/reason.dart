import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:rhea_app/extensions/reason_type_extension.dart';
import 'package:rhea_app/models/enums/reason_type.dart';

class Reason extends Equatable {
  const Reason({this.reason = ReasonType.retrylLater});
  factory Reason.fromJson(String source) =>
      Reason.fromMap(json.decode(source) as Map<String, String>);

  factory Reason.fromMap(Map<String, String> map) {
    return Reason(
      reason: toReasonTypeEnum(map['reason'].toString()),
    );
  }

  final ReasonType reason;

  @override
  List<Object?> get props => [reason];

  Map<String, dynamic> get toMap => {
        'reason': reason.value,
      };

  String get toJson => json.encode(toMap);

  Reason copyWith({ReasonType? reason}) => Reason(
        reason: reason ?? this.reason,
      );

  @override
  String toString() => 'Reason(reason: $reason)';
}
