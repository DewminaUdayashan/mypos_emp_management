import 'package:dartz/dartz.dart';

import '../../presentation/shared/error/app_exceptions.dart';
import '../data_providers/employee_provider.dart';
import '../employee_model.dart';

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

  Future<Either<ApiException, List<EmployeeModel>>> searchEmp(
      String term) async {
    final res = await employeeProvider.search(term);
    return res.fold(
      (l) => Left(l),
      (data) => Right(data.map((e) => EmployeeModel.fromMap(e)).toList()),
    );
  }

  Future<Either<ApiException, bool>> delete(String id) async {
    final res = await employeeProvider.delete(id);
    return res.fold(
      (l) => Left(l),
      (data) => Right(data),
    );
  }
}
