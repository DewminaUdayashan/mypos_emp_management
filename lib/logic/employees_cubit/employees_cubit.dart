import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/employee_model.dart';

import '../../data/repositories/employee_repository.dart';

part 'employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState> {
  EmployeesCubit(this.repository) : super(EmployeesLoading()) {
    _init();
  }
  final EmployeeRepository repository;

  _init() async {
    final res = await repository.fetchEmployees();
    res.fold(
      (exception) => emit(
        EmployeesLoadingError(exception.code!),
      ),
      (data) => emit(
        EmployeesLoaded(data),
      ),
    );
  }

  void refreshEmployees() {
    _init();
  }
}
