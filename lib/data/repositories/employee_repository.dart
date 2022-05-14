import '../data_providers/employee_provider.dart';

class EmployeeRepository {
  EmployeeRepository(this.employeeProvider);
  final EmployeeProvider employeeProvider;
}
