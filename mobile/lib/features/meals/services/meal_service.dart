/// Service for managing meal-related operations.
/// 
/// This file is responsible for:
/// - Managing CRUD operations for meals
/// - Handling meal data synchronization with the backend
/// - Managing weekly meal plans
/// - Caching meal data locally
/// 
/// Referenced by:
/// - Used by meal-related screens for data operations
/// - Used by weekly plan screen for meal planning
/// - Used by meal providers for state management
/// 
/// Dependencies:
/// - Uses ApiClient for backend communication
/// - Uses StorageService for local caching
/// - Uses MealModel for data structure

import 'package:meal_planner/core/api/api_client.dart';
import 'package:meal_planner/features/auth/providers/auth_provider.dart';
import 'package:meal_planner/features/meals/models/meal_model.dart';
import 'package:meal_planner/features/meals/models/weekly_plan_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meal_service.g.dart';

/// Service class for managing meal operations
@riverpod
class MealService extends _$MealService {
  /// API client instance for backend communication
  final _api = ApiClient();

  @override
  FutureOr<void> build() {}

  /// Fetch favorite meals from the backend
  /// 
  /// Returns a list of MealModel objects representing the user's favorite meals
  Future<List<MealModel>> getFavoriteMeals() async {
    final userId = ref.read(authStateProvider).value?.uid;
    if (userId == null) throw Exception('User not authenticated');

    final response = await _api.get<List<dynamic>>(
      '/meals',
      queryParameters: {
        'userId': userId,
        'favoritesOnly': true,
      },
    );

    return response.data!
        .map((meal) => MealModel.fromJson(meal as Map<String, dynamic>))
        .toList();
  }

  /// Create a new meal
  /// 
  /// Returns the newly created MealModel object
  Future<MealModel> createMeal({
    required String name,
    String? description,
    bool isFavorite = false,
  }) async {
    final userId = ref.read(authStateProvider).value?.uid;
    if (userId == null) throw Exception('User not authenticated');

    final response = await _api.post<Map<String, dynamic>>(
      '/meals',
      data: {
        'name': name,
        'description': description,
        'userId': userId,
        'isFavorite': isFavorite,
      },
    );

    return MealModel.fromJson(response.data!);
  }

  /// Update an existing meal
  /// 
  /// Returns the updated MealModel object
  Future<MealModel> updateMeal({
    required String id,
    String? name,
    String? description,
    bool? isFavorite,
  }) async {
    final response = await _api.patch<Map<String, dynamic>>(
      '/meals',
      queryParameters: {'id': id},
      data: {
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (isFavorite != null) 'isFavorite': isFavorite,
      },
    );

    return MealModel.fromJson(response.data!);
  }

  /// Get the current week's meal plan
  /// 
  /// Returns the WeeklyPlanModel object representing the current week's meal plan
  Future<WeeklyPlanModel> getCurrentWeekPlan() async {
    final userId = ref.read(authStateProvider).value?.uid;
    if (userId == null) throw Exception('User not authenticated');

    final response = await _api.get<Map<String, dynamic>>(
      '/weekly-plans',
      queryParameters: {'userId': userId},
    );

    return WeeklyPlanModel.fromJson(response.data!);
  }

  /// Update a meal plan
  /// 
  /// Updates the meal plan with the given meal ID, day of week, and meal type
  Future<void> updateMealPlan({
    required String weeklyPlanId,
    required String mealId,
    required int dayOfWeek,
    required String mealType,
  }) async {
    await _api.post<Map<String, dynamic>>(
      '/weekly-plans/$weeklyPlanId/meals',
      data: {
        'mealId': mealId,
        'dayOfWeek': dayOfWeek,
        'mealType': mealType,
      },
    );
  }

  /// Remove a meal plan
  /// 
  /// Removes the meal plan with the given day of week and meal type
  Future<void> removeMealPlan({
    required String weeklyPlanId,
    required int dayOfWeek,
    required String mealType,
  }) async {
    await _api.delete(
      '/weekly-plans/$weeklyPlanId/meals',
      queryParameters: {
        'dayOfWeek': dayOfWeek,
        'mealType': mealType,
      },
    );
  }
}
