part of 'employee_type_cubit.dart';

class EmployeeTypeState extends Equatable {
  const EmployeeTypeState(this.type);
  final EmployeeType type;
  @override
  List<Object> get props => [type];
}
