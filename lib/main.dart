import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'presentation/shared/themes.dart';
import 'presentation/views/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2220),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'myPost Employee Management',
        theme: appTheme,
        home: child,
      ),
      child: const Dashboard(),
    );
  }
}
