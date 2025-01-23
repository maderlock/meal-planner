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

WeeklyPlan _$WeeklyPlanFromJson(Map<String, dynamic> json) {
  return _WeeklyPlan.fromJson(json);
}

/// @nodoc
mixin _$WeeklyPlan {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  List<MealAssignment> get assignments => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this WeeklyPlan to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeeklyPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeeklyPlanCopyWith<WeeklyPlan> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeeklyPlanCopyWith<$Res> {
  factory $WeeklyPlanCopyWith(
          WeeklyPlan value, $Res Function(WeeklyPlan) then) =
      _$WeeklyPlanCopyWithImpl<$Res, WeeklyPlan>;
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime startDate,
      DateTime endDate,
      List<MealAssignment> assignments,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$WeeklyPlanCopyWithImpl<$Res, $Val extends WeeklyPlan>
    implements $WeeklyPlanCopyWith<$Res> {
  _$WeeklyPlanCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeeklyPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? startDate = null,
    Object? endDate = null,
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
abstract class _$$WeeklyPlanImplCopyWith<$Res>
    implements $WeeklyPlanCopyWith<$Res> {
  factory _$$WeeklyPlanImplCopyWith(
          _$WeeklyPlanImpl value, $Res Function(_$WeeklyPlanImpl) then) =
      __$$WeeklyPlanImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      DateTime startDate,
      DateTime endDate,
      List<MealAssignment> assignments,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$WeeklyPlanImplCopyWithImpl<$Res>
    extends _$WeeklyPlanCopyWithImpl<$Res, _$WeeklyPlanImpl>
    implements _$$WeeklyPlanImplCopyWith<$Res> {
  __$$WeeklyPlanImplCopyWithImpl(
      _$WeeklyPlanImpl _value, $Res Function(_$WeeklyPlanImpl) _then)
      : super(_value, _then);

  /// Create a copy of WeeklyPlan
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? assignments = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$WeeklyPlanImpl(
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
class _$WeeklyPlanImpl implements _WeeklyPlan {
  const _$WeeklyPlanImpl(
      {required this.id,
      required this.userId,
      required this.startDate,
      required this.endDate,
      required final List<MealAssignment> assignments,
      required this.createdAt,
      required this.updatedAt})
      : _assignments = assignments;

  factory _$WeeklyPlanImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklyPlanImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  final List<MealAssignment> _assignments;
  @override
  List<MealAssignment> get assignments {
    if (_assignments is EqualUnmodifiableListView) return _assignments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignments);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'WeeklyPlan(id: $id, userId: $userId, startDate: $startDate, endDate: $endDate, assignments: $assignments, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyPlanImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality()
                .equals(other._assignments, _assignments) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, startDate, endDate,
      const DeepCollectionEquality().hash(_assignments), createdAt, updatedAt);

  /// Create a copy of WeeklyPlan
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyPlanImplCopyWith<_$WeeklyPlanImpl> get copyWith =>
      __$$WeeklyPlanImplCopyWithImpl<_$WeeklyPlanImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklyPlanImplToJson(
      this,
    );
  }
}

abstract class _WeeklyPlan implements WeeklyPlan {
  const factory _WeeklyPlan(
      {required final String id,
      required final String userId,
      required final DateTime startDate,
      required final DateTime endDate,
      required final List<MealAssignment> assignments,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$WeeklyPlanImpl;

  factory _WeeklyPlan.fromJson(Map<String, dynamic> json) =
      _$WeeklyPlanImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  List<MealAssignment> get assignments;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of WeeklyPlan
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklyPlanImplCopyWith<_$WeeklyPlanImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateWeeklyPlanRequest _$CreateWeeklyPlanRequestFromJson(
    Map<String, dynamic> json) {
  return _CreateWeeklyPlanRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateWeeklyPlanRequest {
  String get userId => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;

  /// Serializes this CreateWeeklyPlanRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateWeeklyPlanRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateWeeklyPlanRequestCopyWith<CreateWeeklyPlanRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateWeeklyPlanRequestCopyWith<$Res> {
  factory $CreateWeeklyPlanRequestCopyWith(CreateWeeklyPlanRequest value,
          $Res Function(CreateWeeklyPlanRequest) then) =
      _$CreateWeeklyPlanRequestCopyWithImpl<$Res, CreateWeeklyPlanRequest>;
  @useResult
  $Res call({String userId, DateTime startDate, DateTime endDate});
}

/// @nodoc
class _$CreateWeeklyPlanRequestCopyWithImpl<$Res,
        $Val extends CreateWeeklyPlanRequest>
    implements $CreateWeeklyPlanRequestCopyWith<$Res> {
  _$CreateWeeklyPlanRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateWeeklyPlanRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_value.copyWith(
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateWeeklyPlanRequestImplCopyWith<$Res>
    implements $CreateWeeklyPlanRequestCopyWith<$Res> {
  factory _$$CreateWeeklyPlanRequestImplCopyWith(
          _$CreateWeeklyPlanRequestImpl value,
          $Res Function(_$CreateWeeklyPlanRequestImpl) then) =
      __$$CreateWeeklyPlanRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, DateTime startDate, DateTime endDate});
}

/// @nodoc
class __$$CreateWeeklyPlanRequestImplCopyWithImpl<$Res>
    extends _$CreateWeeklyPlanRequestCopyWithImpl<$Res,
        _$CreateWeeklyPlanRequestImpl>
    implements _$$CreateWeeklyPlanRequestImplCopyWith<$Res> {
  __$$CreateWeeklyPlanRequestImplCopyWithImpl(
      _$CreateWeeklyPlanRequestImpl _value,
      $Res Function(_$CreateWeeklyPlanRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateWeeklyPlanRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_$CreateWeeklyPlanRequestImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateWeeklyPlanRequestImpl implements _CreateWeeklyPlanRequest {
  const _$CreateWeeklyPlanRequestImpl(
      {required this.userId, required this.startDate, required this.endDate});

  factory _$CreateWeeklyPlanRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateWeeklyPlanRequestImplFromJson(json);

  @override
  final String userId;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  @override
  String toString() {
    return 'CreateWeeklyPlanRequest(userId: $userId, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateWeeklyPlanRequestImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, startDate, endDate);

  /// Create a copy of CreateWeeklyPlanRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateWeeklyPlanRequestImplCopyWith<_$CreateWeeklyPlanRequestImpl>
      get copyWith => __$$CreateWeeklyPlanRequestImplCopyWithImpl<
          _$CreateWeeklyPlanRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateWeeklyPlanRequestImplToJson(
      this,
    );
  }
}

abstract class _CreateWeeklyPlanRequest implements CreateWeeklyPlanRequest {
  const factory _CreateWeeklyPlanRequest(
      {required final String userId,
      required final DateTime startDate,
      required final DateTime endDate}) = _$CreateWeeklyPlanRequestImpl;

  factory _CreateWeeklyPlanRequest.fromJson(Map<String, dynamic> json) =
      _$CreateWeeklyPlanRequestImpl.fromJson;

  @override
  String get userId;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;

  /// Create a copy of CreateWeeklyPlanRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateWeeklyPlanRequestImplCopyWith<_$CreateWeeklyPlanRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

UpdateWeeklyPlanRequest _$UpdateWeeklyPlanRequestFromJson(
    Map<String, dynamic> json) {
  return _UpdateWeeklyPlanRequest.fromJson(json);
}

/// @nodoc
mixin _$UpdateWeeklyPlanRequest {
  String get id => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;

  /// Serializes this UpdateWeeklyPlanRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateWeeklyPlanRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateWeeklyPlanRequestCopyWith<UpdateWeeklyPlanRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateWeeklyPlanRequestCopyWith<$Res> {
  factory $UpdateWeeklyPlanRequestCopyWith(UpdateWeeklyPlanRequest value,
          $Res Function(UpdateWeeklyPlanRequest) then) =
      _$UpdateWeeklyPlanRequestCopyWithImpl<$Res, UpdateWeeklyPlanRequest>;
  @useResult
  $Res call({String id, DateTime startDate, DateTime endDate});
}

/// @nodoc
class _$UpdateWeeklyPlanRequestCopyWithImpl<$Res,
        $Val extends UpdateWeeklyPlanRequest>
    implements $UpdateWeeklyPlanRequestCopyWith<$Res> {
  _$UpdateWeeklyPlanRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateWeeklyPlanRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateWeeklyPlanRequestImplCopyWith<$Res>
    implements $UpdateWeeklyPlanRequestCopyWith<$Res> {
  factory _$$UpdateWeeklyPlanRequestImplCopyWith(
          _$UpdateWeeklyPlanRequestImpl value,
          $Res Function(_$UpdateWeeklyPlanRequestImpl) then) =
      __$$UpdateWeeklyPlanRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, DateTime startDate, DateTime endDate});
}

/// @nodoc
class __$$UpdateWeeklyPlanRequestImplCopyWithImpl<$Res>
    extends _$UpdateWeeklyPlanRequestCopyWithImpl<$Res,
        _$UpdateWeeklyPlanRequestImpl>
    implements _$$UpdateWeeklyPlanRequestImplCopyWith<$Res> {
  __$$UpdateWeeklyPlanRequestImplCopyWithImpl(
      _$UpdateWeeklyPlanRequestImpl _value,
      $Res Function(_$UpdateWeeklyPlanRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateWeeklyPlanRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_$UpdateWeeklyPlanRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateWeeklyPlanRequestImpl implements _UpdateWeeklyPlanRequest {
  const _$UpdateWeeklyPlanRequestImpl(
      {required this.id, required this.startDate, required this.endDate});

  factory _$UpdateWeeklyPlanRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateWeeklyPlanRequestImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  @override
  String toString() {
    return 'UpdateWeeklyPlanRequest(id: $id, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateWeeklyPlanRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, startDate, endDate);

  /// Create a copy of UpdateWeeklyPlanRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateWeeklyPlanRequestImplCopyWith<_$UpdateWeeklyPlanRequestImpl>
      get copyWith => __$$UpdateWeeklyPlanRequestImplCopyWithImpl<
          _$UpdateWeeklyPlanRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateWeeklyPlanRequestImplToJson(
      this,
    );
  }
}

abstract class _UpdateWeeklyPlanRequest implements UpdateWeeklyPlanRequest {
  const factory _UpdateWeeklyPlanRequest(
      {required final String id,
      required final DateTime startDate,
      required final DateTime endDate}) = _$UpdateWeeklyPlanRequestImpl;

  factory _UpdateWeeklyPlanRequest.fromJson(Map<String, dynamic> json) =
      _$UpdateWeeklyPlanRequestImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;

  /// Create a copy of UpdateWeeklyPlanRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateWeeklyPlanRequestImplCopyWith<_$UpdateWeeklyPlanRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
