import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/employee_model.dart';
import '../../data/repositories/employee_repository.dart';
import '../../presentation/shared/helpers/dialog_helper.dart';

part 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  EmployeesCubit(this.repository) : super(EmployeesLoading()) {
    _init();
  }
  final EmployeeRepository repository;

  _init() async {
    emit(EmployeesLoading());
    final res = await repository.fetchEmployees();
    res.fold(
      (exception) => emit(
        EmployeesLoadingError(exception.code!),
      ),
      (data) {
        emit(EmployeesLoaded(data));
      },
    );
  }

  void refreshEmployees() {
    _init();
  }

  Future<void> search(String? term) async {
    if (term != null) {
      emit(EmployeesLoading());
      await Future.delayed(const Duration(seconds: 1));
      final res = await repository.searchEmp(term.trim());
      res.fold(
        (exception) => emit(
          EmployeesLoadingError(exception.code!),
        ),
        (data) => emit(EmployeesLoaded(data)),
      );
    }
  }

  Future<void> delete(context, int index) async {
    if (state is EmployeesLoaded) {
      final list = (state as EmployeesLoaded).employees;
      final emp = list[index];
      final bool? shouldDelete =
          await DialogHelper.shouldDelete(context, emp.name);
      if (shouldDelete != null && shouldDelete) {
        final res = await repository.delete(emp.autId);
        res.fold(
          (exception) => emit(
            EmployeesLoadingError(exception.code!),
          ),
          (removed) {
            if (removed) {
              refreshEmployees();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${emp.name} has been deleted..!'),
                ),
              );
            }
          },
        );
      }
    }
  }

  void employeeUpdated() {
    refreshEmployees();
  }
}
