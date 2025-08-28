class NetworkException implements Exception {
  final int? statusCode;
  final String message;
  final String? type;

  NetworkException({this.statusCode, required this.message, this.type});

  @override
  String toString() => 'NetworkException($statusCode, $type): $message';
}