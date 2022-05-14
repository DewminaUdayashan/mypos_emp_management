import 'package:dartz/dartz.dart';
import '../employee_model.dart';

import '../../presentation/shared/error/write_exception.dart';
import '../data_providers/employee_provider.dart';

class EmployeeRepository {
  EmployeeRepository(this.employeeProvider);
  final EmployeeProvider employeeProvider;

  Future<Either<ApiException, List<EmployeeModel>>> fetchEmployees() async {
    final res = await employeeProvider.fetchEmployees();
    return res.fold(
      (l) => Left(l),
      (data) => Right(data.map((e) => EmployeeModel.fromMap(e)).toList()),
    );
  }
}
