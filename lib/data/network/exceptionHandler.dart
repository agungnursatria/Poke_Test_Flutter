class FetchDataException implements Exception {
  final message;

  FetchDataException([this.message]);

  String get getMessage => message;

  String toString() {
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}