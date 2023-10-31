class HttpException implements Exception {
  final int statusCode;
  final String title;
  final String description;

  HttpException({
    required this.statusCode,
    required this.title,
    required this.description,
  });
}
