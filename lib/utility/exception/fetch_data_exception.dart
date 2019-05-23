class FetchDataException implements Exception {
  final message;
  FetchDataException({this.message = 'Failed to load data'});
}