// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deckNotifierHash() => r'c35c025f9ead155da372b4587744b10c05bc1c77';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$DeckNotifier extends BuildlessAutoDisposeAsyncNotifier<Deck> {
  late final int deckId;

  FutureOr<Deck> build(
    int deckId,
  );
}

/// See also [DeckNotifier].
@ProviderFor(DeckNotifier)
const deckNotifierProvider = DeckNotifierFamily();

/// See also [DeckNotifier].
class DeckNotifierFamily extends Family<AsyncValue<Deck>> {
  /// See also [DeckNotifier].
  const DeckNotifierFamily();

  /// See also [DeckNotifier].
  DeckNotifierProvider call(
    int deckId,
  ) {
    return DeckNotifierProvider(
      deckId,
    );
  }

  @override
  DeckNotifierProvider getProviderOverride(
    covariant DeckNotifierProvider provider,
  ) {
    return call(
      provider.deckId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'deckNotifierProvider';
}

/// See also [DeckNotifier].
class DeckNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DeckNotifier, Deck> {
  /// See also [DeckNotifier].
  DeckNotifierProvider(
    int deckId,
  ) : this._internal(
          () => DeckNotifier()..deckId = deckId,
          from: deckNotifierProvider,
          name: r'deckNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deckNotifierHash,
          dependencies: DeckNotifierFamily._dependencies,
          allTransitiveDependencies:
              DeckNotifierFamily._allTransitiveDependencies,
          deckId: deckId,
        );

  DeckNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.deckId,
  }) : super.internal();

  final int deckId;

  @override
  FutureOr<Deck> runNotifierBuild(
    covariant DeckNotifier notifier,
  ) {
    return notifier.build(
      deckId,
    );
  }

  @override
  Override overrideWith(DeckNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: DeckNotifierProvider._internal(
        () => create()..deckId = deckId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        deckId: deckId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DeckNotifier, Deck> createElement() {
    return _DeckNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeckNotifierProvider && other.deckId == deckId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, deckId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeckNotifierRef on AutoDisposeAsyncNotifierProviderRef<Deck> {
  /// The parameter `deckId` of this provider.
  int get deckId;
}

class _DeckNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DeckNotifier, Deck>
    with DeckNotifierRef {
  _DeckNotifierProviderElement(super.provider);

  @override
  int get deckId => (origin as DeckNotifierProvider).deckId;
}

String _$deckListNotifierHash() => r'93b1652334f19717373c56a743cb678b953a4e35';

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
