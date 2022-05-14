import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

import 'enums.dart';

EmployeeType stringToEmployeeType(String str) {
  if (str == 'EmployeeType.permenent') return EmployeeType.permenent;
  return EmployeeType.temporary;
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
