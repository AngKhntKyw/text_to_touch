class Failure {
  final int statusCode;
  final String message;

  Failure([
    this.statusCode = 500,
    this.message = "An unexpected error occurred.",
  ]);
}
