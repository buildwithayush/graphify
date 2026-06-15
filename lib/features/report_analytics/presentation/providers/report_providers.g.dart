// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reportRepositoryHash() => r'4f93f6e8cb63b08949b057b59bbab0a90230e3cc';

/// See also [reportRepository].
@ProviderFor(reportRepository)
final reportRepositoryProvider = AutoDisposeProvider<ReportRepository>.internal(
  reportRepository,
  name: r'reportRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reportRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReportRepositoryRef = AutoDisposeProviderRef<ReportRepository>;
String _$reportServiceHash() => r'8f3cd446921781cf2ecc06703c2c175b7af0afc1';

/// See also [reportService].
@ProviderFor(reportService)
final reportServiceProvider = AutoDisposeProvider<ReportService>.internal(
  reportService,
  name: r'reportServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reportServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReportServiceRef = AutoDisposeProviderRef<ReportService>;
String _$monthlyReportHistoryHash() =>
    r'dbb2a1515f9ded49fe4604b9c415ce4739a052f2';

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

/// See also [monthlyReportHistory].
@ProviderFor(monthlyReportHistory)
const monthlyReportHistoryProvider = MonthlyReportHistoryFamily();

/// See also [monthlyReportHistory].
class MonthlyReportHistoryFamily extends Family<AsyncValue<MonthlyReport?>> {
  /// See also [monthlyReportHistory].
  const MonthlyReportHistoryFamily();

  /// See also [monthlyReportHistory].
  MonthlyReportHistoryProvider call(
    String monthYear,
  ) {
    return MonthlyReportHistoryProvider(
      monthYear,
    );
  }

  @override
  MonthlyReportHistoryProvider getProviderOverride(
    covariant MonthlyReportHistoryProvider provider,
  ) {
    return call(
      provider.monthYear,
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
  String? get name => r'monthlyReportHistoryProvider';
}

/// See also [monthlyReportHistory].
class MonthlyReportHistoryProvider
    extends AutoDisposeStreamProvider<MonthlyReport?> {
  /// See also [monthlyReportHistory].
  MonthlyReportHistoryProvider(
    String monthYear,
  ) : this._internal(
          (ref) => monthlyReportHistory(
            ref as MonthlyReportHistoryRef,
            monthYear,
          ),
          from: monthlyReportHistoryProvider,
          name: r'monthlyReportHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$monthlyReportHistoryHash,
          dependencies: MonthlyReportHistoryFamily._dependencies,
          allTransitiveDependencies:
              MonthlyReportHistoryFamily._allTransitiveDependencies,
          monthYear: monthYear,
        );

  MonthlyReportHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.monthYear,
  }) : super.internal();

  final String monthYear;

  @override
  Override overrideWith(
    Stream<MonthlyReport?> Function(MonthlyReportHistoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MonthlyReportHistoryProvider._internal(
        (ref) => create(ref as MonthlyReportHistoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        monthYear: monthYear,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<MonthlyReport?> createElement() {
    return _MonthlyReportHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MonthlyReportHistoryProvider &&
        other.monthYear == monthYear;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, monthYear.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MonthlyReportHistoryRef on AutoDisposeStreamProviderRef<MonthlyReport?> {
  /// The parameter `monthYear` of this provider.
  String get monthYear;
}

class _MonthlyReportHistoryProviderElement
    extends AutoDisposeStreamProviderElement<MonthlyReport?>
    with MonthlyReportHistoryRef {
  _MonthlyReportHistoryProviderElement(super.provider);

  @override
  String get monthYear => (origin as MonthlyReportHistoryProvider).monthYear;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
