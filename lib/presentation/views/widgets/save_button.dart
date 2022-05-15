import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/employee_model.dart';

import '../../../logic/add_employee/add_employee_cubit.dart';
import '../../../logic/image_cubit/image_cubit.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required this.callback,
    required this.formKey,
    required this.employee,
  }) : super(key: key);
  final Function callback;
  final GlobalKey<FormState> formKey;
  final EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    print(employee.toMap());

    return Expanded(
      child: InkWell(
        onTap: () {
          if (formKey.currentState!.validate()) {
            print(employee.toMap());
            // context.read<AddEmployeeCubit>().addEmployee(
            //       employee,
            //       context.read<ImageCubit>().state.file,
            //       context,
            //     );
          }
        },
        borderRadius: BorderRadius.circular(15.r),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: Colors.green,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 45.w),
            child: Center(
              child: Text('Save',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      )),
            ),
          ),
        ),
      ),
    );
  }
}
