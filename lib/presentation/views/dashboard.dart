import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../logic/employees_cubit/employees_cubit.dart';
import '../shared/helpers/dialog_helper.dart';
import 'add_employee.dart';
import 'widgets/employee_list_item.dart';
import 'widgets/search_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  late AnimationController bottomSheetController;
  late AnimationController mainAnimController;
  late AnimationController searchAnimController;
  late Animation tween;
  late Animation searchTween;
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    bottomSheetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    mainAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    searchAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    tween = Tween<double>(begin: 0, end: 100).animate(
      CurvedAnimation(
        parent: mainAnimController,
        curve: const Interval(0, 1, curve: Curves.ease),
      ),
    );
    searchTween = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(
        parent: mainAnimController,
        curve: const Interval(0, 1, curve: Curves.ease),
      ),
    );
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        mainAnimController.reverse();
        searchAnimController.forward();
      } else {
        mainAnimController.forward();
        searchAnimController.reverse();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    mainAnimController.stop();
    bottomSheetController.stop();
    searchAnimController.stop();
    bottomSheetController.dispose();
    mainAnimController.dispose();
    searchAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await DialogHelper.exitDialog(context) ?? false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              BlocBuilder<EmployeesCubit, EmployeesState>(
                builder: (context, state) {
                  if (state is EmployeesLoadingError) {
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
                          ),
                          SizedBox(height: 20.h),
                          const RefreshButton(),
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
                                  height:
                                      MediaQuery.of(context).size.height / 3,
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
                                ),
                                SizedBox(height: 20.h),
                                const RefreshButton(),
                              ],
                            ),
                          )
                        : FadeInUp(
                            child: ListView.builder(
                              controller: scrollController,
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
              AnimatedBuilder(
                  animation: searchTween,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                          0, -double.parse(searchTween.value.toString())),
                      child: child,
                    );
                  },
                  child: FadeIn(child: const SearchBar())),
              Positioned(
                bottom: 35.h,
                right: 35.w,
                child: AnimatedBuilder(
                  animation: tween,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, double.parse(tween.value.toString())),
                      child: child,
                    );
                  },
                  child: FloatingActionButton(
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
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton:
      ),
    );
  }
}

class RefreshButton extends StatelessWidget {
  const RefreshButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        context.read<EmployeesCubit>().refreshEmployees();
      },
      icon: const Icon(Icons.refresh_rounded),
      label: const Text('Refresh'),
    );
  }
}
