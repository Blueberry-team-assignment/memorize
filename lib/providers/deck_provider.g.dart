// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deckListNotifierHash() => r'3392bd882e9d29a03f34cfdc368d7875041dc888';

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
String _$deckNotifierHash() => r'c4fa41fc7a28b22f2a1f71bc009d1191e8073f6d';

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
  late final int id;

  FutureOr<Deck> build(
    int id,
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
    int id,
  ) {
    return DeckNotifierProvider(
      id,
    );
  }

  @override
  DeckNotifierProvider getProviderOverride(
    covariant DeckNotifierProvider provider,
  ) {
    return call(
      provider.id,
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
    int id,
  ) : this._internal(
          () => DeckNotifier()..id = id,
          from: deckNotifierProvider,
          name: r'deckNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deckNotifierHash,
          dependencies: DeckNotifierFamily._dependencies,
          allTransitiveDependencies:
              DeckNotifierFamily._allTransitiveDependencies,
          id: id,
        );

  DeckNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  FutureOr<Deck> runNotifierBuild(
    covariant DeckNotifier notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(DeckNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: DeckNotifierProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DeckNotifier, Deck> createElement() {
    return _DeckNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeckNotifierProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeckNotifierRef on AutoDisposeAsyncNotifierProviderRef<Deck> {
  /// The parameter `id` of this provider.
  int get id;
}

class _DeckNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DeckNotifier, Deck>
    with DeckNotifierRef {
  _DeckNotifierProviderElement(super.provider);

  @override
  int get id => (origin as DeckNotifierProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
