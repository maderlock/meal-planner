// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isAuthenticatedHash() => r'43824f6e04a454e8f49a718d72832871743985a1';

/// Provider for checking if a user is authenticated
///
/// Copied from [isAuthenticated].
@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = AutoDisposeProvider<bool>.internal(
  isAuthenticated,
  name: r'isAuthenticatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAuthenticatedRef = AutoDisposeProviderRef<bool>;
String _$userDisplayNameHash() => r'2cbd9846d56955bead3f33c5c3ca9d51e42fc8d9';

/// Provider for the user's display name
///
/// Copied from [userDisplayName].
@ProviderFor(userDisplayName)
final userDisplayNameProvider = AutoDisposeProvider<String?>.internal(
  userDisplayName,
  name: r'userDisplayNameProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userDisplayNameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserDisplayNameRef = AutoDisposeProviderRef<String?>;
String _$userEmailHash() => r'0a27a1651ee99062f4b5dfa0e1894107599bc3f3';

/// Provider for the user's email
///
/// Copied from [userEmail].
@ProviderFor(userEmail)
final userEmailProvider = AutoDisposeProvider<String?>.internal(
  userEmail,
  name: r'userEmailProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userEmailHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserEmailRef = AutoDisposeProviderRef<String?>;
String _$userPhotoUrlHash() => r'94e60456f4e38ffbdf213761058ac30fe7498c29';

/// Provider for the user's photo URL
///
/// Copied from [userPhotoUrl].
@ProviderFor(userPhotoUrl)
final userPhotoUrlProvider = AutoDisposeProvider<String?>.internal(
  userPhotoUrl,
  name: r'userPhotoUrlProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userPhotoUrlHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserPhotoUrlRef = AutoDisposeProviderRef<String?>;
String _$authStateHash() => r'4821495119f292fb78982bc1bb305198f94810f7';

/// Provider for the current authentication state
///
/// Copied from [AuthState].
@ProviderFor(AuthState)
final authStateProvider =
    AutoDisposeNotifierProvider<AuthState, UserModel?>.internal(
  AuthState.new,
  name: r'authStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthState = AutoDisposeNotifier<UserModel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
