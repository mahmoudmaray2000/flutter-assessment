class NetworkResponse<T> {
  final T data;
  final bool success;
  final String message;

  NetworkResponse(this.data, this.success, this.message);
}