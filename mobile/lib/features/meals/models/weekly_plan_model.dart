/// Model class representing a weekly meal plan.
/// 
/// This file defines the structure for weekly meal plans and meal assignments.
/// A weekly plan contains a list of meal assignments, where each assignment
/// connects a meal to a specific day and meal type (e.g., breakfast, lunch, dinner).

import 'package:freezed_annotation/freezed_annotation.dart';
import 'meal_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weekly_plan_model.freezed.dart';
part 'weekly_plan_model.g.dart';

enum MealType {
  @JsonValue('breakfast')
  breakfast,
  @JsonValue('lunch')
  lunch,
  @JsonValue('dinner')
  dinner,
}

@freezed
class WeeklyPlanModel with _$WeeklyPlanModel {
  const factory WeeklyPlanModel({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'userId') required String userId,
    @JsonKey(name: 'weekStartDate') required DateTime weekStartDate,
    @JsonKey(name: 'mealPlans') required List<MealAssignment> assignments,
    @JsonKey(name: 'createdAt') required DateTime createdAt,
    @JsonKey(name: 'updatedAt') required DateTime updatedAt,
  }) = _WeeklyPlanModel;

  factory WeeklyPlanModel.fromJson(Map<String, dynamic> json) =>
      _$WeeklyPlanModelFromJson(json);
}

@freezed
class MealAssignment with _$MealAssignment {
  const factory MealAssignment({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'mealId') required String mealId,
    @JsonKey(name: 'meal') required MealModel meal,
    @JsonKey(name: 'day') required String day,
    @JsonKey(name: 'mealType') required MealType type,
    @JsonKey(name: 'notes') String? notes,
  }) = _MealAssignment;

  factory MealAssignment.fromJson(Map<String, dynamic> json) =>
      _$MealAssignmentFromJson(json);
}

/// Request model for creating a new weekly plan.
@JsonSerializable()
class CreateWeeklyPlanRequest {
  @JsonKey(name: 'startDate')
  final DateTime startDate;
  
  @JsonKey(name: 'endDate')
  final DateTime endDate;
  
  @JsonKey(name: 'name')
  final String? name;

  CreateWeeklyPlanRequest({
    required this.startDate,
    required this.endDate,
    this.name,
  });

  factory CreateWeeklyPlanRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateWeeklyPlanRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateWeeklyPlanRequestToJson(this);
}

/// Request model for updating an existing weekly plan.
/// All fields are optional since this is a PATCH operation.
@JsonSerializable()
class UpdateWeeklyPlanRequest {
  @JsonKey(name: 'startDate')
  final DateTime? startDate;
  
  @JsonKey(name: 'endDate')
  final DateTime? endDate;
  
  @JsonKey(name: 'name')
  final String? name;

  UpdateWeeklyPlanRequest({
    this.startDate,
    this.endDate,
    this.name,
  });

  factory UpdateWeeklyPlanRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateWeeklyPlanRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateWeeklyPlanRequestToJson(this);
}
