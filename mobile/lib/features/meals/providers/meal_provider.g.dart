// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mealServiceHash() => r'a8d0d4fc658bc4ca1c6f2afe1861818ea1f61301';

/// See also [mealService].
@ProviderFor(mealService)
final mealServiceProvider = AutoDisposeProvider<MealService>.internal(
  mealService,
  name: r'mealServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mealServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MealServiceRef = AutoDisposeProviderRef<MealService>;
String _$mealsHash() => r'd349a828039c6328bbd4d1f1399b9281b052ca62';

/// See also [meals].
@ProviderFor(meals)
final mealsProvider = AutoDisposeFutureProvider<List<MealModel>>.internal(
  meals,
  name: r'mealsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mealsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MealsRef = AutoDisposeFutureProviderRef<List<MealModel>>;
String _$favoriteMealsHash() => r'671cfbcb48440ff15ed4c61713ff167b2afb513b';

/// See also [favoriteMeals].
@ProviderFor(favoriteMeals)
final favoriteMealsProvider =
    AutoDisposeFutureProvider<List<MealModel>>.internal(
  favoriteMeals,
  name: r'favoriteMealsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteMealsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FavoriteMealsRef = AutoDisposeFutureProviderRef<List<MealModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
