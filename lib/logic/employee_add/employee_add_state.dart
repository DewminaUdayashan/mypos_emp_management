part of 'employee_add_cubit.dart';

abstract class EmployeeAddState extends Equatable {
  const EmployeeAddState();

  @override
  List<Object> get props => [];
}

class EmployeeAddInitial extends EmployeeAddState {}

class EmployeeAdding extends EmployeeAddState {}

class EmployeeAdded extends EmployeeAddState {}

class EmployeeAddingError extends EmployeeAddState {}
