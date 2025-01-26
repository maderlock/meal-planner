import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:meal_planner/features/meals/models/meal_model.dart';
import 'package:meal_planner/features/meals/services/meal_service.dart';
import 'package:dio/dio.dart';
import '../../../core/network/api_client.dart';
import '../../../core/config/app_config.dart';

part 'meal_provider.g.dart';

@riverpod
MealService mealService(MealServiceRef ref) {
  final dio = ref.watch(dioProvider);
  final api = MealServiceApi(dio, baseUrl: AppConfig.instance.baseUrl);
  return MealService(api);
}

@riverpod
Future<List<MealModel>> meals(MealsRef ref) async {
  final mealService = ref.watch(mealServiceProvider);
  return mealService.getMeals();
}

@riverpod
Future<List<MealModel>> favoriteMeals(FavoriteMealsRef ref) async {
  final mealService = ref.watch(mealServiceProvider);
  return mealService.getFavorites();
}
