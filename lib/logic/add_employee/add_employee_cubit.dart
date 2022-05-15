import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/data_providers/employee_provider.dart';
import '../../data/employee_model.dart';

part 'add_employee_state.dart';

class AddEmployeeCubit extends Cubit<AddEmployeeState> {
  AddEmployeeCubit(this.employeeProvider) : super(AddEmployeeInitial());
  final EmployeeProvider employeeProvider;

  Future<void> addEmployee(
    EmployeeModel emp,
    File? file,
    BuildContext context, {
    bool isUpdate = false,
  }) async {
    emit(AddingEmployee());
    if (file != null) {
      String ext = file.path.split('/').last.split('.').last;
      await employeeProvider.uploadImage(
        base64Image: base64Encode(file.readAsBytesSync()),
        fileName: '${emp.id}.$ext',
      );
      emp.url = '${emp.id}.$ext';
    }
    if (isUpdate) {
      emit(AddingEmployee());

      final isError = await employeeProvider.updateEmployee(emp.toMap());
      isError.fold(
        (l) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Something went wrong.. ${l.code}'),
          ),
        ),
        (updated) {
          if (updated) {
            emit(
              const AddEmployeeSuccess(isUpdated: true),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Employee details updated...!',
                ),
                backgroundColor: Colors.greenAccent,
              ),
            );
          }
        },
      );
    } else {
      final isError = await employeeProvider.addEmployee(emp.toMap());
      if (isError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Something went wrong.. ${isError.message}'),
          ),
        );
      } else {
        emit(const AddEmployeeSuccess());
      }
    }
  }
}
