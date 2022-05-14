// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mypos_emp_management/presentation/shared/enums.dart';
import 'package:mypos_emp_management/presentation/shared/utils.dart';

class EmployeeModel {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String dob;
  final EmployeeType type;
  final String url;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.dob,
    required this.type,
    required this.url,
  });

  EmployeeModel copyWith({
    String? id,
    String? name,
    String? email,
    String? mobile,
    String? dob,
    EmployeeType? type,
    String? url,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      dob: dob ?? this.dob,
      type: type ?? this.type,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      mobile: map['mobile'] as String,
      dob: map['dob'] as String,
      type: stringToEmployeeType(map['type'] as String),
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeModel.fromJson(String source) =>
      EmployeeModel.fromMap(json.decode(source) as Map<String, dynamic>);

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
