// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateWeeklyPlanRequest _$CreateWeeklyPlanRequestFromJson(
        Map<String, dynamic> json) =>
    CreateWeeklyPlanRequest(
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CreateWeeklyPlanRequestToJson(
        CreateWeeklyPlanRequest instance) =>
    <String, dynamic>{
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'name': instance.name,
    };

UpdateWeeklyPlanRequest _$UpdateWeeklyPlanRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateWeeklyPlanRequest(
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UpdateWeeklyPlanRequestToJson(
        UpdateWeeklyPlanRequest instance) =>
    <String, dynamic>{
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'name': instance.name,
    };

_$WeeklyPlanModelImpl _$$WeeklyPlanModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WeeklyPlanModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      weekStartDate: DateTime.parse(json['weekStartDate'] as String),
      assignments: (json['mealPlans'] as List<dynamic>)
          .map((e) => MealAssignment.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$WeeklyPlanModelImplToJson(
        _$WeeklyPlanModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'weekStartDate': instance.weekStartDate.toIso8601String(),
      'mealPlans': instance.assignments,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$MealAssignmentImpl _$$MealAssignmentImplFromJson(Map<String, dynamic> json) =>
    _$MealAssignmentImpl(
      id: json['id'] as String,
      mealId: json['mealId'] as String,
      meal: MealModel.fromJson(json['meal'] as Map<String, dynamic>),
      day: json['day'] as String,
      type: $enumDecode(_$MealTypeEnumMap, json['type']),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$MealAssignmentImplToJson(
        _$MealAssignmentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mealId': instance.mealId,
      'meal': instance.meal,
      'day': instance.day,
      'type': _$MealTypeEnumMap[instance.type]!,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$MealTypeEnumMap = {
  MealType.breakfast: 'breakfast',
  MealType.lunch: 'lunch',
  MealType.dinner: 'dinner',
};
