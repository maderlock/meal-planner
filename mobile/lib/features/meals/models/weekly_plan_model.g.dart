// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeeklyPlanModelImpl _$$WeeklyPlanModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WeeklyPlanModelImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      weekStartDate: DateTime.parse(json['week_start_date'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      mealPlans: (json['meal_plans'] as List<dynamic>?)
              ?.map((e) => MealPlanItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$WeeklyPlanModelImplToJson(
        _$WeeklyPlanModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'week_start_date': instance.weekStartDate.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'meal_plans': instance.mealPlans,
    };

_$MealPlanItemImpl _$$MealPlanItemImplFromJson(Map<String, dynamic> json) =>
    _$MealPlanItemImpl(
      id: json['id'] as String,
      weeklyPlanId: json['weekly_plan_id'] as String,
      mealId: json['meal_id'] as String,
      dayOfWeek: (json['day_of_week'] as num).toInt(),
      mealType: json['meal_type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      meal: MealModel.fromJson(json['meal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MealPlanItemImplToJson(_$MealPlanItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weekly_plan_id': instance.weeklyPlanId,
      'meal_id': instance.mealId,
      'day_of_week': instance.dayOfWeek,
      'meal_type': instance.mealType,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'meal': instance.meal,
    };
