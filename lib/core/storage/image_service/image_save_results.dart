

class ImageSaveResult {
  final bool success;
  final String? filePath;
  final String? message;

  const ImageSaveResult({
    required this.success,
    this.filePath,
    this.message,
  });
  factory ImageSaveResult.ok(String? path) {
    return ImageSaveResult(success: true, filePath: path);
  }
  factory ImageSaveResult.fail(String msg) {
    return ImageSaveResult(success: false, message: msg);
  }
}
