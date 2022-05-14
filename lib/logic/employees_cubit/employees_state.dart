part of 'employees_cubit.dart';

abstract class EmployeesState extends Equatable {
  const EmployeesState();

  @override
  List<Object> get props => [];
}

class EmployeesLoading extends EmployeesState {}

class EmployeesLoaded extends EmployeesState {
  final List<EmployeeModel> employees;

  const EmployeesLoaded(this.employees);
  @override
  List<Object> get props => [employees];
}

class EmployeesLoadingError extends EmployeesState {
  final String message;

  const EmployeesLoadingError(this.message);

  @override
  List<Object> get props => [message];
}
