import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {required this.controller, required this.text, Key? key})
      : super(key: key);
  final TextEditingController controller;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        TextFormField(
          controller: controller,
          textInputAction: TextInputAction.next,
          keyboardType: text == 'Email'
              ? TextInputType.emailAddress
              : text == 'Mobile' || text == 'ID'
                  ? TextInputType.phone
                  : TextInputType.name,
          maxLength: text == 'Mobile' ? 10 : null,
          inputFormatters: <TextInputFormatter>[
            if (text == 'Mobile')
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          decoration: InputDecoration(
            hintText: text,
            labelText: 'Enter Employee $text',
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
        SizedBox(height: text == 'Mobile' ? 10 : 20),
      ],
    );
  }
}
