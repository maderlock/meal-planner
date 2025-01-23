/// Service for managing meal-related operations.
/// 
/// This service is responsible for:
/// - Managing meal data in local state
/// - Handling meal-related operations
/// - Providing meal data to the UI
/// 
/// Dependencies:
/// - Uses Riverpod for state management
/// - Uses Dio and Retrofit for API calls

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:meal_planner/features/meals/models/meal_model.dart';
import 'package:meal_planner/features/meals/models/weekly_plan_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'meal_service.g.dart';

@riverpod
class MealService extends _$MealService {
  final Dio _dio = Dio();
  late final MealServiceApi _api;

  @override
  FutureOr<void> build() async {
    _api = MealServiceApi(_dio, baseUrl: 'https://api.example.com');
  }

  Future<List<MealModel>> getMeals() async {
    final response = await _api.getMeals();
    return response.map((meal) => MealModel.fromJson(meal.toJson())).toList();
  }

  Future<MealModel> getMeal(String id) async {
    final response = await _api.getMeal(id);
    return MealModel.fromJson(response.toJson());
  }

  Future<List<WeeklyPlanModel>> getWeeklyPlans() async {
    final response = await _api.getWeeklyPlans();
    return response.map((plan) => WeeklyPlanModel.fromJson(plan.toJson())).toList();
  }

  Future<WeeklyPlanModel> getWeeklyPlan(String id) async {
    final response = await _api.getWeeklyPlan(id);
    return WeeklyPlanModel.fromJson(response.toJson());
  }

  Future<WeeklyPlanModel> createWeeklyPlan(CreateWeeklyPlanRequest request) async {
    final response = await _api.createWeeklyPlan(request);
    return WeeklyPlanModel.fromJson(response.toJson());
  }

  Future<WeeklyPlanModel> updateWeeklyPlan(String id, UpdateWeeklyPlanRequest request) async {
    final response = await _api.updateWeeklyPlan(id, request);
    return WeeklyPlanModel.fromJson(response.toJson());
  }

  Future<void> assignMeal(String weeklyPlanId, Map<String, dynamic> assignment) async {
    await _api.assignMeal(weeklyPlanId, assignment);
  }

  Future<void> removeAssignment(String weeklyPlanId, String assignmentId) async {
    await _api.removeAssignment(weeklyPlanId, assignmentId);
  }

  Future<List<MealModel>> getFavorites() async {
    final response = await _api.getFavorites();
    return response.map((favorite) => MealModel.fromJson(favorite.toJson())).toList();
  }

  Future<void> addFavorite(Map<String, String> request) async {
    await _api.addFavorite(request);
  }

  Future<void> removeFavorite(String mealId) async {
    await _api.removeFavorite(mealId);
  }
}

@RestApi()
abstract class MealServiceApi {
  factory MealServiceApi(Dio dio, {String baseUrl}) = _MealServiceApi;

  @GET('/api/meals')
  Future<List<Meal>> getMeals();

  @GET('/api/meals/{id}')
  Future<Meal> getMeal(@Path('id') String id);

  @GET('/api/weekly-plans')
  Future<List<WeeklyPlan>> getWeeklyPlans();

  @GET('/api/weekly-plans/{id}')
  Future<WeeklyPlan> getWeeklyPlan(@Path('id') String id);

  @POST('/api/weekly-plans')
  Future<WeeklyPlan> createWeeklyPlan(@Body() CreateWeeklyPlanRequest request);

  @PATCH('/api/weekly-plans/{id}')
  Future<WeeklyPlan> updateWeeklyPlan(
    @Path('id') String id,
    @Body() UpdateWeeklyPlanRequest request,
  );

  @POST('/api/weekly-plans/{id}/assignments')
  Future<MealAssignment> assignMeal(
    @Path('id') String weeklyPlanId,
    @Body() Map<String, dynamic> assignment,
  );

  @DELETE('/api/weekly-plans/{weeklyPlanId}/assignments/{assignmentId}')
  Future<void> removeAssignment(
    @Path('weeklyPlanId') String weeklyPlanId,
    @Path('assignmentId') String assignmentId,
  );

  @GET('/api/favorites')
  Future<List<FavoriteMeal>> getFavorites();

  @POST('/api/favorites')
  Future<FavoriteMeal> addFavorite(@Body() Map<String, String> request);

  @DELETE('/api/favorites/{mealId}')
  Future<void> removeFavorite(@Path('mealId') String mealId);
}
