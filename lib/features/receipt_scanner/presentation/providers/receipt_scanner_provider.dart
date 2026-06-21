import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:graphify/features/receipt_scanner/core/services/ocr_parser_service.dart';
import 'package:graphify/features/receipt_scanner/domain/models/parsed_recipt.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'receipt_scanner_provider.g.dart';

@Riverpod(keepAlive: true)
OcrParserService ocrParserService(OcrParserServiceRef ref) {
  final service = OcrParserService();
  ref.onDispose(() => service.dispose());
  return service;
}

@Riverpod(keepAlive: true)
class ReceiptScannerController extends _$ReceiptScannerController {
  final ImagePicker _imagePicker = ImagePicker();

  @override
  FutureOr<ParsedReceipt?> build() {
    return null; 
  }

  /// Main Image Processing Engine Pipeline
  Future<void> scanReceipt({
    required ImageSource source,
    required BuildContext context,
  }) async {
    try {
      state = const AsyncLoading();

      final result = await AsyncValue.guard<ParsedReceipt?>(() async {
        // 1. Native Image Picker
        final pickedFile = await _imagePicker.pickImage(
          source: source,
          imageQuality: 90,
        );

        if (pickedFile == null) {
          debugPrint("OCR LOG: Selection Cancelled by User");
          return null;
        }

        //  Native Image Cropper Screen Call
        final croppedFile = await _cropImage(pickedFile.path, context);

        if (croppedFile == null) {
          return null;
        }

        //  OCR Parser Service read
        final ocrEngine = ref.read(ocrParserServiceProvider);

        return await ocrEngine.parsedReciptImage(File(croppedFile.path));
      });

      state = result;
    } catch (e, st) {
      debugPrint("OCR ERROR => $e");
      debugPrintStack(stackTrace: st);
      state = AsyncValue.error(e, st);
    }
  }

  ///  Native Platform Cropping Configurations Interface
  Future<CroppedFile?> _cropImage(
    String sourcePath,
    BuildContext context,
  ) async {
    final theme = Theme.of(context);

    return await ImageCropper().cropImage(
      sourcePath: sourcePath,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop your Bill Receipt ✂️',
          toolbarColor: theme.colorScheme.surface,
          toolbarWidgetColor: theme.colorScheme.onSurface,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          activeControlsWidgetColor: theme.colorScheme.primary,
        ),
        IOSUiSettings(
          title: 'Crop Your Bill Receipt ✂️',
          aspectRatioLockEnabled: false,
        ),
      ],
    );
  }
}
