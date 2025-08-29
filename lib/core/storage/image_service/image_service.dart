import 'dart:typed_data';

import 'package:flutter_assessment/core/storage/image_service/image_save_results.dart';

abstract class ImageSaverService {
  Future<ImageSaveResult> saveBytes(Uint8List bytes, {String? name});

  Future<ImageSaveResult> saveFromUrl(String url, {String? name});
}
