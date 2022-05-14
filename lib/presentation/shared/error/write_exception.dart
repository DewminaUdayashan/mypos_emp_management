abstract class ApiException {
  String? get statusCode;
  String? get message;
}

class UploadException extends ApiException {
  String? code;
  String? msg;

  UploadException(
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

class EmployeeWriteException extends ApiException {
  String? code;
  String? msg;

  EmployeeWriteException(
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
