import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0.w,
        vertical: 40.0.h,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(100),
        elevation: 3,
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'Search',
            labelText: 'Try searching for employee',
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      ),
    );
  }
}
