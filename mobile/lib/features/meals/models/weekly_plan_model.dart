/// Model class representing a weekly meal plan.
/// 
/// This file is responsible for:
/// - Defining the weekly meal plan data structure
/// - Handling JSON serialization/deserialization
/// - Managing meal assignments to days of the week
/// - Supporting copy operations for state updates
/// 
/// Referenced by:
/// - Used by MealService for weekly plan operations
/// - Used by weekly plan screen for display
/// - Used for meal planning functionality
/// 
/// Dependencies:
/// - Requires MealModel for meal references
/// - Part of the meals feature module

import 'meal_model.dart';

/// Model class representing a weekly meal plan.
class WeeklyPlanModel {
  /// Unique identifier for the weekly plan.
  final String id;
  
  /// User ID associated with the weekly plan.
  final String userId;
  
  /// Start date of the weekly plan.
  final DateTime startDate;
  
  /// End date of the weekly plan.
  final DateTime endDate;
  
  /// List of meal IDs assigned to the weekly plan.
  final List<String> mealIds;
  
  /// Timestamp when the weekly plan was created.
  final DateTime createdAt;
  
  /// Timestamp when the weekly plan was last updated.
  final DateTime updatedAt;

  /// Constructs a new WeeklyPlanModel instance.
  WeeklyPlanModel({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.mealIds,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates a new WeeklyPlanModel instance from a JSON object.
  factory WeeklyPlanModel.fromJson(Map<String, dynamic> json) {
    return WeeklyPlanModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      mealIds: List<String>.from(json['mealIds'] as List),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the WeeklyPlanModel instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'mealIds': mealIds,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Creates a copy of the WeeklyPlanModel instance with updated properties.
  WeeklyPlanModel copyWith({
    String? id,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? mealIds,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WeeklyPlanModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      mealIds: mealIds ?? this.mealIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklyPlanModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          mealIds == other.mealIds &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      mealIds.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}

/// Model class representing a meal plan item.
class MealPlanItem {
  /// Unique identifier for the meal plan item.
  final String id;
  
  /// Weekly plan ID associated with the meal plan item.
  final String weeklyPlanId;
  
  /// Meal ID associated with the meal plan item.
  final String mealId;
  
  /// Day of the week (1-7) for the meal plan item.
  final int dayOfWeek;
  
  /// Type of meal (e.g. breakfast, lunch, dinner).
  final String mealType;
  
  /// Timestamp when the meal plan item was created.
  final DateTime createdAt;
  
  /// Timestamp when the meal plan item was last updated.
  final DateTime updatedAt;
  
  /// Meal model instance associated with the meal plan item.
  final MealModel meal;

  /// Constructs a new MealPlanItem instance.
  MealPlanItem({
    required this.id,
    required this.weeklyPlanId,
    required this.mealId,
    required this.dayOfWeek,
    required this.mealType,
    required this.createdAt,
    required this.updatedAt,
    required this.meal,
  });

  /// Creates a new MealPlanItem instance from a JSON object.
  factory MealPlanItem.fromJson(Map<String, dynamic> json) {
    return MealPlanItem(
      id: json['id'] as String,
      weeklyPlanId: json['weekly_plan_id'] as String,
      mealId: json['meal_id'] as String,
      dayOfWeek: json['day_of_week'] as int,
      mealType: json['meal_type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      meal: MealModel.fromJson(json['meal'] as Map<String, dynamic>),
    );
  }

  /// Creates a copy of the MealPlanItem instance with updated properties.
  MealPlanItem copyWith({
    String? id,
    String? weeklyPlanId,
    String? mealId,
    int? dayOfWeek,
    String? mealType,
    DateTime? createdAt,
    DateTime? updatedAt,
    MealModel? meal,
  }) {
    return MealPlanItem(
      id: id ?? this.id,
      weeklyPlanId: weeklyPlanId ?? this.weeklyPlanId,
      mealId: mealId ?? this.mealId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      mealType: mealType ?? this.mealType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      meal: meal ?? this.meal,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealPlanItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          weeklyPlanId == other.weeklyPlanId &&
          mealId == other.mealId &&
          dayOfWeek == other.dayOfWeek &&
          mealType == other.mealType &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          meal == other.meal;

  @override
  int get hashCode =>
      id.hashCode ^
      weeklyPlanId.hashCode ^
      mealId.hashCode ^
      dayOfWeek.hashCode ^
      mealType.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      meal.hashCode;
}
