import 'package:meal_planner/core/api/api_client.dart';
import 'package:meal_planner/features/auth/providers/auth_provider.dart';
import 'package:meal_planner/features/meals/models/meal_model.dart';
import 'package:meal_planner/features/meals/models/weekly_plan_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'meal_service.g.dart';

@riverpod
class MealService extends _$MealService {
  final _api = ApiClient();

  @override
  FutureOr<void> build() {}

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

  Future<WeeklyPlanModel> getCurrentWeekPlan() async {
    final userId = ref.read(authStateProvider).value?.uid;
    if (userId == null) throw Exception('User not authenticated');

    final response = await _api.get<Map<String, dynamic>>(
      '/weekly-plans',
      queryParameters: {'userId': userId},
    );

    return WeeklyPlanModel.fromJson(response.data!);
  }

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
