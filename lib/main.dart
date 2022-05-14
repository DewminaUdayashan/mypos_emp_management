import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'data/data_providers/employee_provider.dart';
import 'data/repositories/employee_repository.dart';
import 'logic/employees_cubit/employees_cubit.dart';
import 'presentation/shared/themes.dart';
import 'presentation/views/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2220),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (child) => BlocProvider(
        create: (context) =>
            EmployeesCubit(EmployeeRepository(EmployeeProvider())),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'myPost Employee Management',
          theme: appTheme,
          home: child,
        ),
      ),
      child: const Dashboard(),
    );
  }
}
