import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octo_image/octo_image.dart';

import '../../../data/data_providers/employee_provider.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage(
    this.url, {
    Key? key,
  }) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      progressIndicatorBuilder: (context, progress) => Center(
        child: CircularProgressIndicator(
          value: progress?.cumulativeBytesLoaded.toDouble(),
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
        '$apiImages/$url',
      ),
      fit: BoxFit.cover,
    );
  }
}
