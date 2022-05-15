import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/data_providers/employee_provider.dart';
import '../../../logic/employees_cubit/employees_cubit.dart';
import 'profile_image.dart';
import '../../../data/employee_model.dart';
import '../../../logic/add_employee/add_employee_cubit.dart';
import '../../../logic/employee_type/employee_type_cubit.dart';
import '../../../logic/image_cubit/image_cubit.dart';
import '../../shared/utils.dart';
import 'custom_text_form_field.dart';
import 'employee_type_group.dart';

class EmpDetailsSheet extends StatefulWidget {
  const EmpDetailsSheet(
    this.employee, {
    Key? key,
  }) : super(key: key);
  final EmployeeModel employee;

  @override
  State<EmpDetailsSheet> createState() => _EmpDetailsSheetState();
}

class _EmpDetailsSheetState extends State<EmpDetailsSheet> {
  late EmployeeModel employee;
  late TextEditingController id = TextEditingController();
  late TextEditingController name = TextEditingController();
  late TextEditingController email = TextEditingController();
  late TextEditingController mobile = TextEditingController();
  late TextEditingController dob = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    employee = widget.employee;
    id.text = employee.id;
    name.text = employee.name;
    email.text = employee.email;
    mobile.text = employee.mobile;
    dob.text = employee.dob;
  }

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
        ),
        BlocProvider(
          create: (context) => ImageCubit(),
        ),
        BlocProvider(
          create: (context) => AddEmployeeCubit(EmployeeProvider()),
        ),
      ],
      child: Builder(builder: (context) {
        context.read<EmployeeTypeCubit>().selectEmployeeType(employee.type);
        return BlocListener<AddEmployeeCubit, AddEmployeeState>(
          listener: (context, state) {
            if (state is AddEmployeeSuccess) {
              if (state.isUpdated) {
                context.read<EmployeesCubit>().employeeUpdated();
              }
            }
            if (state is AddingEmployee) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Please wait...'),
              ));
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.4,
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 170.h,
                      width: double.infinity,
                      color: Colors.blue,
                      child: Center(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(18.0.r),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: InkWell(
                                  onTap: () {
                                    context.read<ImageCubit>().selectImage();
                                  },
                                  child: BlocBuilder<ImageCubit, ImageState>(
                                    builder: (context, state) {
                                      if (state.file != null) {
                                        return Image.file(state.file!);
                                      }
                                      return SizedBox(
                                        child: employee.url == ''
                                            ? Center(
                                                child: Icon(
                                                  Icons.person_outline_rounded,
                                                  size: 100.w,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            : ProfileImage(
                                                employee.url,
                                              ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Employee Details',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 50.sp,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(16.0.w),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              CustomTextFormField(controller: id, text: "ID"),
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
                              InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    final emp = EmployeeModel(
                                      autId: employee.autId,
                                      id: id.text,
                                      email: email.text,
                                      mobile: mobile.text,
                                      name: name.text,
                                      url: employee.url,
                                      dob: dob.text,
                                      type: context
                                          .read<EmployeeTypeCubit>()
                                          .state
                                          .type,
                                    );
                                    context
                                        .read<AddEmployeeCubit>()
                                        .addEmployee(
                                          emp,
                                          context.read<ImageCubit>().state.file,
                                          context,
                                          isUpdate: true,
                                        );
                                  }
                                },
                                borderRadius: BorderRadius.circular(15.r),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: Colors.green,
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 45.w),
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
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
