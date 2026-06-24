// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt_scanner_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ocrParserServiceHash() => r'887d1233afd649438267a43a69722da5b9f25278';

/// See also [ocrParserService].
@ProviderFor(ocrParserService)
final ocrParserServiceProvider = Provider<OcrParserService>.internal(
  ocrParserService,
  name: r'ocrParserServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ocrParserServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OcrParserServiceRef = ProviderRef<OcrParserService>;
String _$receiptScannerControllerHash() =>
    r'9c0dc4a0b6c7ffcb095ddc435d5de4f7ebbaedc7';

/// See also [ReceiptScannerController].
@ProviderFor(ReceiptScannerController)
final receiptScannerControllerProvider =
    AsyncNotifierProvider<ReceiptScannerController, ParsedReceipt?>.internal(
  ReceiptScannerController.new,
  name: r'receiptScannerControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$receiptScannerControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReceiptScannerController = AsyncNotifier<ParsedReceipt?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
