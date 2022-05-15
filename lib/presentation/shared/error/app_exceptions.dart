abstract class AppException {
  String? get statusCode;
  String? get message;
}

class ApiException extends AppException {
  String? code;
  String? msg;

  ApiException(
    this.code,
    this.msg,
  );
  @override
  String? get message => msg;

  @override
  String? get statusCode => code;

  @override
  String toString() {
    return 'Code : $code, Message : $msg';
  }
}
