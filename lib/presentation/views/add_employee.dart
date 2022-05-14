import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../shared/enums.dart';
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
    return Scaffold(
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
              Center(
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20.r),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 800.w,
                          color: Colors.grey,
                        ),
                        Text(
                          'Add Image',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 33.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                      CustomTextFormField(controller: name, text: "Name"),
                      CustomTextFormField(controller: email, text: "Email"),
                      CustomTextFormField(controller: mobile, text: "Mobile"),
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
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          suffixIcon: const Icon(Icons.calendar_month_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const EmployeeTypeRadioGroup(),
                      SizedBox(height: 70.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(15.r),
                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: Colors.grey,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 45.w),
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
                                  print(employee.toString());
                                }
                              },
                              borderRadius: BorderRadius.circular(15.r),
                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: Colors.green,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 45.w),
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
    );
  }
}



/**
 *  TextFormField(
                        controller: id,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'ID',
                          labelText: 'Enter Employee ID',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        validator: (String? text) {
                          if (text != null && text.trim().isNotEmpty) {
                            return null;
                          }
                          return 'Field should not be empty';
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          labelText: 'Enter Employee Name',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          labelText: 'Enter Employee Email',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: 'Mobile Number',
                          labelText: 'Enter Employee Mobile Number',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
 */