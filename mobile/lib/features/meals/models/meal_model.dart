/// Model classes representing meals and their assignments in the application.
/// 
/// These represent global meals that can be assigned to weekly plans.
/// The meal contains core information like name, description, and instructions,
/// but these details are loaded on demand to optimize data transfer.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_model.freezed.dart';
part 'meal_model.g.dart';

@freezed
class Meal with _$Meal {
  /// Unique identifier for the meal.
  const factory Meal({
    required String id,
    /// Name of the meal.
    required String name,
    /// Brief description of the meal.
    required String description,
    /// List of ingredients required for the meal.
    required List<String> ingredients,
    /// Step-by-step instructions for preparing the meal.
    required List<String> instructions,
    /// URL of the meal's image.
    required String imageUrl,
    /// Whether the meal is favorited by the user.
    @Default(false) bool isFavorite,
    /// When the meal was created.
    required DateTime createdAt,
    /// When the meal was last updated.
    required DateTime updatedAt,
  }) = _Meal;

  /// Creates a meal from a JSON map.
  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
}

@freezed
class MealAssignment with _$MealAssignment {
  /// Unique identifier for the meal assignment.
  const factory MealAssignment({
    required String id,
    /// ID of the weekly plan that the meal is assigned to.
    required String weeklyPlanId,
    /// ID of the assigned meal.
    required String mealId,
    /// Day of the week that the meal is assigned to.
    required int dayOfWeek,
    /// Type of meal (e.g. breakfast, lunch, dinner).
    required String mealType,
    /// The assigned meal.
    required Meal meal,
    /// When the meal was assigned.
    required DateTime createdAt,
    /// When the meal assignment was last updated.
    required DateTime updatedAt,
  }) = _MealAssignment;

  /// Creates a meal assignment from a JSON map.
  factory MealAssignment.fromJson(Map<String, dynamic> json) =>
      _$MealAssignmentFromJson(json);
}

@freezed
class FavoriteMeal with _$FavoriteMeal {
  /// ID of the user who favorited the meal.
  const factory FavoriteMeal({
    required String userId,
    /// ID of the favorited meal.
    required String mealId,
    /// The favorited meal.
    required Meal meal,
    /// When the meal was favorited.
    required DateTime createdAt,
  }) = _FavoriteMeal;

  /// Creates a favorite meal from a JSON map.
  factory FavoriteMeal.fromJson(Map<String, dynamic> json) =>
      _$FavoriteMealFromJson(json);
}
