import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/employees_cubit/employees_cubit.dart';
import 'add_employee.dart';
import 'widgets/employee_list_item.dart';
import 'widgets/search_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<EmployeesCubit, EmployeesState>(
          builder: (context, state) {
            if (state is EmployeesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is EmployeesLoadingError) {
              return Center(
                child: Text(state.message),
              );
            }
            final data = (state as EmployeesLoaded).employees;
            return Stack(
              children: [
                ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) =>
                      EmployeeListItem(index, data[index]),
                ),
                const SearchBar(),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
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
