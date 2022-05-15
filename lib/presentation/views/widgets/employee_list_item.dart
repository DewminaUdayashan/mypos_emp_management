import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'emp_details_sheet.dart';
import 'profile_image.dart';
import 'package:octo_image/octo_image.dart';
import '../../../data/data_providers/employee_provider.dart';
import '../../../data/employee_model.dart';
import '../../../logic/employees_cubit/employees_cubit.dart';
import '../../shared/enums.dart';
import '../../shared/utils.dart';

const itemRadius = 30.0;

class EmployeeListItem extends StatelessWidget {
  const EmployeeListItem(
      this.index, this.employee, this.length, this.bottomSheetController,
      {Key? key})
      : super(key: key);
  final int index;
  final EmployeeModel employee;
  final int length;
  final AnimationController bottomSheetController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: index == length ? 220.w : 16.w,
        left: 20.w,
        right: 20.w,
        top: index == 0 ? 250.h : 0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(itemRadius.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(itemRadius.r),
        child: Material(
          child: InkWell(
            onTap: () {
              openDetailsSheet(context);
            },
            borderRadius: BorderRadius.circular(itemRadius.r),
            splashColor: Colors.blueGrey.withOpacity(.3),
            highlightColor: Colors.transparent,
            child: Ink(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 450.h,
                      child: employee.url == ''
                          ? Center(
                              child: Icon(
                                Icons.person_outline_rounded,
                                size: 100.w,
                                color: Colors.grey,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(itemRadius.r),
                              child: ProfileImage(
                                employee.url,
                                key: UniqueKey(),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 450.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'No :​ ${employee.id}',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Text(
                                    'Name​ : ${employee.name}',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Text(
                                    'Date of Birth​ : ${employee.dob}',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Text(
                                    'Mobile : ${employee.mobile}',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ]),
                          ),
                          Row(
                            children: [
                              ChoiceChip(
                                label: Text(
                                  employeeTypeToString(employee.type),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic,
                                      ),
                                ),
                                selected: true,
                                selectedColor:
                                    employee.type == EmployeeType.permenent
                                        ? Colors.greenAccent
                                        : Colors.blueGrey,
                              ),
                              const Spacer(),
                              const IconButton(
                                onPressed: null,
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<EmployeesCubit>()
                                      .delete(context, index);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PersistentBottomSheetController<dynamic> openDetailsSheet(
      BuildContext context) {
    return showBottomSheet(
      context: context,
      enableDrag: true,
      elevation: 4,
      backgroundColor: Colors.white,
      transitionAnimationController: bottomSheetController,
      builder: (context) => BottomSheet(
        animationController: bottomSheetController,
        enableDrag: true,
        elevation: 5,
        onClosing: () {},
        builder: (context) => EmpDetailsSheet(employee),
      ),
    );
  }
}
