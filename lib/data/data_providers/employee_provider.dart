import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../presentation/shared/error/write_exception.dart';

class EmployeeProvider {
  static const String api =
      'http://192.168.1.12/mypos_employee_management_api/employee';
  Future<UploadException?> uploadImage({
    required String base64Image,
    required String fileName,
  }) async {
    try {
      final response = await http.post(Uri.parse('$api/uploadImage'), body: {
        "image": base64Image,
        "name": fileName,
      });
      if (response.statusCode == 200) {
        return null;
      }
      return UploadException(response.statusCode.toString(), response.body);
    } on SocketException {
      return UploadException('SocketException', 'No internet connection');
    }
  }

  Future<EmployeeWriteException?> addEmployee(Map<String, dynamic> json) async {
    try {
      final response =
          await http.post(Uri.parse('$api/addEmployee'), body: json);
      if (response.statusCode == 200) {
        return null;
      } else {
        return EmployeeWriteException(
            response.statusCode.toString(), response.body);
      }
    } on SocketException {
      return EmployeeWriteException(
          'SocketException', 'No internet connection');
    }
  }
}
