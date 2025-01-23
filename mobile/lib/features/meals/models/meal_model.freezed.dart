// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Meal _$MealFromJson(Map<String, dynamic> json) {
  return _Meal.fromJson(json);
}

/// @nodoc
mixin _$Meal {
  String get id => throw _privateConstructorUsedError;

  /// Name of the meal.
  String get name => throw _privateConstructorUsedError;

  /// Brief description of the meal.
  String get description => throw _privateConstructorUsedError;

  /// List of ingredients required for the meal.
  List<String> get ingredients => throw _privateConstructorUsedError;

  /// Step-by-step instructions for preparing the meal.
  List<String> get instructions => throw _privateConstructorUsedError;

  /// URL of the meal's image.
  String get imageUrl => throw _privateConstructorUsedError;

  /// Whether the meal is favorited by the user.
  bool get isFavorite => throw _privateConstructorUsedError;

  /// When the meal was created.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// When the meal was last updated.
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Meal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealCopyWith<Meal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealCopyWith<$Res> {
  factory $MealCopyWith(Meal value, $Res Function(Meal) then) =
      _$MealCopyWithImpl<$Res, Meal>;
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<String> ingredients,
      List<String> instructions,
      String imageUrl,
      bool isFavorite,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$MealCopyWithImpl<$Res, $Val extends Meal>
    implements $MealCopyWith<$Res> {
  _$MealCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? ingredients = null,
    Object? instructions = null,
    Object? imageUrl = null,
    Object? isFavorite = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      instructions: null == instructions
          ? _value.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealImplCopyWith<$Res> implements $MealCopyWith<$Res> {
  factory _$$MealImplCopyWith(
          _$MealImpl value, $Res Function(_$MealImpl) then) =
      __$$MealImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String description,
      List<String> ingredients,
      List<String> instructions,
      String imageUrl,
      bool isFavorite,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$MealImplCopyWithImpl<$Res>
    extends _$MealCopyWithImpl<$Res, _$MealImpl>
    implements _$$MealImplCopyWith<$Res> {
  __$$MealImplCopyWithImpl(_$MealImpl _value, $Res Function(_$MealImpl) _then)
      : super(_value, _then);

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? ingredients = null,
    Object? instructions = null,
    Object? imageUrl = null,
    Object? isFavorite = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$MealImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<String>,
      instructions: null == instructions
          ? _value._instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealImpl implements _Meal {
  const _$MealImpl(
      {required this.id,
      required this.name,
      required this.description,
      required final List<String> ingredients,
      required final List<String> instructions,
      required this.imageUrl,
      this.isFavorite = false,
      required this.createdAt,
      required this.updatedAt})
      : _ingredients = ingredients,
        _instructions = instructions;

  factory _$MealImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealImplFromJson(json);

  @override
  final String id;

  /// Name of the meal.
  @override
  final String name;

  /// Brief description of the meal.
  @override
  final String description;

  /// List of ingredients required for the meal.
  final List<String> _ingredients;

  /// List of ingredients required for the meal.
  @override
  List<String> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  /// Step-by-step instructions for preparing the meal.
  final List<String> _instructions;

  /// Step-by-step instructions for preparing the meal.
  @override
  List<String> get instructions {
    if (_instructions is EqualUnmodifiableListView) return _instructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_instructions);
  }

  /// URL of the meal's image.
  @override
  final String imageUrl;

  /// Whether the meal is favorited by the user.
  @override
  @JsonKey()
  final bool isFavorite;

  /// When the meal was created.
  @override
  final DateTime createdAt;

  /// When the meal was last updated.
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Meal(id: $id, name: $name, description: $description, ingredients: $ingredients, instructions: $instructions, imageUrl: $imageUrl, isFavorite: $isFavorite, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            const DeepCollectionEquality()
                .equals(other._instructions, _instructions) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      const DeepCollectionEquality().hash(_ingredients),
      const DeepCollectionEquality().hash(_instructions),
      imageUrl,
      isFavorite,
      createdAt,
      updatedAt);

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealImplCopyWith<_$MealImpl> get copyWith =>
      __$$MealImplCopyWithImpl<_$MealImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealImplToJson(
      this,
    );
  }
}

abstract class _Meal implements Meal {
  const factory _Meal(
      {required final String id,
      required final String name,
      required final String description,
      required final List<String> ingredients,
      required final List<String> instructions,
      required final String imageUrl,
      final bool isFavorite,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$MealImpl;

  factory _Meal.fromJson(Map<String, dynamic> json) = _$MealImpl.fromJson;

  @override
  String get id;

  /// Name of the meal.
  @override
  String get name;

  /// Brief description of the meal.
  @override
  String get description;

  /// List of ingredients required for the meal.
  @override
  List<String> get ingredients;

  /// Step-by-step instructions for preparing the meal.
  @override
  List<String> get instructions;

  /// URL of the meal's image.
  @override
  String get imageUrl;

  /// Whether the meal is favorited by the user.
  @override
  bool get isFavorite;

  /// When the meal was created.
  @override
  DateTime get createdAt;

  /// When the meal was last updated.
  @override
  DateTime get updatedAt;

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealImplCopyWith<_$MealImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealAssignment _$MealAssignmentFromJson(Map<String, dynamic> json) {
  return _MealAssignment.fromJson(json);
}

/// @nodoc
mixin _$MealAssignment {
  String get id => throw _privateConstructorUsedError;

  /// ID of the weekly plan that the meal is assigned to.
  String get weeklyPlanId => throw _privateConstructorUsedError;

  /// ID of the assigned meal.
  String get mealId => throw _privateConstructorUsedError;

  /// Day of the week that the meal is assigned to.
  int get dayOfWeek => throw _privateConstructorUsedError;

  /// Type of meal (e.g. breakfast, lunch, dinner).
  String get mealType => throw _privateConstructorUsedError;

  /// The assigned meal.
  Meal get meal => throw _privateConstructorUsedError;

  /// When the meal was assigned.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// When the meal assignment was last updated.
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this MealAssignment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealAssignment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealAssignmentCopyWith<MealAssignment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealAssignmentCopyWith<$Res> {
  factory $MealAssignmentCopyWith(
          MealAssignment value, $Res Function(MealAssignment) then) =
      _$MealAssignmentCopyWithImpl<$Res, MealAssignment>;
  @useResult
  $Res call(
      {String id,
      String weeklyPlanId,
      String mealId,
      int dayOfWeek,
      String mealType,
      Meal meal,
      DateTime createdAt,
      DateTime updatedAt});

  $MealCopyWith<$Res> get meal;
}

/// @nodoc
class _$MealAssignmentCopyWithImpl<$Res, $Val extends MealAssignment>
    implements $MealAssignmentCopyWith<$Res> {
  _$MealAssignmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealAssignment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weeklyPlanId = null,
    Object? mealId = null,
    Object? dayOfWeek = null,
    Object? mealType = null,
    Object? meal = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      weeklyPlanId: null == weeklyPlanId
          ? _value.weeklyPlanId
          : weeklyPlanId // ignore: cast_nullable_to_non_nullable
              as String,
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String,
      dayOfWeek: null == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as String,
      meal: null == meal
          ? _value.meal
          : meal // ignore: cast_nullable_to_non_nullable
              as Meal,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of MealAssignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MealCopyWith<$Res> get meal {
    return $MealCopyWith<$Res>(_value.meal, (value) {
      return _then(_value.copyWith(meal: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MealAssignmentImplCopyWith<$Res>
    implements $MealAssignmentCopyWith<$Res> {
  factory _$$MealAssignmentImplCopyWith(_$MealAssignmentImpl value,
          $Res Function(_$MealAssignmentImpl) then) =
      __$$MealAssignmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String weeklyPlanId,
      String mealId,
      int dayOfWeek,
      String mealType,
      Meal meal,
      DateTime createdAt,
      DateTime updatedAt});

  @override
  $MealCopyWith<$Res> get meal;
}

/// @nodoc
class __$$MealAssignmentImplCopyWithImpl<$Res>
    extends _$MealAssignmentCopyWithImpl<$Res, _$MealAssignmentImpl>
    implements _$$MealAssignmentImplCopyWith<$Res> {
  __$$MealAssignmentImplCopyWithImpl(
      _$MealAssignmentImpl _value, $Res Function(_$MealAssignmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealAssignment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? weeklyPlanId = null,
    Object? mealId = null,
    Object? dayOfWeek = null,
    Object? mealType = null,
    Object? meal = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$MealAssignmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      weeklyPlanId: null == weeklyPlanId
          ? _value.weeklyPlanId
          : weeklyPlanId // ignore: cast_nullable_to_non_nullable
              as String,
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String,
      dayOfWeek: null == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as String,
      meal: null == meal
          ? _value.meal
          : meal // ignore: cast_nullable_to_non_nullable
              as Meal,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealAssignmentImpl implements _MealAssignment {
  const _$MealAssignmentImpl(
      {required this.id,
      required this.weeklyPlanId,
      required this.mealId,
      required this.dayOfWeek,
      required this.mealType,
      required this.meal,
      required this.createdAt,
      required this.updatedAt});

  factory _$MealAssignmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealAssignmentImplFromJson(json);

  @override
  final String id;

  /// ID of the weekly plan that the meal is assigned to.
  @override
  final String weeklyPlanId;

  /// ID of the assigned meal.
  @override
  final String mealId;

  /// Day of the week that the meal is assigned to.
  @override
  final int dayOfWeek;

  /// Type of meal (e.g. breakfast, lunch, dinner).
  @override
  final String mealType;

  /// The assigned meal.
  @override
  final Meal meal;

  /// When the meal was assigned.
  @override
  final DateTime createdAt;

  /// When the meal assignment was last updated.
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'MealAssignment(id: $id, weeklyPlanId: $weeklyPlanId, mealId: $mealId, dayOfWeek: $dayOfWeek, mealType: $mealType, meal: $meal, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealAssignmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.weeklyPlanId, weeklyPlanId) ||
                other.weeklyPlanId == weeklyPlanId) &&
            (identical(other.mealId, mealId) || other.mealId == mealId) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.mealType, mealType) ||
                other.mealType == mealType) &&
            (identical(other.meal, meal) || other.meal == meal) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, weeklyPlanId, mealId,
      dayOfWeek, mealType, meal, createdAt, updatedAt);

  /// Create a copy of MealAssignment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealAssignmentImplCopyWith<_$MealAssignmentImpl> get copyWith =>
      __$$MealAssignmentImplCopyWithImpl<_$MealAssignmentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealAssignmentImplToJson(
      this,
    );
  }
}

abstract class _MealAssignment implements MealAssignment {
  const factory _MealAssignment(
      {required final String id,
      required final String weeklyPlanId,
      required final String mealId,
      required final int dayOfWeek,
      required final String mealType,
      required final Meal meal,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$MealAssignmentImpl;

  factory _MealAssignment.fromJson(Map<String, dynamic> json) =
      _$MealAssignmentImpl.fromJson;

  @override
  String get id;

  /// ID of the weekly plan that the meal is assigned to.
  @override
  String get weeklyPlanId;

  /// ID of the assigned meal.
  @override
  String get mealId;

  /// Day of the week that the meal is assigned to.
  @override
  int get dayOfWeek;

  /// Type of meal (e.g. breakfast, lunch, dinner).
  @override
  String get mealType;

  /// The assigned meal.
  @override
  Meal get meal;

  /// When the meal was assigned.
  @override
  DateTime get createdAt;

  /// When the meal assignment was last updated.
  @override
  DateTime get updatedAt;

  /// Create a copy of MealAssignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealAssignmentImplCopyWith<_$MealAssignmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FavoriteMeal _$FavoriteMealFromJson(Map<String, dynamic> json) {
  return _FavoriteMeal.fromJson(json);
}

/// @nodoc
mixin _$FavoriteMeal {
  String get userId => throw _privateConstructorUsedError;

  /// ID of the favorited meal.
  String get mealId => throw _privateConstructorUsedError;

  /// The favorited meal.
  Meal get meal => throw _privateConstructorUsedError;

  /// When the meal was favorited.
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this FavoriteMeal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteMeal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteMealCopyWith<FavoriteMeal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteMealCopyWith<$Res> {
  factory $FavoriteMealCopyWith(
          FavoriteMeal value, $Res Function(FavoriteMeal) then) =
      _$FavoriteMealCopyWithImpl<$Res, FavoriteMeal>;
  @useResult
  $Res call({String userId, String mealId, Meal meal, DateTime createdAt});

  $MealCopyWith<$Res> get meal;
}

/// @nodoc
class _$FavoriteMealCopyWithImpl<$Res, $Val extends FavoriteMeal>
    implements $FavoriteMealCopyWith<$Res> {
  _$FavoriteMealCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteMeal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? mealId = null,
    Object? meal = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String,
      meal: null == meal
          ? _value.meal
          : meal // ignore: cast_nullable_to_non_nullable
              as Meal,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  /// Create a copy of FavoriteMeal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MealCopyWith<$Res> get meal {
    return $MealCopyWith<$Res>(_value.meal, (value) {
      return _then(_value.copyWith(meal: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FavoriteMealImplCopyWith<$Res>
    implements $FavoriteMealCopyWith<$Res> {
  factory _$$FavoriteMealImplCopyWith(
          _$FavoriteMealImpl value, $Res Function(_$FavoriteMealImpl) then) =
      __$$FavoriteMealImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String mealId, Meal meal, DateTime createdAt});

  @override
  $MealCopyWith<$Res> get meal;
}

/// @nodoc
class __$$FavoriteMealImplCopyWithImpl<$Res>
    extends _$FavoriteMealCopyWithImpl<$Res, _$FavoriteMealImpl>
    implements _$$FavoriteMealImplCopyWith<$Res> {
  __$$FavoriteMealImplCopyWithImpl(
      _$FavoriteMealImpl _value, $Res Function(_$FavoriteMealImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoriteMeal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? mealId = null,
    Object? meal = null,
    Object? createdAt = null,
  }) {
    return _then(_$FavoriteMealImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String,
      meal: null == meal
          ? _value.meal
          : meal // ignore: cast_nullable_to_non_nullable
              as Meal,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoriteMealImpl implements _FavoriteMeal {
  const _$FavoriteMealImpl(
      {required this.userId,
      required this.mealId,
      required this.meal,
      required this.createdAt});

  factory _$FavoriteMealImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoriteMealImplFromJson(json);

  @override
  final String userId;

  /// ID of the favorited meal.
  @override
  final String mealId;

  /// The favorited meal.
  @override
  final Meal meal;

  /// When the meal was favorited.
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'FavoriteMeal(userId: $userId, mealId: $mealId, meal: $meal, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteMealImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.mealId, mealId) || other.mealId == mealId) &&
            (identical(other.meal, meal) || other.meal == meal) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, mealId, meal, createdAt);

  /// Create a copy of FavoriteMeal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteMealImplCopyWith<_$FavoriteMealImpl> get copyWith =>
      __$$FavoriteMealImplCopyWithImpl<_$FavoriteMealImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteMealImplToJson(
      this,
    );
  }
}

abstract class _FavoriteMeal implements FavoriteMeal {
  const factory _FavoriteMeal(
      {required final String userId,
      required final String mealId,
      required final Meal meal,
      required final DateTime createdAt}) = _$FavoriteMealImpl;

  factory _FavoriteMeal.fromJson(Map<String, dynamic> json) =
      _$FavoriteMealImpl.fromJson;

  @override
  String get userId;

  /// ID of the favorited meal.
  @override
  String get mealId;

  /// The favorited meal.
  @override
  Meal get meal;

  /// When the meal was favorited.
  @override
  DateTime get createdAt;

  /// Create a copy of FavoriteMeal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteMealImplCopyWith<_$FavoriteMealImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
