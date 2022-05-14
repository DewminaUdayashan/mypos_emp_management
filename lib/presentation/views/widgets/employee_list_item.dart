import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octo_image/octo_image.dart';
import '../../../data/data_providers/employee_provider.dart';
import '../../../data/employee_model.dart';
import '../../../logic/employees_cubit/employees_cubit.dart';
import '../../shared/enums.dart';
import '../../shared/utils.dart';

const itemRadius = 30.0;

class EmployeeListItem extends StatelessWidget {
  const EmployeeListItem(this.index, this.employee, this.length, {Key? key})
      : super(key: key);
  final int index;
  final EmployeeModel employee;
  final int length;

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
            onTap: () {},
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
                              child: OctoImage(
                                progressIndicatorBuilder: (context, progress) =>
                                    Center(
                                  child: CircularProgressIndicator(
                                    value: progress?.cumulativeBytesLoaded
                                        .toDouble(),
                                  ),
                                ),
                                errorBuilder: (_, __, ___) => Center(
                                  child: Icon(
                                    Icons.person_outline_rounded,
                                    color: Colors.grey,
                                    size: 100.w,
                                  ),
                                ),
                                image: NetworkImage(
                                  '$apiImages/uploads/${employee.url}',
                                ),
                                fit: BoxFit.cover,
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
                                    '✔️​ ${employee.id}',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Text(
                                    '🙋‍♂️​ ${employee.name}',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Text(
                                    '🎂​ ${employee.dob}',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Text(
                                    '📱​ ${employee.mobile}',
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
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
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
}
