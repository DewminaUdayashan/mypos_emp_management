import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../logic/employees_cubit/employees_cubit.dart';
import 'add_employee.dart';
import 'widgets/employee_list_item.dart';
import 'widgets/search_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController bottomSheetController;

  @override
  void initState() {
    bottomSheetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    super.initState();
  }

  @override
  void dispose() {
    bottomSheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<EmployeesCubit, EmployeesState>(
              builder: (context, state) {
                if (state is EmployeesLoadingError) {
                  print('errror');
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset(
                          'assets/error.json',
                          height: MediaQuery.of(context).size.height / 3,
                        ),
                        Text(
                          '${state.message} \n Please try again',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                fontSize: 60.sp,
                              ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  );
                } else if (state is EmployeesLoaded) {
                  final data = state.employees;
                  return data.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Lottie.asset(
                                'assets/empty.json',
                                height: MediaQuery.of(context).size.height / 3,
                              ),
                              Text(
                                'No Employees Found',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                      fontSize: 70.sp,
                                    ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )
                      : FadeInUp(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) => EmployeeListItem(
                              index,
                              data[index],
                              data.length - 1,
                              bottomSheetController,
                            ),
                          ),
                        );
                }
                return Center(
                  child: Lottie.asset(
                    'assets/search.json',
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                );
              },
            ),
            FadeIn(child: const SearchBar()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddEmployee(),
            ),
          );
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
