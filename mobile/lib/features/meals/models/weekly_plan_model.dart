/// Model class representing a weekly meal plan.
/// 
/// This file defines the structure for weekly meal plans and meal assignments.
/// A weekly plan contains a list of meal assignments, where each assignment
/// connects a meal to a specific day and meal type (e.g., breakfast, lunch, dinner).

import 'package:freezed_annotation/freezed_annotation.dart';
import 'meal_model.dart';

part 'weekly_plan_model.freezed.dart';
part 'weekly_plan_model.g.dart';

@freezed
class WeeklyPlan with _$WeeklyPlan {
  const factory WeeklyPlan({
    required String id,
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
    required List<MealAssignment> assignments,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _WeeklyPlan;

  factory WeeklyPlan.fromJson(Map<String, dynamic> json) =>
      _$WeeklyPlanFromJson(json);
}

@freezed
class CreateWeeklyPlanRequest with _$CreateWeeklyPlanRequest {
  const factory CreateWeeklyPlanRequest({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) = _CreateWeeklyPlanRequest;

  factory CreateWeeklyPlanRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateWeeklyPlanRequestFromJson(json);
}

@freezed
class UpdateWeeklyPlanRequest with _$UpdateWeeklyPlanRequest {
  const factory UpdateWeeklyPlanRequest({
    required String id,
    required DateTime startDate,
    required DateTime endDate,
  }) = _UpdateWeeklyPlanRequest;

  factory UpdateWeeklyPlanRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateWeeklyPlanRequestFromJson(json);
}

/// Model class representing a meal assignment in a weekly plan.
@JsonSerializable()
class MealAssignment {
  /// Unique identifier for the meal assignment.
  final String id;
  
  /// ID of the weekly plan this assignment belongs to.
  final String weeklyPlanId;
  
  /// ID of the assigned meal.
  final String mealId;
  
  /// Day of the week (0-6, where 0 is Sunday).
  final int dayOfWeek;
  
  /// Type of meal (e.g., 'breakfast', 'lunch', 'dinner').
  final String mealType;

  /// Optional note for this meal assignment.
  final String? note;
  
  /// When the assignment was created.
  final DateTime createdAt;
  
  /// When the assignment was last updated.
  final DateTime updatedAt;

  /// Creates a new meal assignment.
  const MealAssignment({
    required this.id,
    required this.weeklyPlanId,
    required this.mealId,
    required this.dayOfWeek,
    required this.mealType,
    this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates a copy of this assignment with the given fields replaced with the new values.
  MealAssignment copyWith({
    String? id,
    String? weeklyPlanId,
    String? mealId,
    int? dayOfWeek,
    String? mealType,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MealAssignment(
      id: id ?? this.id,
      weeklyPlanId: weeklyPlanId ?? this.weeklyPlanId,
      mealId: mealId ?? this.mealId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      mealType: mealType ?? this.mealType,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Creates a meal assignment from a JSON map.
  factory MealAssignment.fromJson(Map<String, dynamic> json) => _$MealAssignmentFromJson(json);

  /// Converts this meal assignment to a JSON map.
  Map<String, dynamic> toJson() => _$MealAssignmentToJson(this);

  @override
  String toString() {
    return 'MealAssignment(id: $id, mealId: $mealId, dayOfWeek: $dayOfWeek, mealType: $mealType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MealAssignment &&
        other.id == id &&
        other.weeklyPlanId == weeklyPlanId &&
        other.mealId == mealId &&
        other.dayOfWeek == dayOfWeek &&
        other.mealType == mealType &&
        other.note == note &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      weeklyPlanId,
      mealId,
      dayOfWeek,
      mealType,
      note,
      createdAt,
      updatedAt,
    );
  }
}
