// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deckRepositoryHash() => r'90433b424fac1ae1eb59f0a94bdcd4bfbf6c4dd6';

/// See also [deckRepository].
@ProviderFor(deckRepository)
final deckRepositoryProvider = AutoDisposeProvider<DeckRepository>.internal(
  deckRepository,
  name: r'deckRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deckRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeckRepositoryRef = AutoDisposeProviderRef<DeckRepository>;
String _$deckListNotifierHash() => r'8242369a6d15b546ca22ac9be712be334c3bcd1d';

/// See also [DeckListNotifier].
@ProviderFor(DeckListNotifier)
final deckListNotifierProvider =
    AutoDisposeAsyncNotifierProvider<DeckListNotifier, List<Deck>>.internal(
  DeckListNotifier.new,
  name: r'deckListNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deckListNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeckListNotifier = AutoDisposeAsyncNotifier<List<Deck>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
