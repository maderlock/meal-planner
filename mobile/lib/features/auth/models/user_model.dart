import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    String? username,
    String? firebaseUid,
    String? displayName,
    String? photoUrl,
    @Default(false) bool emailVerified,
    @Default(null) DateTime? createdAt,
    @Default(null) DateTime? updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  factory UserModel.fromFirebase(Map<String, dynamic> json) {
    return UserModel(
      id: json['uid'] as String,
      email: json['email'] as String,
      firebaseUid: json['uid'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoURL'] as String?,
      emailVerified: json['emailVerified'] as bool? ?? false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
