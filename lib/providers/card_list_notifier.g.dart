// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cardListNotifierHash() => r'60de1ce8d8c83faaba5cb4585ba9ca1597e69888';

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

abstract class _$CardListNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<Card>> {
  late final int id;

  FutureOr<List<Card>> build(
    int id,
  );
}

/// See also [CardListNotifier].
@ProviderFor(CardListNotifier)
const cardListNotifierProvider = CardListNotifierFamily();

/// See also [CardListNotifier].
class CardListNotifierFamily extends Family<AsyncValue<List<Card>>> {
  /// See also [CardListNotifier].
  const CardListNotifierFamily();

  /// See also [CardListNotifier].
  CardListNotifierProvider call(
    int id,
  ) {
    return CardListNotifierProvider(
      id,
    );
  }

  @override
  CardListNotifierProvider getProviderOverride(
    covariant CardListNotifierProvider provider,
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
  String? get name => r'cardListNotifierProvider';
}

/// See also [CardListNotifier].
class CardListNotifierProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CardListNotifier, List<Card>> {
  /// See also [CardListNotifier].
  CardListNotifierProvider(
    int id,
  ) : this._internal(
          () => CardListNotifier()..id = id,
          from: cardListNotifierProvider,
          name: r'cardListNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cardListNotifierHash,
          dependencies: CardListNotifierFamily._dependencies,
          allTransitiveDependencies:
              CardListNotifierFamily._allTransitiveDependencies,
          id: id,
        );

  CardListNotifierProvider._internal(
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
  FutureOr<List<Card>> runNotifierBuild(
    covariant CardListNotifier notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(CardListNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: CardListNotifierProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<CardListNotifier, List<Card>>
      createElement() {
    return _CardListNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CardListNotifierProvider && other.id == id;
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
mixin CardListNotifierRef on AutoDisposeAsyncNotifierProviderRef<List<Card>> {
  /// The parameter `id` of this provider.
  int get id;
}

class _CardListNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CardListNotifier,
        List<Card>> with CardListNotifierRef {
  _CardListNotifierProviderElement(super.provider);

  @override
  int get id => (origin as CardListNotifierProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
