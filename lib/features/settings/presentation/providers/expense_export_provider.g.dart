// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_export_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$csvExportServiceHash() => r'94d0033103208cafe692484385526014464d43f2';

/// See also [csvExportService].
@ProviderFor(csvExportService)
final csvExportServiceProvider = AutoDisposeProvider<CsvExportService>.internal(
  csvExportService,
  name: r'csvExportServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$csvExportServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CsvExportServiceRef = AutoDisposeProviderRef<CsvExportService>;
String _$expenseExportControllerHash() =>
    r'13e5f30909d7ee777b3098679e0c9ad086cc5f07';

/// See also [ExpenseExportController].
@ProviderFor(ExpenseExportController)
final expenseExportControllerProvider =
    AutoDisposeAsyncNotifierProvider<ExpenseExportController, void>.internal(
  ExpenseExportController.new,
  name: r'expenseExportControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expenseExportControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExpenseExportController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
