// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weekly_plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeeklyPlanModel _$WeeklyPlanModelFromJson(Map<String, dynamic> json) {
  return _WeeklyPlanModel.fromJson(json);
}

/// @nodoc
mixin _$WeeklyPlanModel {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'userId')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'startDate')
  DateTime get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'endDate')
  DateTime get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'assignments')
  List<MealAssignment> get assignments => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updatedAt')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this WeeklyPlanModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeeklyPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklyPlanModelCopyWith<WeeklyPlanModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyPlanModelCopyWith<$Res> {
  factory $WeeklyPlanModelCopyWith(
          WeeklyPlanModel value, $Res Function(WeeklyPlanModel) then) =
      _$WeeklyPlanModelCopyWithImpl<$Res, WeeklyPlanModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'userId') String userId,
      @JsonKey(name: 'startDate') DateTime startDate,
      @JsonKey(name: 'endDate') DateTime endDate,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'assignments') List<MealAssignment> assignments,
      @JsonKey(name: 'createdAt') DateTime createdAt,
      @JsonKey(name: 'updatedAt') DateTime updatedAt});
}

/// @nodoc
class _$WeeklyPlanModelCopyWithImpl<$Res, $Val extends WeeklyPlanModel>
    implements $WeeklyPlanModelCopyWith<$Res> {
  _$WeeklyPlanModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklyPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? name = freezed,
    Object? assignments = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      assignments: null == assignments
          ? _value.assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<MealAssignment>,
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
abstract class _$$WeeklyPlanModelImplCopyWith<$Res>
    implements $WeeklyPlanModelCopyWith<$Res> {
  factory _$$WeeklyPlanModelImplCopyWith(_$WeeklyPlanModelImpl value,
          $Res Function(_$WeeklyPlanModelImpl) then) =
      __$$WeeklyPlanModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'userId') String userId,
      @JsonKey(name: 'startDate') DateTime startDate,
      @JsonKey(name: 'endDate') DateTime endDate,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'assignments') List<MealAssignment> assignments,
      @JsonKey(name: 'createdAt') DateTime createdAt,
      @JsonKey(name: 'updatedAt') DateTime updatedAt});
}

/// @nodoc
class __$$WeeklyPlanModelImplCopyWithImpl<$Res>
    extends _$WeeklyPlanModelCopyWithImpl<$Res, _$WeeklyPlanModelImpl>
    implements _$$WeeklyPlanModelImplCopyWith<$Res> {
  __$$WeeklyPlanModelImplCopyWithImpl(
      _$WeeklyPlanModelImpl _value, $Res Function(_$WeeklyPlanModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of WeeklyPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? name = freezed,
    Object? assignments = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$WeeklyPlanModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      assignments: null == assignments
          ? _value._assignments
          : assignments // ignore: cast_nullable_to_non_nullable
              as List<MealAssignment>,
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
class _$WeeklyPlanModelImpl implements _WeeklyPlanModel {
  const _$WeeklyPlanModelImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'userId') required this.userId,
      @JsonKey(name: 'startDate') required this.startDate,
      @JsonKey(name: 'endDate') required this.endDate,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'assignments')
      required final List<MealAssignment> assignments,
      @JsonKey(name: 'createdAt') required this.createdAt,
      @JsonKey(name: 'updatedAt') required this.updatedAt})
      : _assignments = assignments;

  factory _$WeeklyPlanModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklyPlanModelImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'userId')
  final String userId;
  @override
  @JsonKey(name: 'startDate')
  final DateTime startDate;
  @override
  @JsonKey(name: 'endDate')
  final DateTime endDate;
  @override
  @JsonKey(name: 'name')
  final String? name;
  final List<MealAssignment> _assignments;
  @override
  @JsonKey(name: 'assignments')
  List<MealAssignment> get assignments {
    if (_assignments is EqualUnmodifiableListView) return _assignments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignments);
  }

  @override
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'WeeklyPlanModel(id: $id, userId: $userId, startDate: $startDate, endDate: $endDate, name: $name, assignments: $assignments, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyPlanModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._assignments, _assignments) &&
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
      userId,
      startDate,
      endDate,
      name,
      const DeepCollectionEquality().hash(_assignments),
      createdAt,
      updatedAt);

  /// Create a copy of WeeklyPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyPlanModelImplCopyWith<_$WeeklyPlanModelImpl> get copyWith =>
      __$$WeeklyPlanModelImplCopyWithImpl<_$WeeklyPlanModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklyPlanModelImplToJson(
      this,
    );
  }
}

abstract class _WeeklyPlanModel implements WeeklyPlanModel {
  const factory _WeeklyPlanModel(
          {@JsonKey(name: 'id') required final String id,
          @JsonKey(name: 'userId') required final String userId,
          @JsonKey(name: 'startDate') required final DateTime startDate,
          @JsonKey(name: 'endDate') required final DateTime endDate,
          @JsonKey(name: 'name') final String? name,
          @JsonKey(name: 'assignments')
          required final List<MealAssignment> assignments,
          @JsonKey(name: 'createdAt') required final DateTime createdAt,
          @JsonKey(name: 'updatedAt') required final DateTime updatedAt}) =
      _$WeeklyPlanModelImpl;

  factory _WeeklyPlanModel.fromJson(Map<String, dynamic> json) =
      _$WeeklyPlanModelImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'userId')
  String get userId;
  @override
  @JsonKey(name: 'startDate')
  DateTime get startDate;
  @override
  @JsonKey(name: 'endDate')
  DateTime get endDate;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'assignments')
  List<MealAssignment> get assignments;
  @override
  @JsonKey(name: 'createdAt')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updatedAt')
  DateTime get updatedAt;

  /// Create a copy of WeeklyPlanModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklyPlanModelImplCopyWith<_$WeeklyPlanModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MealAssignment _$MealAssignmentFromJson(Map<String, dynamic> json) {
  return _MealAssignment.fromJson(json);
}

/// @nodoc
mixin _$MealAssignment {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'mealId')
  String get mealId => throw _privateConstructorUsedError;
  @JsonKey(name: 'meal')
  MealModel get meal => throw _privateConstructorUsedError;
  @JsonKey(name: 'date')
  DateTime get date => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  MealType get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'notes')
  String? get notes => throw _privateConstructorUsedError;

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
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'mealId') String mealId,
      @JsonKey(name: 'meal') MealModel meal,
      @JsonKey(name: 'date') DateTime date,
      @JsonKey(name: 'type') MealType type,
      @JsonKey(name: 'notes') String? notes});

  $MealModelCopyWith<$Res> get meal;
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
    Object? mealId = null,
    Object? meal = null,
    Object? date = null,
    Object? type = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String,
      meal: null == meal
          ? _value.meal
          : meal // ignore: cast_nullable_to_non_nullable
              as MealModel,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MealType,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of MealAssignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MealModelCopyWith<$Res> get meal {
    return $MealModelCopyWith<$Res>(_value.meal, (value) {
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
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'mealId') String mealId,
      @JsonKey(name: 'meal') MealModel meal,
      @JsonKey(name: 'date') DateTime date,
      @JsonKey(name: 'type') MealType type,
      @JsonKey(name: 'notes') String? notes});

  @override
  $MealModelCopyWith<$Res> get meal;
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
    Object? mealId = null,
    Object? meal = null,
    Object? date = null,
    Object? type = null,
    Object? notes = freezed,
  }) {
    return _then(_$MealAssignmentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      mealId: null == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String,
      meal: null == meal
          ? _value.meal
          : meal // ignore: cast_nullable_to_non_nullable
              as MealModel,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MealType,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealAssignmentImpl implements _MealAssignment {
  const _$MealAssignmentImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'mealId') required this.mealId,
      @JsonKey(name: 'meal') required this.meal,
      @JsonKey(name: 'date') required this.date,
      @JsonKey(name: 'type') required this.type,
      @JsonKey(name: 'notes') this.notes});

  factory _$MealAssignmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealAssignmentImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'mealId')
  final String mealId;
  @override
  @JsonKey(name: 'meal')
  final MealModel meal;
  @override
  @JsonKey(name: 'date')
  final DateTime date;
  @override
  @JsonKey(name: 'type')
  final MealType type;
  @override
  @JsonKey(name: 'notes')
  final String? notes;

  @override
  String toString() {
    return 'MealAssignment(id: $id, mealId: $mealId, meal: $meal, date: $date, type: $type, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealAssignmentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.mealId, mealId) || other.mealId == mealId) &&
            (identical(other.meal, meal) || other.meal == meal) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, mealId, meal, date, type, notes);

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
      {@JsonKey(name: 'id') required final String id,
      @JsonKey(name: 'mealId') required final String mealId,
      @JsonKey(name: 'meal') required final MealModel meal,
      @JsonKey(name: 'date') required final DateTime date,
      @JsonKey(name: 'type') required final MealType type,
      @JsonKey(name: 'notes') final String? notes}) = _$MealAssignmentImpl;

  factory _MealAssignment.fromJson(Map<String, dynamic> json) =
      _$MealAssignmentImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'mealId')
  String get mealId;
  @override
  @JsonKey(name: 'meal')
  MealModel get meal;
  @override
  @JsonKey(name: 'date')
  DateTime get date;
  @override
  @JsonKey(name: 'type')
  MealType get type;
  @override
  @JsonKey(name: 'notes')
  String? get notes;

  /// Create a copy of MealAssignment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealAssignmentImplCopyWith<_$MealAssignmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
