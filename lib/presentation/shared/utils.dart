import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import 'enums.dart';

EmployeeType stringToEmployeeType(String str) {
  if (str == 'EmployeeType.permenent') return EmployeeType.permenent;
  return EmployeeType.temporary;
}

String employeeTypeToString(EmployeeType employeeType) {
  if (employeeType == EmployeeType.permenent) return 'Permenent';
  return 'Temporary';
}

Future<String?> seletDOB(context) async {
  final dob = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now().subtract(
      const Duration(days: 365 * 100),
    ),
    lastDate: DateTime.now(),
  );
  if (dob != null) {
    final str = Jiffy(dob).format('dd/MM/yyyy');
    print(str);
    return str;
  }
  return null;
}

bool validateEmail(String value) {
  const pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  return regex.hasMatch(value);
}

bool validateMobile(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = RegExp(patttern);
  if (value.length < 10) {
    return false;
  }
  return regExp.hasMatch(value);
}
