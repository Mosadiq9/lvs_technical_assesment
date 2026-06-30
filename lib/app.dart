import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/config/app_router.dart';

class AliveApp extends StatelessWidget {
  const AliveApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Setting up ScreenUtil with standard mobile dimensions
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X/11/12 size, matches standard designs
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Consumer(
          builder: (context, ref, _) {
            final goRouter = ref.watch(routerProvider);
            return MaterialApp.router(
              title: 'Alive App',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              routerConfig: goRouter,
            );
          },
        );
      },
    );
  }
}
