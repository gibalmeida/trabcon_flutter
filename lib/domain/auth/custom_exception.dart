class CustomException implements Exception {
  final String? message;
  const CustomException({this.message = 'Algo saiu errado!'});

  @override
  String toString() => 'CustomException { message: $message }';
}
