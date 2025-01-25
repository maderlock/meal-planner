// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isAuthenticatedHash() => r'f290f99cb8c31b2d16ed5a9e863765cee418fb7a';

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
String _$userDisplayNameHash() => r'1a9da2639ae1624eeeebde11c43dc28ee7a43b98';

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
String _$userEmailHash() => r'36af09a54e347e5564db624742ef38d64b4822c6';

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
String _$userPhotoUrlHash() => r'23eb5b612af639fc01d9623fb7b36076fe0a200b';

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
