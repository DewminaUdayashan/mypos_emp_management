import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mypos_emp_management/data/employee_model.dart';
import 'package:mypos_emp_management/presentation/shared/helpers/dialog_helper.dart';

import '../../data/data_providers/employee_provider.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  AddEmployeeCubit(this.employeeProvider) : super(AddEmployeeInitial());
  final EmployeeProvider employeeProvider;

  Future<void> addEmployee(
      EmployeeModel emp, File? file, BuildContext context) async {
    emit(AddingEmployee());
    if (file != null) {
      String ext = file.path.split('/').last.split('.').last;
      final isUploadError = await employeeProvider.uploadImage(
        base64Image: base64Encode(file.readAsBytesSync()),
        fileName: '${emp.id}.$ext',
      );
      if (isUploadError == null) {
        final isError = await employeeProvider.addEmployee(emp.toMap());
        if (isError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Something went wrong.. ${isError.message}'),
            ),
          );
        } else {
          emit(AddEmployeeSuccess());
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Something went wrong.. ${isUploadError.message}'),
          ),
        );
      }
    }
  }
}
