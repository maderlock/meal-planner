/// Model class representing a weekly meal plan.
///
/// This file defines the structure for weekly meal plans and meal assignments.
/// A weekly plan contains a list of meal assignments, where each assignment
/// connects a meal to a specific day and meal type (e.g., breakfast, lunch, dinner).

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/date_utils.dart';
import 'meal_model.dart';

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
  /// Creates a new weekly plan model.
  /// The [weekStartDate] must be a Monday at 00:00:00.
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
    @JsonKey(name: 'type') required MealType type,
    @JsonKey(name: 'notes') String? notes,
    @JsonKey(name: 'createdAt') required DateTime createdAt,
    @JsonKey(name: 'updatedAt') required DateTime updatedAt,
  }) = _MealAssignment;

  factory MealAssignment.fromJson(Map<String, dynamic> json) =>
      _$MealAssignmentFromJson(json);
}

/// Request model for creating a new weekly plan.
@JsonSerializable()
class CreateWeeklyPlanRequest {
  CreateWeeklyPlanRequest({
    required this.startDate,
    required this.endDate,
    this.name,
  });

  /// Creates a request for a weekly plan starting from the given date.
  /// The date will be adjusted to the start of its week (Monday at 00:00:00).
  factory CreateWeeklyPlanRequest.fromDate(DateTime date) {
    final weekStart = date.startOfWeek;
    final weekEnd = DateTime(
      weekStart.year,
      weekStart.month,
      weekStart.day + 6, // Sunday
    );

    return CreateWeeklyPlanRequest(
      startDate: weekStart,
      endDate: weekEnd,
    );
  }

  factory CreateWeeklyPlanRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateWeeklyPlanRequestFromJson(json);

  @JsonKey(name: 'startDate')
  final DateTime startDate;

  @JsonKey(name: 'endDate')
  final DateTime endDate;

  @JsonKey(name: 'name')
  final String? name;

  Map<String, dynamic> toJson() => _$CreateWeeklyPlanRequestToJson(this);
}

/// Request model for updating an existing weekly plan.
/// All fields are optional since this is a PATCH operation.
@JsonSerializable()
class UpdateWeeklyPlanRequest {
  UpdateWeeklyPlanRequest({
    this.startDate,
    this.endDate,
    this.name,
  });

  factory UpdateWeeklyPlanRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateWeeklyPlanRequestFromJson(json);
  @JsonKey(name: 'startDate')
  final DateTime? startDate;

  @JsonKey(name: 'endDate')
  final DateTime? endDate;

  @JsonKey(name: 'name')
  final String? name;

  Map<String, dynamic> toJson() => _$UpdateWeeklyPlanRequestToJson(this);
}
