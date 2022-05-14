import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/scheduler/ticker.dart';
import 'package:mypos_emp_management/presentation/views/widgets/employee_list_item.dart';
import 'package:mypos_emp_management/presentation/views/widgets/search_bar.dart';

import 'add_employee.dart';

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
        child: Stack(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: 30,
              itemBuilder: (context, index) => EmployeeListItem(index),
            ),
            const SearchBar(),
          ],
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