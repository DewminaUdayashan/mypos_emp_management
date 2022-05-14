import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'employee_add_state.dart';

class EmployeeAddCubit extends Cubit<EmployeeAddState> {
  EmployeeAddCubit() : super(EmployeeAddInitial());
}
