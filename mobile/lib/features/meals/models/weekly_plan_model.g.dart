// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealAssignment _$MealAssignmentFromJson(Map<String, dynamic> json) =>
    MealAssignment(
      id: json['id'] as String,
      weeklyPlanId: json['weeklyPlanId'] as String,
      mealId: json['mealId'] as String,
      dayOfWeek: (json['dayOfWeek'] as num).toInt(),
      mealType: json['mealType'] as String,
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$MealAssignmentToJson(MealAssignment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weeklyPlanId': instance.weeklyPlanId,
      'mealId': instance.mealId,
      'dayOfWeek': instance.dayOfWeek,
      'mealType': instance.mealType,
      'note': instance.note,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$WeeklyPlanImpl _$$WeeklyPlanImplFromJson(Map<String, dynamic> json) =>
    _$WeeklyPlanImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      assignments: (json['assignments'] as List<dynamic>)
          .map((e) => MealAssignment.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$WeeklyPlanImplToJson(_$WeeklyPlanImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'assignments': instance.assignments,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$CreateWeeklyPlanRequestImpl _$$CreateWeeklyPlanRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateWeeklyPlanRequestImpl(
      userId: json['userId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$$CreateWeeklyPlanRequestImplToJson(
        _$CreateWeeklyPlanRequestImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };

_$UpdateWeeklyPlanRequestImpl _$$UpdateWeeklyPlanRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateWeeklyPlanRequestImpl(
      id: json['id'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$$UpdateWeeklyPlanRequestImplToJson(
        _$UpdateWeeklyPlanRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };
