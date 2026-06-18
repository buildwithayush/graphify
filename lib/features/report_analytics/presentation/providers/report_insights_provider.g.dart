// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_insights_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reportAnalyticsRepositoryHash() =>
    r'63b991b916aa6be6cdb372c2dcdc12b54c854570';

/// See also [reportAnalyticsRepository].
@ProviderFor(reportAnalyticsRepository)
final reportAnalyticsRepositoryProvider =
    AutoDisposeProvider<ReportAnalyticsRepository>.internal(
  reportAnalyticsRepository,
  name: r'reportAnalyticsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reportAnalyticsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReportAnalyticsRepositoryRef
    = AutoDisposeProviderRef<ReportAnalyticsRepository>;
String _$reportAnalyticsServiceHash() =>
    r'05edf2fc8ec0ee0be1b8e68bb43fd90553906fcf';

/// See also [reportAnalyticsService].
@ProviderFor(reportAnalyticsService)
final reportAnalyticsServiceProvider =
    AutoDisposeProvider<ReportAnalyticsService>.internal(
  reportAnalyticsService,
  name: r'reportAnalyticsServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reportAnalyticsServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReportAnalyticsServiceRef
    = AutoDisposeProviderRef<ReportAnalyticsService>;
String _$rollingInsightsHash() => r'c2ca4ce6a745504bc5d7d47a2e7659dfcdb3e526';

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

/// See also [rollingInsights].
@ProviderFor(rollingInsights)
const rollingInsightsProvider = RollingInsightsFamily();

/// See also [rollingInsights].
class RollingInsightsFamily extends Family<AsyncValue<PeriodInsight>> {
  /// See also [rollingInsights].
  const RollingInsightsFamily();

  /// See also [rollingInsights].
  RollingInsightsProvider call(
    String mode,
  ) {
    return RollingInsightsProvider(
      mode,
    );
  }

  @override
  RollingInsightsProvider getProviderOverride(
    covariant RollingInsightsProvider provider,
  ) {
    return call(
      provider.mode,
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
  String? get name => r'rollingInsightsProvider';
}

/// See also [rollingInsights].
class RollingInsightsProvider extends AutoDisposeFutureProvider<PeriodInsight> {
  /// See also [rollingInsights].
  RollingInsightsProvider(
    String mode,
  ) : this._internal(
          (ref) => rollingInsights(
            ref as RollingInsightsRef,
            mode,
          ),
          from: rollingInsightsProvider,
          name: r'rollingInsightsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$rollingInsightsHash,
          dependencies: RollingInsightsFamily._dependencies,
          allTransitiveDependencies:
              RollingInsightsFamily._allTransitiveDependencies,
          mode: mode,
        );

  RollingInsightsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.mode,
  }) : super.internal();

  final String mode;

  @override
  Override overrideWith(
    FutureOr<PeriodInsight> Function(RollingInsightsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RollingInsightsProvider._internal(
        (ref) => create(ref as RollingInsightsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        mode: mode,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<PeriodInsight> createElement() {
    return _RollingInsightsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RollingInsightsProvider && other.mode == mode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, mode.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RollingInsightsRef on AutoDisposeFutureProviderRef<PeriodInsight> {
  /// The parameter `mode` of this provider.
  String get mode;
}

class _RollingInsightsProviderElement
    extends AutoDisposeFutureProviderElement<PeriodInsight>
    with RollingInsightsRef {
  _RollingInsightsProviderElement(super.provider);

  @override
  String get mode => (origin as RollingInsightsProvider).mode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
