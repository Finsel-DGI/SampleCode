class CustomException implements Exception {
  String? message;
  int? code;
  CustomException(this.message, {this.code});

  String get errorMessage => message ?? '';

  @override
  String toString() {
    return '${code == null ? '' : 'Code: $code '}${message ?? ''}';
  }
}
