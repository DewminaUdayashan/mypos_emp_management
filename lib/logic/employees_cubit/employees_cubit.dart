import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mypos_emp_management/data/employee_model.dart';

import '../../data/repositories/employee_repository.dart';

part 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  EmployeesCubit(this.repository) : super(EmployeesLoading());
  final EmployeeRepository repository;
}
