part of 'add_employee_cubit.dart';

abstract class AddEmployeeState extends Equatable {
  const AddEmployeeState();

  @override
  List<Object> get props => [];
}

class AddEmployeeInitial extends AddEmployeeState {}

class AddingEmployee extends AddEmployeeState {}

class AddEmployeeSuccess extends AddEmployeeState {}
