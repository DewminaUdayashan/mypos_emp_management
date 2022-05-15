import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../logic/employee_type/employee_type_cubit.dart';
import '../../shared/enums.dart';

class EmployeeTypeRadioGroup extends StatelessWidget {
  const EmployeeTypeRadioGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeTypeCubit, EmployeeTypeState>(
      builder: (context, state) {
        return Flex(
          direction: Axis.horizontal,
          children: [
            Radio(
              value: EmployeeType.permanent,
              groupValue: state.type,
              onChanged: (EmployeeType? type) {
                if (type != null) {
                  context.read<EmployeeTypeCubit>().selectEmployeeType(type);
                }
              },
            ),
            Text(
              'Permenent',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            SizedBox(width: 25.w),
            Radio(
              value: EmployeeType.temporary,
              groupValue: state.type,
              onChanged: (EmployeeType? type) {
                if (type != null) {
                  context.read<EmployeeTypeCubit>().selectEmployeeType(type);
                }
              },
            ),
            Text(
              'Temporary',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        );
      },
    );
  }
}
