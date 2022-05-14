import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/data_providers/employee_provider.dart';
import '../../logic/add_employee/add_employee_cubit.dart';
import '../../logic/employees_cubit/employees_cubit.dart';
import 'widgets/image_placeholder.dart';
import '../../logic/image_cubit/image_cubit.dart';
import '../shared/enums.dart';
import '../shared/helpers/dialog_helper.dart';
import '../shared/utils.dart';
import 'widgets/custom_text_form_field.dart';

import '../../data/employee_model.dart';
import '../../logic/employee_type/employee_type_cubit.dart';
import 'widgets/employee_type_group.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController id = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    id.dispose();
    name.dispose();
    email.dispose();
    mobile.dispose();
    dob.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EmployeeTypeCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => ImageCubit(),
          lazy: true,
        ),
        BlocProvider(
          create: (context) => AddEmployeeCubit(EmployeeProvider()),
          lazy: true,
        ),
      ],
      child: Builder(builder: (context) {
        return BlocListener<AddEmployeeCubit, AddEmployeeState>(
          listener: (context, state) {
            if (state is AddingEmployee) {
              DialogHelper.loadingDialog(context);
            } else if (state is AddEmployeeSuccess) {
              context.read<EmployeesCubit>().refreshEmployees();
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
          child: WillPopScope(
            onWillPop: () async {
              return await DialogHelper.showAddEmployeeScreenLeftDialog(
                  context);
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Add Employee',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black87,
                      ),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: const BackButton(
                  color: Colors.black54,
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const ImagePlaceholder(),
                      const SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                          ),
                          child: Column(
                            children: [
                              CustomTextFormField(controller: id, text: "Id"),
                              CustomTextFormField(
                                  controller: name, text: "Name"),
                              CustomTextFormField(
                                  controller: email, text: "Email"),
                              CustomTextFormField(
                                  controller: mobile, text: "Mobile"),
                              TextFormField(
                                controller: dob,
                                onTap: () async {
                                  final selectedDob = await seletDOB(context);
                                  if (selectedDob != null) {
                                    dob.text = selectedDob;
                                  }
                                },
                                readOnly: true,
                                validator: (String? text) {
                                  if (text != null) return null;

                                  return 'Please select a date';
                                },
                                decoration: InputDecoration(
                                  hintText: 'Tap to select a date',
                                  labelText: 'Select Employee Birth Date',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  suffixIcon:
                                      const Icon(Icons.calendar_month_rounded),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const EmployeeTypeRadioGroup(),
                              SizedBox(height: 70.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(15.r),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          color: Colors.grey,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 45.w),
                                          child: Center(
                                            child: Text('Cancel',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      color: Colors.white,
                                                    )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          final employee = EmployeeModel(
                                            id: id.text,
                                            email: email.text,
                                            mobile: mobile.text,
                                            name: name.text,
                                            url: '',
                                            dob: dob.text,
                                            type: context
                                                .read<EmployeeTypeCubit>()
                                                .state
                                                .type,
                                          );
                                          context
                                              .read<AddEmployeeCubit>()
                                              .addEmployee(
                                                employee,
                                                context
                                                    .read<ImageCubit>()
                                                    .state
                                                    .file,
                                                context,
                                              );
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(15.r),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                          color: Colors.green,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 45.w),
                                          child: Center(
                                            child: Text('Save',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(
                                                      color: Colors.white,
                                                    )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 50.0),
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
      }),
    );
  }
}
