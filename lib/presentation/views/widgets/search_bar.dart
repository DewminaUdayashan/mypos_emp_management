import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../logic/employees_cubit/employees_cubit.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0.w,
        vertical: 40.0.h,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(100),
        elevation: 3,
        child: TextFormField(
          onChanged: (String? term) =>
              context.read<EmployeesCubit>().search(term),
          decoration: InputDecoration(
            hintText: 'Search',
            labelText: 'Try searching for employee',
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),
    );
  }
}
