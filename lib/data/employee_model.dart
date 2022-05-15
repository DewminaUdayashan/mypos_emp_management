// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mypos_emp_management/presentation/shared/enums.dart';
import 'package:mypos_emp_management/presentation/shared/utils.dart';

class EmployeeModel {
  final String autId;
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String dob;
  final EmployeeType type;
  String url;

  EmployeeModel({
    required this.autId,
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.dob,
    required this.type,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "aut_id": autId,
      "id": id,
      "name": name,
      "email": email,
      "mobile": mobile,
      "dob": dob,
      "type": type.toString(),
      "url": url,
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      autId: map["aut_id"].toString(),
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      mobile: map['mobile'] as String,
      dob: map['dob'] as String,
      type: stringToEmployeeType(map['type'] as String),
      url: map['url'] as String,
    );
  }

  @override
  String toString() {
    return 'EmployeeModel(id: $id, name: $name, email: $email, mobile: $mobile, dob: $dob, type: $type, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmployeeModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.mobile == mobile &&
        other.dob == dob &&
        other.type == type &&
        other.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        mobile.hashCode ^
        dob.hashCode ^
        type.hashCode ^
        url.hashCode;
  }
}
