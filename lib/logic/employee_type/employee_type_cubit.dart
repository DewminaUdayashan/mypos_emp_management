import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../presentation/shared/enums.dart';

part 'employee_type_state.dart';

class EmployeeTypeCubit extends Cubit<EmployeeTypeState> {
  EmployeeTypeCubit() : super(const EmployeeTypeState(EmployeeType.permanent));

  selectEmployeeType(EmployeeType type) => emit(EmployeeTypeState(type));
}
