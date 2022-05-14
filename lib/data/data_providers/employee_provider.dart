import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../presentation/shared/error/write_exception.dart';

const String api = 'http://192.168.1.12/mypos_employee_management_api/employee';
const String apiImages = 'http://192.168.1.12/mypos_employee_management_api';

class EmployeeProvider {
  Future<ApiException?> uploadImage({
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
      return ApiException(response.statusCode.toString(), response.body);
    } on SocketException {
      return ApiException('SocketException', 'No internet connection');
    }
  }

  Future<ApiException?> addEmployee(Map<String, dynamic> json) async {
    try {
      final response =
          await http.post(Uri.parse('$api/addEmployee'), body: json);
      if (response.statusCode == 200) {
        return null;
      } else {
        return ApiException(response.statusCode.toString(), response.body);
      }
    } on SocketException {
      return ApiException('SocketException', 'No internet connection');
    }
  }

  Future<Either<ApiException, List<Map<String, dynamic>>>>
      fetchEmployees() async {
    try {
      final response = await http.get(Uri.parse('$api/fetchEmployees'));
      print(response.body);
      if (response.statusCode == 200) {
        return Right(json.decode(response.body).cast<Map<String, dynamic>>());
      }
      return Left(ApiException(response.statusCode.toString(), response.body));
    } on SocketException {
      return Left(ApiException('SocketException', 'No internet connection'));
    }
  }

  Future<Either<ApiException, List<Map<String, dynamic>>>> search(
      String term) async {
    try {
      final response =
          await http.post(Uri.parse('$api/searchEmployees'), body: {
        "term": term,
      });
      if (response.statusCode == 200) {
        return Right(json.decode(response.body).cast<Map<String, dynamic>>());
      }
      return Left(ApiException(response.statusCode.toString(), response.body));
    } on SocketException {
      return Left(ApiException('SocketException', 'No internet connection'));
    }
  }

  Future<Either<ApiException, bool>> delete(String id) async {
    try {
      final res = await http.post(Uri.parse('$api/deleteEmployee'), body: {
        "id": id,
      });
      print(res.body);
      if (res.statusCode == 200) {
        return Right(json.decode(res.body));
      }
      return Left(ApiException(res.statusCode.toString(), res.body));
    } on SocketException {
      return Left(ApiException('SocketException', 'No internet connection'));
    }
  }
}
