import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_assessment/core/storage/image_service/image_save_results.dart';
import 'package:flutter_assessment/core/storage/image_service/image_service.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class ImageSaverServiceImpl implements ImageSaverService {
  final Dio _dio;
  final Uuid _uuid = const Uuid();

  ImageSaverServiceImpl(this._dio);

  @override
  Future<ImageSaveResult> saveBytes(Uint8List bytes, {String? name}) async {
    final fileName = name ?? 'image_${_uuid.v4()}.jpg';

    try {
      final isRealDevice = await _isPhysicalDevice();

      if (isRealDevice) {
        final perm = await _ensurePermission();
        if (!perm) return ImageSaveResult.fail('Permission denied');

        final res = await ImageGallerySaver.saveImage(
          bytes,
          quality: 100,
          name: fileName,
          isReturnImagePathOfIOS: true,
        );
        final isSuccess = res['isSuccess'] == true;
        final path = res['filePath']?.toString() ?? res['file_path']?.toString();
        return isSuccess
            ? ImageSaveResult.ok(path ?? 'Saved without path')
            : ImageSaveResult.fail('Failed to save image');
      } else {
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/$fileName');
        await file.writeAsBytes(bytes);
        return ImageSaveResult.ok(file.path);
      }
    } catch (e) {
      return ImageSaveResult.fail('Error: $e');
    }
  }

  @override
  Future<ImageSaveResult> saveFromUrl(String url, {String? name}) async {
    try {
      final response = await _dio.get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.statusCode != 200) {
        return ImageSaveResult.fail('Download failed: HTTP ${response.statusCode}');
      }
      return saveBytes(Uint8List.fromList(response.data!), name: name);
    } catch (e) {
      return ImageSaveResult.fail('Network error: $e');
    }
  }

  Future<bool> _ensurePermission() async {
    if (await Permission.photos.isGranted ||
        await Permission.storage.isGranted ||
        await Permission.photosAddOnly.isGranted) {
      return true;
    }

    final statuses = await [
      Permission.photos,
      Permission.photosAddOnly,
      Permission.storage,
    ].request();

    final granted = statuses.values.any((s) => s.isGranted);
    return granted;
  }

  Future<bool> _isPhysicalDevice() async {
    return !(Platform.isAndroid || Platform.isIOS && !Platform.environment.containsKey('SIMULATOR_DEVICE_NAME'));
  }
}
